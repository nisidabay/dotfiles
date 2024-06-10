var storage = WHO.extension.storage;

/****************************************************************************************************/

/* ノート */

var TaggingNotes =
{
	start : function(dic)
	{

		var self = this;

		/* データの読み込み */

		this.dic = dic;

		var para           = JSON.parse(storage.getItem('sidebarParameters'))||{};

		this.notes         = JSON.parse(storage.getItem('notes'))||{};//ノートのデータ

		this.selectedTags  = JSON.parse(storage.getItem('selectedTags'))||[];//選択されたタグ

		this.length        = Object.keys(this.notes).length;          //ノートの数
		this.noteSelectors = {};//ノート選択オブジェクト
		this.currentTags   = [];//現在のタグオブジェクト
		this.selectedNote  = null;

		this.parseSubject  = /^\s*([^\n\r]+)/; // 一行目を切り取る→件名

		/* レイアウトを復元 */

		if(window.matchMedia("(max-width:480px)").matches){this.loadLayout();}
		window.matchMedia("(max-width:480px)").addListener(this.loadLayout());

		/* 予約タグを作成 */

		tagSelectors.selectors["Reserved::NoTags"] = new TagSelector("Reserved::NoTags");
		tagSelectors.selectors["Reserved::NoTags"].hideSelector();

		tagSelectors.selectors["Reserved::Trash"] = new TagSelector("Reserved::Trash");
		tagSelectors.selectors["Reserved::Trash"].hideSelector();

		tagSelectors.selectors["Reserved::ContextMenu"] = new TagSelector("Reserved::ContextMenu");
		tagSelectors.selectors["Reserved::ContextMenu"].hideSelector();

		/* 全てのノートを読み込む */

		this.createAllItem();


		/* 以前の状態に復帰する */

		for(var i = 0,tag;tag = this.selectedTags[i];++i)
		{
			if(tagSelectors.selectors[tag])
			{

				tagSelectors.selectors[tag].checkbox.checked = true;
				tagSelectors.selectors[tag].setStyle();

			}
			//存在しないタグが存在するとき
			else
			{
				this.selectedTags.splice(i,1);
				--i;
				this.saveParameters();
			}
		}

		this.searchNotes();

		if(para.selectedNote && this.noteSelectors[para.selectedNote])
		{

			this.noteSelectors[para.selectedNote].focus();

		}
		else
		{

			this.searchSuggestTags();

		}

		/* UI の設定 */

		ID('NewItem').addEventListener('click',function(){
			self.addNote(
			{
				note :dic["Note::Blank"],
				tags :self.selectedTags
			});
		});
		ID('NewTagSelected').addEventListener('click',function(e){self.newtagSelected();});
		ID('ExportSelected').addEventListener('click',function(e){self.exportSelected();});
		ID('RemoveSelected').addEventListener('click',function(e){self.removeSelected();});

		ID('Note').addEventListener('change',function(e)
		{
			self.saveEditedNote();
		});
		ID('NewTag').addEventListener('change',function(e)
		{

			self.addTagToCurrentNote(e.target.value);
			e.target.value = "";

		});

		//リサイズ
		window.addEventListener('mouseup',function(e)
		{
		//	console.log(ID('TagSelector').clientHeight);
			if(window.matchMedia("(max-width:480px)").matches)
			{
				storage.setItem('layout',JSON.stringify(
				{
					'TagSelector'  : ID('TagSelector').clientHeight,
					'ItemSelector' : ID('ItemSelector').clientHeight,
					'Note'         : ID('Note').clientHeight,
				}));
			}
		});

		return this;

	},

	//------------------------------------------------------------------------------------//

	/* 状態を保存 */

	saveParameters : function()
	{

		storage.setItem('sidebarParameters',JSON.stringify(
		{
			selectedNote : this.selectedNote?this.selectedNote.id:null,
		}));

		storage.setItem('selectedTags',JSON.stringify(this.selectedTags));

	},

	saveNotes : function()
	{

		storage.setItem('notes',JSON.stringify(this.notes));
		WHO.extension.postMessage('TaggingNotes',{method:"updateData"});

	},

	loadLayout : function()
	{

		var layout         = JSON.parse(storage.getItem('layout'))||{};
		if(layout.TagSelector)
		{
			ID('TagSelector').style.height = layout.TagSelector + "px";
		}
		if(layout.ItemSelector)
		{
			ID('ItemSelector').style.height = layout.ItemSelector + "px";
		}
		if(layout.Note)
		{
			ID('Note').style.height = layout.Note + "px";
		}

	},

	//------------------------------------------------------------------------------------//

	/* 全てのアイテムを作成 */

	createAllItem : function()
	{

		var alltags = [];

		var ids = Object.keys(TaggingNotes.notes).sort(function(a,b)
		{
			var A = (TaggingNotes.notes[a].note.match(/[^\s]/)||[""])[0];
			var B = (TaggingNotes.notes[b].note.match(/[^\s]/)||[""])[0];
			
			if(A>B)
			{
				return 1;
			}
			else
			if(A<B)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		});

		ids.forEach(function(id)//for(var id in this.notes)
		{

			var item = new NoteSelector(id,this.notes[id]);

			// タグセレクターにタグを追加
			if(item.tags && item.tags.length > 0)
			{
			//	tagSelectors.addTags(item.tags);
				alltags = alltags.concat(item.tags);
			}
			// タグセレクターに未分類タグを追加
			else
			{

				tagSelectors.addTags(["Reserved::NoTags"]);

			}

		},this);

		if(alltags.length > 0)
		{
			tagSelectors.addTags(alltags.sort());
		}

		// タグセレクターを再描画
		tagSelectors.setStyle();

	},

	/* 表示中の全てのノートに新しいタグを追加 */

	newtagSelected : function()
	{

		var newtag = "";
		var num = 0;

		while(!newtag || tagSelectors.selectors[newtag])
		{

			++num;
			newtag = this.dic["Tag::Reserved::NewTag"] + " " + num;

		}

		for(var id in this.notes)
		{

			var note = this.notes[id];
			var item = this.noteSelectors[id]

			if(item.isShown)
			{

				note.tags.push(newtag);

				tagSelectors.add(newtag);

			}

		}

		this.saveNotes();

		if(this.selectedNote)
		{

			this.selectedNote.focus();

		}

		this.searchNotes();
		this.searchSuggestTags();

		tagSelectors.setStyle();

		this.saveParameters();

	},

	/* 表示中の全てのノートを削除 */

	removeSelected : function()
	{
		//完全に削除するか確認→ゴミ箱タグはつけない
		if(confirm(this.dic["Note::RemoveSelected::confirm"]))
		{

			for(var id in this.noteSelectors)
			{

				if(this.noteSelectors[id].isShown)
				{
					//エディタをクリア
					if(this.selectedNote === this.noteSelectors[id])
					{

						this.clearEditor();

					}

					//クリア
					this.noteSelectors[id].clear();
				}

			}

			this.saveNotes();

			this.searchNotes();
			this.searchSuggestTags();
			tagSelectors.setStyle();

			this.saveParameters();

		}
	},

	/* 表示中の全てのノートを出力 */

	exportSelected : function()
	{

		var noteNodes = {};

		for(var id in this.noteSelectors)
		{

			if(this.noteSelectors[id].isShown)
			{

				noteNodes[id] = this.notes[id];

			}

		}

		downloadJsonData("TaggingNotes-" + this.selectedTags.join("-") + ".json",noteNodes);

	},

	//------------------------------------------------------------------------------------//

	/* ノートを追加 */

	addNote : function(note)
	{

		if(note.tags && note.tags.length > 0)
		{

			for(var i = 0,tag;tag = note.tags[i];++i)
			{

				tagSelectors.add(tag);      //タグセレクターにタグを追加

			}

		}
		else
		{

			tagSelectors.add("Reserved::NoTags");//タグセレクターに未分類を追加

		}

		var id = this.saveNote(null,
		{
			note:note.note,
			url :note.url,
			tags:note.tags,
		});

		this.noteSelectors[id].focus();//新しいノートを選択する

		ID('Note').focus();

	},

	/* 現在のノートを保存 */

	saveEditedNote : function()
	{

		// フォームからデータを取得
		var tags = this.getCurrentTags();
		var id   = this.saveNote(ID("NoteID").value,
		{
			note    : ID("Note").value,
			url     : ID("URL").value,
			tags    : tags,
		});

		ID("NoteID").value = id;//新規の時のみ

		tagSelectors.setStyle();//タグセレクターを再描画

		//現在のアイテム
		this.selectedNote = this.noteSelectors[id];//新規の時のみ必要
		this.saveParameters();

	},


	/* ノートを保存 */

	saveNote : function(id,note)
	{

		var time = new Date().getTime();

		//IDを作成
		if(!id)
		{

			id = time - 1426248200000;


		}

		var tags = note.tags.concat();

		if(tags.indexOf("Reserved::NoTags") > -1)
		{
			tags.splice(tags.indexOf("Reserved::NoTags"),1);
		}

		var created = (this.notes[id] && this.notes[id].created) ? this.notes[id].created : time;

		this.notes[id] =
		{
			note    : note.note,
			url     : note.url,
			tags    : tags,
			created : created,
			updated : time,
		}

		//新規アイテム
		if(!this.noteSelectors[id])
		{

			new NoteSelector(id,this.notes[id]);

		}
		else
		//更新
		{

			this.noteSelectors[id].update(this.notes[id]);

		}

		this.length = Object.keys(this.notes).length;

		this.saveNotes();//全てのノートをストレージに保存

		this.searchNotes();
		this.searchSuggestTags();

		return id;

	},

	/* 編集フォームをクリア */

	clearEditor : function()
	{

		ID('NoteID').value = "";
		ID('Note').value   = "";
		ID('URL').value    = "";
		this.clearCurrentTags();
		this.selectedNote = null;

	},

	//------------------------------------------------------------------------------------//

	/* 現在のタグリストを作成 */

	createCurrentTags : function(tags)
	{

		this.clearCurrentTags();//現在のタグをいったんクリア

		for(var i = 0,tag;tag = tags[i];++i)
		{

			new CurrentTag(tag);

		}

	},

	/* 現在のタグをクリア */

	clearCurrentTags : function()
	{

		for(var i = this.currentTags.length - 1,currentTag;currentTag = this.currentTags[i];--i)
		{

			currentTag.clear();

		}

	},

	/* 現在のタグのリストを取得 */

	getCurrentTags : function()
	{

		var currentTags = [];

		for(var i = 0,currentTag;currentTag = this.currentTags[i];++i)
		{

			currentTags.push(currentTag.tag);

		}

		return currentTags;

	},

	/* 現在のアイテムにタグを追加する */

	addTagToCurrentNote : function(tag)
	{

		//重複するタグが無い場合にのみ追加
		if((!this.selectedNote || this.selectedNote.tags.indexOf(tag) < 0) && tag !== "Reserved::NoTags")
		{

			//未分類を削除
			if(this.selectedNote && this.selectedNote.tags.length === 0)
			{

				tagSelectors.remove("Reserved::NoTags");

			}

			tagSelectors.add(tag);        //タグセレクターにタグを追加

			new CurrentTag(tag);  //タグリストにタグを作成

			this.saveEditedNote();        //フォームの変更内容からノートを保存

		}

	},

	//------------------------------------------------------------------------------------//

	/* ノートを検索する */

	searchNotes : function()
	{

		var activeTags = {};//選択可能なタグ
		var showNotes  = 0;//表示されたノートの数
		var trash      = (this.selectedTags.indexOf("Reserved::Trash") > -1);//選択タグにゴミ箱が含まれる

		for(var id in this.noteSelectors)
		{

			var item = this.noteSelectors[id];

			/* ゴミ箱を検索 */
			if(trash)
			{

				activeTags["Reserved::Trash"] = true;

				if(item.tags.indexOf("Reserved::Trash") > -1)
				{
					++showNotes;
					item.show();//ノートを表示
				}
				else
				{
					item.hide();//ノートを隠す
				}

			}
			else
			/* 未分類のノートを検索 */
			if(this.selectedTags.indexOf("Reserved::NoTags") > -1)
			{

				activeTags["Reserved::NoTags"] = true;

				if(item.tags.length === 0 || item.tags.indexOf("Reserved::NoTags") > -1)
				{
					++showNotes;
					item.show();//ノートを表示
				}
				else
				{

					item.hide();//ノートを隠す

				}

			}
			/* 選択タグからノートを検索 */
			else
			{

				var hidden = false;

				if(item.tags.indexOf("Reserved::Trash") > -1) //ゴミ箱は除外
				{
					hidden = true;
					item.hide();//ノートを隠す
				}
				else
				{
					/* 選択中のタグが全て含まれている物のみ表示 */
					for(var i = 0,tag;tag = this.selectedTags[i];++i)
					{

						if(item.tags.indexOf(tag) < 0)
						{
							hidden = true;
							item.hide();//ノートを隠す
							break;
						}

					}
				}

				/* 選択可能なタグを検索する */

				if(!hidden)
				{
					++showNotes;
					item.show();
					if(item.tags.length)
					{
						for(var i = 0,tag;tag = item.tags[i];++i)
						{
							activeTags[tag] = true;
						}
					}
					else
					{
						activeTags["Reserved::NoTags"] = true;
					}
				}

			}

		}

		if(this.selectedTags.length === 0 && tagSelectors.selectors["Reserved::Trash"].length)
		{
			activeTags["Reserved::Trash"] = true;
		}

		/* タグセレクターを表示 */

		// ノートが一つも無いとき
		if(this.length && showNotes === 0 && this.selectedTags.length)
		{

			// 選択タグを一つ取り除く
			if(tagSelectors.selectors[this.selectedTags[this.selectedTags.length - 1]])
			{

				tagSelectors.selectors[this.selectedTags[this.selectedTags.length - 1]].off();

			}

		}
		else
		{

			for(var tag in tagSelectors.selectors)
			{
				if(activeTags[tag])
				{
					tagSelectors.selectors[tag].showSelector();
				}
				else
				{
					tagSelectors.selectors[tag].hideSelector();
				}
			}

		}

	},

	/* お勧めタグを検索 */

	searchSuggestTags : function()
	{

		var suggestTags  = {};//関連するタグ
		var currentTags  = this.getCurrentTags();
		var relatedItems = 0;

		if(currentTags.length > 0)
		{

			for(var id in this.notes)
			{

				var item = this.notes[id];
				var hit  = 0;//現在のタグと同じタグの数

				//現在のタグと同じタグを持つノートを検索
				for(var i = 0,tag;tag = currentTags[i];++i)
				{

					if(item.tags.indexOf(tag) > -1)
					{

						++hit;

					}

				}

				if(hit)
				{
					++relatedItems;
					for(var i = 0,tag;tag = item.tags[i];++i)
					{
						//関連するタグに現在のタグ以外のタグを追加
						// hit * 2 / (currentTags.length + item.tags) * 100(%) : ノート同士の関連度合い
						//suggestTags[tag] / tagSelectors.selectors[tag].length(%) : タグの関連度合い
						//tagSelectors.selectors[tag].length / relatedItems(%) : タグの重要度
						if(currentTags.indexOf(tag) < 0 && !tagSelectors.selectors[tag].isReserved)
						{
							suggestTags[tag] = (suggestTags[tag]||0) + (hit * 2 / (currentTags.length + item.tags.length) * 100);//最大値 100 * relatedItems
						}

					}
				}
			}

		}

		if(Object.keys(suggestTags).length === 0)
		{

			relatedItems = 0;
			for(var id in this.notes)
			{

				var item = this.notes[id];
				var allNodes = 0;

				//タグのノード数をカウント
				for(var i = 0,tag;tag = item.tags[i];++i)
				{

					if(!tagSelectors.selectors[tag].isReserved)
					{
						allNodes = allNodes + tagSelectors.selectors[tag].length;//この
					}

				}

				//タグのノード数をカウント
				for(var i = 0,tag;tag = item.tags[i];++i)
				{

					if(currentTags.indexOf(tag) < 0 && !tagSelectors.selectors[tag].isReserved)
					{
						suggestTags[tag] = (suggestTags[tag]||0) + (tagSelectors.selectors[tag].length / allNodes * 100);//関連するタグの数
					}

				}

			}

		}

		/* お勧めタグを表示 */

		var threshold = Object.keys(suggestTags).length - 1;//表示の敷居値 1 : 0.01%

		for(var tag in tagSelectors.selectors)
		{

			// 関連するタグ
			if(relatedItems && suggestTags[tag] && parseInt(suggestTags[tag] / relatedItems * 100) >= threshold)//最大値 10000
			{

				tagSelectors.selectors[tag].showSuggest(parseInt(suggestTags[tag] / relatedItems) + 10);

			}
			else
			// 関連するタグがないとき
			if(!relatedItems && suggestTags[tag] && parseInt(suggestTags[tag] / tagSelectors.selectors[tag].length * 10) >= threshold)//タグをお勧めするのはタグが20個まで
			{

				tagSelectors.selectors[tag].showSuggest(parseInt(suggestTags[tag] / tagSelectors.selectors[tag].length / 5) + 10);

			}
			else
			{

				tagSelectors.selectors[tag].hideSuggest();

			}

		}

		if(currentTags.indexOf("Reserved::ContextMenu") < 0)
		{

			tagSelectors.selectors["Reserved::ContextMenu"].showSuggest();

		}

	},

};

