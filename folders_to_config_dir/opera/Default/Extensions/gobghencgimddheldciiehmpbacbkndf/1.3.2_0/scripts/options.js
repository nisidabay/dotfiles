WHO.extension.initializeOptions();

var storage = WHO.extension.storage;

WHO.locale.translate("configurations/lang.json",function(dic)
{

	Backup(dic);
	Import(dic);

});
