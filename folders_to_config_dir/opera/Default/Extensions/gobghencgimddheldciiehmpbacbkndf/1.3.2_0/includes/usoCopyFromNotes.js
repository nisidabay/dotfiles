var WHO = WHO ||{};

WHO.CopyFromNotes =
{
	start : function()
	{

		WHO.extension.addMessageListener('TaggingNotes',function(message)
		{

			if(message.method === "paste")
			{

				WHO.CopyFromNotes.insertText(message.text);

			}

		});

	},
	insertText : function(str)
	{


		if(! document.execCommand("insertText",false,str))
		{

			var focused = document.activeElement;

			if(focused && ["textarea","input"].indexOf(focused.localName) > -1)
			{

				var value = focused.value;
				var start;
				var end	;
				if(value)
				{
					start	= focused.selectionStart; // textarea 内での選択開始位置
					end		= focused.selectionEnd; // textarea 内での選択終了位置
					var select	= value.slice(start,end); // 選択範囲を textarea の内容から抜き出す
					focused.value = value.slice(0,start) + str + value.slice(end);
				}
				else
				{
					focused.value = str;
				}
				focused.focus();
				if(start)
				{
					focused.setSelectionRange(start+str.length,start+str.length);
				}
			}
		}
	},
	
};

if(WHO.extension.isJetpack)
{
	/* これも Firefox 対策 ContentScriptWhen : start じゃないと activeElement がとれない */
	document.addEventListener('DOMContentLoaded',function(e)
	{

		WHO.CopyFromNotes.start();

		/* Firefox のバグ？対策 contenteditable=true な要素がないと execCommand でエラー */
		if(WHO.extension.isJetpack)
		{

			var dummy = document.createElement('p');
				dummy.setAttribute('contenteditable',"true");
				dummy.style.display = "none";
				document.body.appendChild(dummy);

		}
	});
}
else
{

	WHO.CopyFromNotes.start();

}