/****************************************************************************************************/

/* タグセレクター */

var tagSelectors =
{

	length : 0,

	// 生成されたセレクターの数

	selectors : {},

	/* 複数のタグを追加する（再描画無し）*/

	addTags : function(tags)
	{

		for(var i = 0,tag;tag = tags[i];++i)
		{

			++this.length;

			if(!this.selectors[tag])
			{

				new TagSelector(tag);

			}

			++this.selectors[tag].length;

		}

	},

	/* タグを追加する（再描画有り）*/

	add  : function(tag)
	{

		++this.length;

		if(!this.selectors[tag])
		{

			new TagSelector(tag);

		}

		this.selectors[tag].add();

	},

	/* タグを削減する（再描画有り）*/

	remove : function(tag)
	{

		--this.length;

		if(this.selectors[tag].remove() === 0)
		{

			if(TaggingNotes.selectedTags.indexOf(tag) > -1)
			{
				TaggingNotes.selectedTags.splice(TaggingNotes.selectedTags.indexOf(tag),1);
			}

			if(this.selectors[tag].isReserved)
			{

				this.selectors[tag].checkbox.checked = false;

			}
			else
			{
				ID('TagSelector').removeChild(this.selectors[tag].li);
				ID('TagSuggest').removeChild(this.selectors[tag].suggest);

				delete this.selectors[tag];
			}

		}

	},

	/* 全てのセレクターを再描画する */

	setStyle : function()
	{
		for(var tag in this.selectors)
		{

			this.selectors[tag].setStyle();

		}
	},

};

