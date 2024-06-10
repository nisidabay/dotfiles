/****************************************************************************************************/
/* Sidebar widget API                                                                                */
/*

// This file provides the Sidebar widget API.

	WHO.sidebar

		Methods

		*	setTitle   : undefined WHO.sidebar.setTitle(string title)
		*	setIcon    : undefined WHO.sidebar.setIcon(path icon)
		*	setBadge   : undefined WHO.sidebar.setBadge(string badgetext)

			addEventListener    : undefined WHO.sidebar.addEventListener(string EventType,function EventListener)
			removeEventListener : undefined WHO.sidebar.removeEventListener(string EventType,function EventListener)

		Properties

			port       : WHO.port

			title      :
			icon       :
			badge      :

	EventTypes

		click      : 
		activate   : (focus)
		deactivate : (blur)
		update     : 
                                                                                                    */
/****************************************************************************************************/

var WHO = WHO || {};

if(WHO.extension.isWebExtension)
{

	WHO.sidebar =
	{

		title      : "",
		icon       : "",
		badge      : {},

		_eventListener :
		{
			click     : {},
		},
		_eventListenerId : 0,


		//------------------------------------------------------------------------------------//
		/* 設定 */

		//------------------------------------------------------------------------------------//

		addEventListener : function(type,listener)
		{

			listener.sidebarEventListener = listener.sidebarEventListener||{};

			if(listener.sidebarEventListener[type])
			{
				return;
			}

			var listenerId = ++WHO.sidebar._eventListenerId;

			WHO.sidebar._eventListener[type][listenerId] = listener;

			listener.sidebarEventListener[type] = listenerId

		},
		removeEventListener : function(type,listener)
		{

			listener.sidebarEventListener = listener.sidebarEventListener||{};

			var listenerId = listener.sidebarEventListener[type];

			delete WHO.sidebar._eventListener[type][listenerId];

			delete listener.sidebarEventListener[type];

		},

		//------------------------------------------------------------------------------------//

	};

	if(WHO.extension.isOPR && window.opr && window.opr.sidebarAction)
	{

		opr.sidebarAction.getTitle               ({},function(title){WHO.sidebar.title = title;})
		opr.sidebarAction.getBadgeText           ({},function(text){WHO.sidebar.badge.text = text;})
		opr.sidebarAction.getBadgeBackgroundColor({},function(color){WHO.sidebar.badge.backgroundColor = color;})

		/* サイドバーボタンクリック時 */

	//	opr.sidebarAction.onClicked.addListener(function(_tab)
	//	{
    //
	//		var tab = WHO.tabs._getExtensionTab(_tab);
    //
	//		for(var i in WHO.sidebar._eventListener["click"])
	//		{
    //
	//			WHO.sidebar._eventListener["click"][i]({type:"click",tab:tab});
    //
	//		}
    //
	//	});

	}//ここまで OPR + sidebar
	else

	/**************************************************************************************/

	/*  #####  #     # #####   #####  #     # ######  */
	/* #     # #     # #    # #     # ##   ## #       */
	/* #       #     # #    # #     # # # # # #       */
	/* #       ####### #    # #     # #  #  # #####   */
	/* #       #     # #####  #     # #     # #       */
	/* #     # #     # #  #   #     # #     # #       */
	/*  #####  #     # #   ##  #####  #     # ######  */

	{

		var manifest = chrome.runtime.getManifest();

		if(manifest.browser_action)
		{
		}
		else
		if(manifest.page_action)
		{

			if(!manifest.page_action.default_popup)
			{

				/* ページアクションボタンを表示する */

				chrome.tabs.onCreated.addListener(function(_tab)
				{

					chrome.pageAction.show(_tab.id);

				});

				chrome.tabs.onActivated.addListener(function(_activeInfo)
				{

					chrome.pageAction.show(_activeInfo.tabId);

				});

				chrome.tabs.onUpdated.addListener(function(_tabId)
				{

					chrome.pageAction.show(_tabId);

				});

				/* ページアクションをクリックしたときの操作 */

				chrome.pageAction.onClicked.addListener(function(_tab)
				{
					/* パネルを閉じる */
					if(WHO.panel._panelWindow)
					{

						WHO.panel.hide();

					}
					/* パネルを表示 */
					else
					{

						WHO.panel.show();

					}

				});

			}

		}

	}//ここまで Chrome

}//ここまで Chrome + OPR

//	/**************************************************************************************/
//
//	/*  #####    ###   ######   ###   #####  ### */
//	/* #     #  #   #  #       #   #  #    #  #  */
//	/* #       #     # #      #     # #    #  #  */
//	/*  #####  ####### #####  ####### #    #  #  */
//	/*       # #     # #      #     # #####   #  */
//	/* #     # #     # #      #     # #  #    #  */
//	/*  #####  #     # #      #     # #   ## ### */
//
//	if(WHO.extension.isSafari)
//	{
//	}
//	else

	/**************************************************************************************/

	/* ###### ### #####  ###### ######  #####  #     # */
	/* #       #  #    # #      #      #     #  #   #  */
	/* #       #  #    # #      #      #     #   # #   */
	/* #####   #  #    # #####  #####  #     #    #    */
	/* #       #  #####  #      #      #     #   # #   */
	/* #       #  #  #   #      #      #     #  #   #  */
	/* #      ### #   ## ###### #       #####  #     # */
	// Only for Panel Content Script

	if(WHO.extension.isJetpack)
	{

		WHO.sidebar =
		{
		};

		self.port.on('__Sidebar__',function(data)
		{

			switch(data.method)
			{
			}

		});

	}

	/**************************************************************************************/
