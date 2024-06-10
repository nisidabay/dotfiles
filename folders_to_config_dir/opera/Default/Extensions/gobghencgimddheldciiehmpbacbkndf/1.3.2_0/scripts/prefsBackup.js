var Backup = function()
{

	var self = this;


	ID('BackupNotes').addEventListener('click',function(e){self.backupNotes(e)});

	this.backupNotes = function()
	{

		var notes = JSON.parse(storage.getItem('notes'))||{};

		downloadJsonData("TaggingNotes" + (new Date().toLocaleDateString()) + ".json",notes);

	};


};