/****************************************************************************************************/

/* タグセレクターのタグ */

var TagSelector = function(tag)
{

	var self = this;

	var li = document.createElement('li');
		li.setAttribute('data-tag',tag);

	var label = document.createElement('label');
		li.appendChild(label);

	var checkbox = document.createElement('input');
		checkbox.setAttribute('type',"checkbox");
		checkbox.setAttribute('data-tag',tag);

		label.appendChild(checkbox);

	var span = document.createElement('span');

		span.appendChild(document.createTextNode(TaggingNotes.dic["Tag::"+tag]||tag));
	//	span.setAttribute('contenteditable',"false");

		li.addEventListener('keydown',function(e){if(e.keyCode === 13){self.enterEdit();e.preventDefault();}});

		checkbox.addEventListener('change',function(e){self.toggle(e.target.checked);});

		span.addEventListener('contextmenu',function(e){self.selectAll();});
		span.addEventListener('input',function(e){self.checkRemoved(this.textContent);});
	//	span.addEventListener('change',function(e){/*self.checkEdited(this.textContent);*/}); // span では発生しない : change はフォームのみ
		span.addEventListener('blur',function(e)
		{
			self.checkEdited(this.textContent);
		});

		label.appendChild(span);

	ID('TagSelector').appendChild(li);


	var suggest = document.createElement('li');
		suggest.setAttribute('value',tag);
		suggest.appendChild(document.createTextNode(TaggingNotes.dic["Tag::"+tag]||tag));
		suggest.addEventListener('click',function(e){TaggingNotes.addTagToCurrentNote(self.tag);});

	ID('TagSuggest').appendChild(suggest);

	this.tag      = tag;
	this.length   = 0;//適用されているノートの数
	this.isEdit   = false;	//編集モードかどうか
	this.isReserved = (["Reserved::NoTags","Reserved::Trash","Reserved::ContextMenu"].indexOf(this.tag) > -1)//特殊タグかどうか

	this.li       = li;
	this.checkbox = checkbox;
	this.suggest  = suggest;
	this.text     = span;

	tagSelectors.selectors[tag] = this;

	return this;

};
TagSelector.prototype.selectAll = function()
{

	// 特殊タグの場合は編集禁止
	if(!this.isReserved)
	{

		this.text.setAttribute('contenteditable',"true");//

		var rng = document.createRange();
		rng.selectNodeContents(this.text);
		document.getSelection().removeAllRanges();
		document.getSelection().addRange(rng);

	}

};

