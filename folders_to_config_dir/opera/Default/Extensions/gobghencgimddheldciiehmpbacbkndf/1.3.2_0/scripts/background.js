var storage = WHO.extension.storage;
var background = 
{
	start : function()
	{

		this.parseSubject = /^\s*([^\n\r]+)/; // 一行目を切り取る→件名
		var windowPanel = null;//ウィンドウパネルの表示状態

		this.notes = JSON.parse(storage.getItem('notes'))||{};

		/**************************************************************************************/
		/* UI 生成 */

	//	WHO.sidebar;

		//------------------------------------------------------------------------------------//
		// コンテキストメニュー

		this.PastMenus = [];

		WHO.contextMenu.createItem(
		{
			contexts : ['selection'],//['page','frame']
			icon     : 'images/sidebar.png',
			title    : WHO.locale.get("Command::CopyToNotes"),
			onclick  : function(event)
			{

				background.addNote(
				{
					note:event.selectionText,
					url :event.pageURL,
				});

			}
		});

		WHO.contextMenu.createItem(
		{
			contexts : ['selection'],//['page','frame']
			icon     : 'images/sidebar.png',
			title    : WHO.locale.get("Command::AddCurrentTag"),
			onclick  : function(event)
			{

				background.addCurrentTag(event.selectionText);

			}
		});

		WHO.contextMenu.createItem(
		{
			contexts : ['editable'],//['page','frame']
			type     : "separator",
		});

		WHO.contextMenu.show();

		this.createPasteMenus();

		/**************************************************************************************/
		/* 通信ポート開放 */

		WHO.extension.addMessageListener('TaggingNotes',function(port,message)
		{

			if(message.method === "updateData")
			{
				background.notes = JSON.parse(storage.getItem('notes'))||{};
				background.createPasteMenus();
			}
			else
			// ノートを更新
			if(message.method === "importedData")
			{

				if(WHO.panel.port)
				{

					WHO.panel.port.postMessage("TaggingNotes",{method:"UpdateNotes"});
					background.notes = JSON.parse(storage.getItem('notes'))||{};
					background.createPasteMenus();

				}
				background.createPasteMenus();

			}
			else
			// サイドバーを閉じる
			if(message.method === "SetWindowPanel")
			{

				windowPanel = WHO.panel.port;

			}
			else
			// ウィンドウパネルを閉じる
			if(message.method === "CloseWindowPanel" && windowPanel)
			{

				windowPanel.tab.remove();//WHO.tabs
				windowPanel = null;

				//windowPanel.getParentTab(function(tab){tab.remove()});

			}

		});

		/**************************************************************************************/

	},

	save : function()
	{

		storage.setItem('notes',JSON.stringify(this.notes));

	},

	/* ペーストメニュー */

	createPasteMenus : function()
	{

		for(var i = 0,menu;menu = this.PastMenus[i];++i)
		{

			menu.remove(true);

		}
		this.PastMenus = [];

		for(var id in this.notes)
		{

			var note = this.notes[id];

			if(note.tags.indexOf("Reserved::ContextMenu") > -1 && note.note)
			{

				this.PastMenus.push(this.createPageMenu(note.note));

			}
		}
	},

	createPageMenu : function(note)
	{

		var subject     = (this.parseSubject.exec(note))[0];

		return WHO.contextMenu.createItem(
		{
			contexts : ['editable'],//['page','frame']
		//	icon     : 'images/sidebar.png',
			title    : subject,
			onclick  : function(event)
			{

				if(event.tab.port)
				{
					event.tab.port.postMessage('TaggingNotes',{method:"paste",text:note});
				}

			}
		});
	},

	/* ノートにコピー */

	addNote : function(note)
	{

		note.tags = JSON.parse(storage.getItem('selectedTags'))||[];

		if(WHO.panel.port)
		{

			WHO.panel.port.postMessage("TaggingNotes",{method:"AddNote",note:note});

		}
		else
		{

			//IDを作成
			var time = new Date().getTime();
			var id   = time - 1426248200000;

			if(note.tags.indexOf("Reserved::NoTags") > -1)
			{
				note.tags.splice(note.tags.indexOf("Reserved::NoTags"),1);
			}

			this.notes[id] =
			{
				note    : note.note,
				url     : note.url,
				created : time,
				updated : time,
				tags    : note.tags,
			};

			this.save();

			storage.setItem('sidebarParameters',JSON.stringify(
			{
				selectedNote : id,
			}));

			this.createPasteMenus();

		}

	},

	/* タグを追加する */

	addCurrentTag : function(tag)
	{

		if(WHO.panel.port)
		{

			WHO.panel.port.postMessage('TaggingNotes',{method:"AddCurrentTag",tag:tag});

		}
		else
		{
			var selectedTags  = JSON.parse(storage.getItem('selectedTags'))||[];//選択されたタグ

			//選択タグを追加
			if(selectedTags.indexOf(tag) < 0)
			{

				selectedTags.push(tag);
				storage.setItem('selectedTags',JSON.stringify(selectedTags));

			}

			var para          = JSON.parse(storage.getItem('sidebarParameters'))||{};

			if(para.selectedNote && this.notes[para.selectedNote])
			{

				if(this.notes[para.selectedNote].tags.indexOf(tag) < 0)
				{

					this.notes[para.selectedNote].tags.push(tag);
					this.save();

				}


			}
			else
			{

				AddNote(
				{
					note:"",
					url :"",
					tags:selectedTags
				});

			}

		}

	},

	/**************************************************************************************/
};

WHO.extension.addEventListener('ready',function()
{

	WHO.locale.load("configurations/lang.json",function()
	{
		background.start();
	});

});
