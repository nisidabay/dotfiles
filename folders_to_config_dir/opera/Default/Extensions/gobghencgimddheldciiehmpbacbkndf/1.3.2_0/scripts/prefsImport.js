var Import = function()
{

	var self = this;

	this.notes = JSON.parse(storage.getItem('notes'))||{};

	ID('RestoreNotes').addEventListener('change',function(e){self.loadTaggingNotes(e)});
	ID('ImportPrestoAdr').addEventListener('change',function(e){self.loadPrestoAdr(e)});
	ID('ImportVivaldi').addEventListener('change',function(e){self.loadVivaldi(e)});

	this.addNote = function(id,note)
	{

		this.notes[id] = 
		{
			note    : note.note,
			url     : note.url,
			created : note.created,
			updated : note.updated,
			tags    : note.tags
		};

	};

	this.saveData = function()
	{

		storage.setItem('notes',JSON.stringify(this.notes));

		WHO.extension.postMessage('TaggingNotes',{method:"importedData"});

	};

	this.loadTaggingNotes = function(e)
	{

		var reader = new FileReader();

		reader.onload = function(e)
		{
			try
			{
				self.parseTaggingNotes(JSON.parse(e.target.result||""));
			}
			catch(err)
			{
				alert("Error! It's not TaggingNotes.");
			}
		}

		if(ID('RestoreNotes').files[0])
		{
			reader.readAsText(ID('RestoreNotes').files[0], "utf-8");
		}

	};

	this.parseTaggingNotes = function(notes)
	{

		this.notes = notes;
		this.saveData();

	};

	this.loadPrestoAdr = function(e)
	{

		var reader = new FileReader();

		reader.onload = function(e)
		{
			try
			{
				self.parsePrestoAdr(e.target.result);
			}
			catch(err)
			{
				alert("Error! It's not Presto Notes.");
			}
		}

		if(ID('ImportPrestoAdr').files[0])
		{
			reader.readAsText(ID('ImportPrestoAdr').files[0], "utf-8");
		}

	};

	this.loadVivaldi = function(e)
	{

		var reader = new FileReader();

		reader.onload = function(e)
		{
			try
			{
				self.parseVivaldi(JSON.parse(e.target.result||""));
			}
			catch(err)
			{
				alert("Error! It's not Vivaldi Notes.");
			}
		}

		if(ID('ImportVivaldi').files[0])
		{
			reader.readAsText(ID('ImportVivaldi').files[0], "utf-8");
		}

	};

	this.parseVivaldi = function(vNotes)
	{

		this.notes = JSON.parse(storage.getItem('notes'))||{};

		var tags = [/*"Imported","VivaldiNotes"*/];

		this.parseVivaldiChildren(vNotes.children,tags);

		this.saveData();

	};

	this.parseVivaldiChildren = function(vNotes,tags)
	{

		for(var i = 0,child;child = vNotes[i];++i)
		{

			if(child.type === "folder")
			{

				this.parseVivaldiChildren(child.children,tags.concat(child.subject));

			}
			else
			{

				this.addNote("V" + child.id,
				{
					note    : child.content,
					url     : child.url,
					created : child.date_added,
					updated : child.date_added,
					tags    : tags
				});

			}

		}

	};

	this.parsePrestoAdr = function(file)
	{

		this.notes = JSON.parse(storage.getItem('notes'))||{};

		var lines = file.split(/\r?\n/);//テキストファイル

		var tags    = [/*"Imported","PrestoNotes"*/];
		var id      = null;
		var note    = "";
		var url     = "";
		var created = "";
		var type    = "";

		var parser = 
		{
			type  : /^\#(FOLDER|NOTE)$/i,
			value : /^\s*([^=]+)=(.*)$/i,
		};

		for(var i = 0;i < lines.length;++i)
		{

			if(lines[i] === "-")
			{
				if(type === "NOTE")
				{
					if(id)
					{
						this.addNote(id,
						{
							note    : note,
							url     : url,
							created : created,
							updated : created,
							tags    : tags.concat()
						
						});

					}
					tags.pop();
				}

				id      = null;
				note    = "";
				url     = "";
				created = "";

				continue;

			}

			var _type = parser.type.exec(lines[i]);

			if(_type)
			{

				if(type && id)
				{
					if(type === "NOTE")
					{
						this.addNote(id,
						{
							note    : note,
							url     : url,
							created : created,
							updated : created,
							tags    : tags.concat()
						
						});

						id      = null;
						note    = "";
						url     = "";
						created = "";
					}
					else
					{
						tags.push(note);
					}
				}

				type = _type[1];
				continue;

			}
			else
			if(type)
			{

				var _value = parser.value.exec(lines[i]);

				if(_value)
				{
					switch(_value[1])
					{
						case "UNIQUEID" : id      = _value[2];break;
						case "NAME"     : note    = _value[2].replace(/\x02\x02/g,"\n");break;
						case "URL"      : url     = _value[2];break;
						case "CREATED"  : created = _value[2];break;
					}
				}

			}


		}

	//	console.log(this.notes);
		this.saveData();

	};
};