/* 編集モードにする */

TagSelector.prototype.enterEdit = function()
{

	// 特殊タグの場合は編集禁止
	if(!this.isReserved)
	{

		this.isEdit = true;

		this.text.setAttribute('contenteditable',"true");//
		this.text.focus();

	}

};

/* タグを削除するか確認する */

TagSelector.prototype.checkRemoved = function(text)
{

	if(!this.isEdit && this.tag !== text && !text && !this.isReserved)
	{

		this.removeFromAllNotes();

	}

};

/* 編集内容を確認する */

TagSelector.prototype.checkEdited = function(newTag)
{

	this.text.setAttribute('contenteditable',"false");//

	// 特殊タグの場合は編集禁止
	if(this.isReserved)
	{

		this.text.textContent = TaggingNotes.dic["Tag::" + this.tag];

	}
	else
	if(!this.isEdit)
	{

		this.text.textContent = this.tag;

	}
	else
	if(newTag !== this.tag)
	{

		if(newTag)
		{

			this.update(newTag);

		}
		else
		{

			this.removeFromAllNotes();

		}

	}

	this.isEdit = false;

};

/* タグの内容を変更 */

TagSelector.prototype.update = function(newTag)
{

	//全てのノートのタグを書き換える
	for(var id in TaggingNotes.notes)
	{

		var note = TaggingNotes.notes[id];
		var oldIdx = note.tags.indexOf(this.tag);
		var newIdx = note.tags.indexOf(newTag);

		if(oldIdx > -1)
		{

			if(newIdx < 0)
			{

				note.tags[oldIdx] = newTag;

				tagSelectors.remove(this.tag);
				tagSelectors.add(newTag);

			}
			else
			{

				note.tags.splice(oldIdx,1);

				tagSelectors.remove(this.tag);

			}

		}

	}

	TaggingNotes.saveNotes();

	if(TaggingNotes.selectedNote)
	{

		TaggingNotes.selectedNote.focus();

	}

	TaggingNotes.searchNotes();
	TaggingNotes.searchSuggestTags();

	TaggingNotes.saveParameters();

};

/* タグを全てのノートから削除 */

TagSelector.prototype.removeFromAllNotes = function()
{

	if(confirm(TaggingNotes.dic['Tag::RemoveFromAllNotes'] + " : " + this.tag))
	{

		for(var id in TaggingNotes.notes)
		{

			var note = TaggingNotes.notes[id];
			var idx  = note.tags.indexOf(this.tag);

			if(idx > -1)
			{

				note.tags.splice(idx,1);

				tagSelectors.remove(this.tag);

				//未分類タグを追加
				if(note.tags.length === 0)
				{
					tagSelectors.add("Reserved::NoTags");
				}

			}

		}

		TaggingNotes.saveNotes();

		if(TaggingNotes.selectedNote)
		{

			TaggingNotes.selectedNote.focus();

		}

		TaggingNotes.searchNotes();
		TaggingNotes.searchSuggestTags();

		TaggingNotes.saveParameters();

	}
	else
	{

		this.text.textContent = this.tag;

	}

};

/* このタグが適用されているノートをカウントアップ */

TagSelector.prototype.add = function()
{
	++this.length;
	this.setStyle();

	return this.length;

};
TagSelector.prototype.remove = function()
{
	--this.length;
	this.setStyle();

	return this.length;

};

/* タグセレクターを表示する */

TagSelector.prototype.showSelector = function()
{
//	this.li.style.visibility = "";
	this.li.style.display = "";
};
TagSelector.prototype.hideSelector = function()
{
//	this.li.style.visibility = "hidden";
	this.li.style.display = "none";
};

/* お勧めタグを表示する */

TagSelector.prototype.showSuggest = function(size)
{
	this.suggest.style.display = "";

	if(size)
	{
		this.suggest.style.fontSize = size + "px";
	}

	if(size > 20)
	{
		this.suggest.style.color = "#fcc";
	}
	else
	if(size > 15)
	{
		this.suggest.style.color = "#fff";
	}
	else
	if(size > 13)
	{
		this.suggest.style.color = "#ccf";
	}
	else
	if(size > 11)
	{
		this.suggest.style.color = "#ccc";
	}
	else
	{
		this.suggest.style.color = "#999";
	}

};
TagSelector.prototype.hideSuggest = function()
{
	this.suggest.style.display = "none";
};

/* タグを選択をオンにする */

TagSelector.prototype.on = function()
{

	this.checkbox.checked = true;

	var idx  = TaggingNotes.selectedTags.indexOf(this.tag);
	var tidx = TaggingNotes.selectedTags.indexOf("Reserved::Trash");

	if(idx < 0 && tidx < 0)
	{

		var nidx = TaggingNotes.selectedTags.indexOf("Reserved::NoTags");
		if(nidx > -1)
		{
			TaggingNotes.selectedTags.splice(nidx,1);
		}

		TaggingNotes.selectedTags.push(this.tag);

		/* 再検索 */

		TaggingNotes.searchNotes();

		this.setStyle();

		/* 状態保存 */

		TaggingNotes.saveParameters();

	}

};

/* タグの選択をオフにする */

TagSelector.prototype.off = function()
{

	this.checkbox.checked = false;

	var idx = TaggingNotes.selectedTags.indexOf(this.tag);

	if(idx > -1)
	{

		TaggingNotes.selectedTags.splice(TaggingNotes.selectedTags.indexOf(this.tag),1);

		/* 再検索 */

		TaggingNotes.searchNotes();

		this.setStyle();

		/* 状態保存 */

		TaggingNotes.saveParameters();

	}

};

/* タグの選択を切り替える */

TagSelector.prototype.toggle = function(checked)
{

	var tag = this.tag;

//	this.text.setAttribute('contenteditable',"true");//

	// 検索条件にタグを追加
	if(checked)
	{

		this.on();

	}
	// 検索条件からタグを削除
	else
	{

		this.off();

	}

};

/* タグのスタイルを変更する */

TagSelector.prototype.setStyle = function()
{

	var size = this.length;

	var per = parseInt(size/TaggingNotes.length*500);

	if(size === 1)
	{
		this.li.style.fontSize   = "0.5em";
		this.li.style.color      = "#666";
		this.li.style.background = "#000";
		this.li.style.fontWeight = "100";
	}
	else
	if(per < 2)//0%
	{
		this.li.style.fontSize   = "0.8em";
		this.li.style.color      = "#666";
		this.li.style.background = "#444";
		this.li.style.fontWeight = "150";
	}
	else
	if(per < 5)//1%
	{
		this.li.style.fontSize   = "1." + (per - 2) + "em";//8-10px
		this.li.style.color      = "#333";
		this.li.style.background = "#999";
		this.li.style.fontWeight = "200";
	}
	else
	if(per < 10)//2%
	{
		this.li.style.fontSize   = "1." + (per - 2) + "em";//11-15px
		this.li.style.color      = "#000";
		this.li.style.background = "#b99";
		this.li.style.fontWeight = "250";
	}
	else
	if(per < 25)//青:5%
	{
		this.li.style.fontSize   = "1.8em";
		this.li.style.color      = "#000";
		this.li.style.background = "#077";
		this.li.style.fontWeight = "300";
	}
	else
	if(per < 50)//橙:10%
	{
		this.li.style.fontSize   = "2.0em";
		this.li.style.color      = "#ccc";
		this.li.style.background = "#d60";
		this.li.style.fontWeight = "400";
	}
	else
	if(per < 100)//紺:20%
	{
		this.li.style.fontSize   = "2.5em";
		this.li.style.color      = "#ff0";
		this.li.style.background = "#03f";
		this.li.style.fontWeight = "600";
	}
	else
	if(per < 250)//緑:50%
	{
		this.li.style.fontSize   = "3em";
		this.li.style.color      = "#f00";
		this.li.style.background = "#9c6";
		this.li.style.fontWeight = "700";
	}
	else//赤
	{
		this.li.style.fontSize   = "5.0em";
		this.li.style.color      = "#6f6";
		this.li.style.background = "#c00";
		this.li.style.fontWeight = "900";
	}

	if(this.tag === "Reserved::Trash")
	{
		this.li.style.color      = "#000";
		this.li.style.background = "#f00";
	}
	else
	if(this.tag === "Reserved::NoTags")
	{
		this.li.style.color      = "#000";
		this.li.style.background = "#0ff";
	}
	else
	if(this.tag === "Reserved::ContextMenu")
	{
		this.li.style.color      = "#000";
		this.li.style.background = "#0f0";
	}

	if(this.checkbox.checked)
	{

		this.li.style.border     = "1px inset #fff";
		this.li.style.color      = "#ffe";
		this.li.style.background = "#df6";
		this.li.style.textShadow = "0 0 10px #000";

	}
	else
	{

		this.li.style.border     = "";
		this.li.style.textShadow = "";

	}

};

/****************************************************************************************************/

/* ノート選択肢 */

var NoteSelector = function(id,note)
{

	var self = this;

	this.id   = id;

	var li = document.createElement('li');
		li.setAttribute('id',"NoteItem_" + id);
		li.setAttribute('contenteditable',"true");

		li.addEventListener('focus',function(e){self.focus();},false);
		li.addEventListener('keydown',function(){self.selectAll();});
	//	li.addEventListener('select',function(e){self.cancelSelect(e);},false);
		li.addEventListener('contextmenu',function(e){self.selectAll(e);});
		li.addEventListener('input',function(e){self.checkEdited(e);},false);
		li.addEventListener('copy',function(e){self.copy();},false);
		li.addEventListener('cut',function(e){self.copy();self.remove();},false);
	//	li.addEventListener('paste',function(e){alert("paste");},false);
		li.addEventListener('dblclick',function(e){self.openLink();})
		li.addEventListener('keydown',function(e){if(e.keyCode === 13){self.focus();e.preventDefault();}});

	ID('ItemSelector').appendChild(li);

	this._item  = li;

	this.isShown = true;

	this.update(note);

	TaggingNotes.noteSelectors[id] = this;

	return this;

};

/* このノートを表示する */

NoteSelector.prototype.show = function()
{

	this._item.style.display = "";
	this.isShown = true;

};

/* このノートを隠す */

NoteSelector.prototype.hide = function()
{

	this._item.style.display = "none";
	this.isShown = false;

};

/* このノートの内容を更新 */

NoteSelector.prototype.update = function(note)
{
	var self = this;

	this.note        = note.note||"";
	this.url         = note.url||"";
	this.tags        = note.tags||[];
	this.subject     = (TaggingNotes.parseSubject.exec(note.note||note.url|| "ID:" + this.id)||[note.url|| "ID:" + this.id])[0];

	this._item.textContent = this.subject;
	this._item.setAttribute('class',this.url?"bookmark":"note");

};

/* リンクを開く */

NoteSelector.prototype.openLink = function()
{

	if(this.url)
	{
		window.open(this.url);
	}

};
/* このノートにフォーカスして編集を開始 */

NoteSelector.prototype.focus = function()
{

	if(TaggingNotes.selectedNote)
	{
		TaggingNotes.selectedNote._item.style.backgroundColor = "";
		TaggingNotes.selectedNote._item.style.color = "";
	}

	this._item.style.backgroundColor = "#339";
	this._item.style.color           = "#fff";

	TaggingNotes.selectedNote = this;

	/* 編集フォームに内容を表示する */

	ID('NoteID').value = this.id;
	ID('Note').value   = this.note;
	ID('URL').value    = this.url;

	TaggingNotes.createCurrentTags(this.tags);//タグ

	/* 再検索 */

	TaggingNotes.searchSuggestTags();

	/* 状態を保存 */

	TaggingNotes.saveParameters();

};

/* 全て選択 */

NoteSelector.prototype.selectAll = function()
{

	var rng = document.createRange();
	rng.selectNodeContents(this._item);
	document.getSelection().removeAllRanges();
	document.getSelection().addRange(rng);

};

/* このノートの内容をコピーする */

NoteSelector.prototype.copy = function(e)
{

	ID('Note').focus(); //編集フォームに移動
	ID('Note').select();//全て選択
	document.execCommand("copy");// "copy","cut"// Firefox で動かず

};

/* 編集内容を確認 */

NoteSelector.prototype.checkEdited = function()
{

	//内容が空になったらこのノートを削除
	if(this._item.textContent === "")
	{

		this.remove();

	}
	else
	//部分的変更は元に戻す
	{

		this._item.textContent = this.subject;
		ID('Note').focus();

	}

};

/* このノートを削除する */

NoteSelector.prototype.remove = function()
{

	//ゴミ箱タグが付いているときは完全に削除
	if(this.tags.indexOf("Reserved::Trash") > -1)
	{

		this.clear();//完全に削除

		TaggingNotes.clearEditor();               //編集フォームをクリア

	}
	//ゴミ箱タグを付ける
	else
	{

		TaggingNotes.addTagToCurrentNote("Reserved::Trash");

	}

	TaggingNotes.clearEditor();

	/* 全てのノートを保存 */

	TaggingNotes.saveNotes();

	/* 再検索 */

	TaggingNotes.searchNotes();
	TaggingNotes.searchSuggestTags();

	/* 状態の保存 */

	TaggingNotes.saveParameters();

};

/* このノートオブジェクトをクリア */

NoteSelector.prototype.clear = function()
{

	//タグセレクターからこのアイテムのタグを取り除く
	if(this.tags.length)
	{
		for(var i = 0,tag;tag = this.tags[i];++i)
		{

			tagSelectors.remove(tag);

		}
	}
	else
	{
		tagSelectors.remove("Reserved::NoTags");
	}

	ID('ItemSelector').removeChild(this._item);   //リストからこのアイテムを削除

	delete TaggingNotes.notes[this.id];          //データからこのアイテムを削除
	delete TaggingNotes.noteSelectors[this.id];

	TaggingNotes.length = Object.keys(TaggingNotes.notes).length;

};

/****************************************************************************************************/

/* 現在のタグを作成 */

var CurrentTag = function(tag)
{

	var self = this;

	var li = document.createElement('li');
		li.appendChild(document.createTextNode(TaggingNotes.dic["Tag::"+tag]||tag));
		li.setAttribute('data-tag',tag);
		li.setAttribute('contenteditable',"true");

		li.addEventListener('click',function(){self.selectAll();});
		li.addEventListener('focus',function(){self.selectAll();});
		li.addEventListener('keyup',function(){self.selectAll();});
		li.addEventListener('contextmenu',function(e){self.selectAll();});
		li.addEventListener('input',function(){self.checkEdited();});

	ID('Tags').insertBefore(li,ID('NewTag').parentNode);

	this._item = li;
	this.tag = tag;

	TaggingNotes.currentTags.push(this);

	return this;

};

/* 全て選択 */

CurrentTag.prototype.selectAll = function()
{

	var rng = document.createRange();
	rng.selectNodeContents(this._item);
	document.getSelection().removeAllRanges();
	document.getSelection().addRange(rng);

};

/* 編集内容の確認 */

CurrentTag.prototype.checkEdited = function()
{

	// 現在のノートからこのタグを削除
	if(this._item.textContent === "")
	{

		this.remove();

	}
	//編集をキャンセル
	else
	{

		this._item.textContent = this.tag;
		e.preventDefault();

	}

};

/* 現在のノートからこのタグを削除 */

CurrentTag.prototype.remove = function()
{

		this.clear();

		tagSelectors.remove(this.tag);

		//未分類タグを追加
		if(TaggingNotes.selectedNote && TaggingNotes.selectedNote.tags.length === 0)
		{

			tagSelectors.add("Reserved::NoTags");

		}

		TaggingNotes.saveEditedNote();

		/* 状態の保存 */

		TaggingNotes.saveParameters();

};

/* このタグオブジェクトをクリアする */

CurrentTag.prototype.clear = function()
{

	for(var i = 0,tag;tag = TaggingNotes.currentTags[i];++i)
	{

		if(tag.tag === this.tag)
		{
			TaggingNotes.currentTags.splice(i,1);
		}

	}

	ID('Tags').removeChild(this._item);

};

/****************************************************************************************************/

/* メイン */

WHO.locale.translate("configurations/lang.json",function(dic)
{

	TaggingNotes.start(dic);

	WHO.extension.addMessageListener('TaggingNotes',function(message)
	{

		if(message.method === "AddNote")
		{

			TaggingNotes.addNote(message.note);

		}
		else
		if(message.method === "AddCurrentTag")
		{

			TaggingNotes.addTagToCurrentNote(message.tag);
			tagSelectors.selectors[message.tag].on();

		}
		else
		if(message.method === "UpdateNotes")
		{

			window.location.reload();

		}

	});

	// サイドバーを閉じる
	ID('OpenInWindow').addEventListener('click',function(e)
	{

		window.open("sidebar.html#Window","_blank");
		WHO.panel.hide();
		e.preventDefault();

	})

	// 自分はウィンドウパネルだよ
	if(window.location.hash === "#Window")
	{

		ID('OpenInWindow').parentNode.removeChild(ID('OpenInWindow'));
		WHO.extension.postMessage('TaggingNotes',{method:"SetWindowPanel"});

	}
	// ウィンドウパネルを閉じる
	else
	{
	
		WHO.extension.postMessage('TaggingNotes',{method:"CloseWindowPanel"});
	
	}

});
/****************************************************************************************************/
