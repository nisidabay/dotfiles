/****************************************************************************************************/
/* Panel API                                                                                */
/*

// This file provides the Panel API.

	WHO.panel

		Methods

			setPage   : undefined WHO.panel.setPage(path panel)

			addEventListener    : undefined WHO.panel.addEventListener(string EventType,function EventListener)
			removeEventListener : undefined WHO.panel.removeEventListener(string EventType,function EventListener)

		Properties

			port       : WHO.port

	EventTypes

		activate   : (focus)
		deactivate : (blur)
                                                                                                    */
/****************************************************************************************************/

var WHO = WHO || {};

if(WHO.extension.isWebExtension)
{

	/**************************************************************************************/

	/* ###### ### #####  ###### ######  #####  #     # */
	/* #       #  #    # #      #      #     #  #   #  */
	/* #       #  #    # #      #      #     #   # #   */
	/* #####   #  #    # #####  #####  #     #    #    */
	/* #       #  #####  #      #      #     #   # #   */
	/* #       #  #  #   #      #      #     #  #   #  */
	/* #      ### #   ## ###### #       #####  #     # */

	if((window.opr && window.opr.sidebarAction) || (window.browser && window.browser.sidebarAction))
	{

		var sidebarAction = WHO.extension.isFirefox ? window.browser.sidebarAction : window.opr.sidebarAction;

		WHO.panel =
		{

			port : null,

			_page      : "",

			_eventListener :
			{
				update    : {},
				activate  : {},
				deactivate: {},
			},
			_eventListenerId : 0,


			//------------------------------------------------------------------------------------//
			/* 設定 */

			setPage : function(page)
			{

				if(page)
				{

					this._page = page;

				}


			},

			//------------------------------------------------------------------------------------//

			addEventListener : function(type,listener)
			{

				listener.panelEventListener = listener.panelEventListener||{};

				if(listener.panelEventListener[type])
				{
					return;
				}

				var listenerId = ++WHO.panel._eventListenerId;

				WHO.panel._eventListener[type][listenerId] = listener;

				listener.panelEventListener[type] = listenerId

			},
			removeEventListener : function(type,listener)
			{

				listener.panelEventListener = listener.panelEventListener||{};

				var listenerId = listener.panelEventListener[type];

				delete WHO.panel._eventListener[type][listenerId];

				delete listener.panelEventListener[type];

			},

			//------------------------------------------------------------------------------------//

		};

		if(WHO.extension.isFirefox)
		{
			var mypanel = browser.sidebarAction.getPanel({});
			mypanel.then(function(page){WHO.panel._page = page;});
		}
		else
		{
			opr.sidebarAction.getPanel({},function(page){WHO.panel._page = page;})
		}

		var manifest = chrome.runtime.getManifest();

		if(manifest.browser_action)
		{
		}
		else
		if(manifest.page_action)
		{
		}

		/* サイドバーボタンクリック時 */

	//	opr.sidebarAction.onClicked.addListener(function(_tab)
	//	{
    //
	//		var tab = WHO.tabs._getExtensionTab(_tab);
    //
	//		for(var i in WHO.panel._eventListener["click"])
	//		{
    //
	//			WHO.panel._eventListener["click"][i]({type:"click",tab:tab});
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

		WHO.panel =
		{

			port : null,

			_panelWindow : null,//windowId

			_page  : manifest.sidebar_action.default_panel,
			_width : 200,
			_height: 500,
			_left  : 0,
			_top   : 0,

			/* パネルウィンドウの位置とサイズを取得する */

			_getPanelStatus : function(callback)
			{

				chrome.windows.get(WHO.panel._panelWindow,{},function(_win)
				{
					if(_win)
					{
						WHO.panel._left   = _win.left;
						WHO.panel._top    = _win.top;
						WHO.panel._width  = _win.width;
						WHO.panel._height = _win.height;

						if(callback)
						{

							callback();

						}
					}
				});

			},

			/* パネルウィンドウを表示する */

			show : function()
			{

				chrome.windows.create(
				{
					type  : WHO.extension.isOPR?"popup":"panel",
					url   : WHO.panel._page,
					left  : WHO.panel._left,
					top   : WHO.panel._top,
					width : WHO.panel._width,
					height: WHO.panel._height,
				},function(_win)
				{

					WHO.panel._panelWindow = _win.id;

				});

			},

			/* パネルウィンドウを閉じる */

			hide : function()
			{

				WHO.panel._getPanelStatus(function()
				{
					chrome.windows.remove(WHO.panel._panelWindow,function()
					{

						WHO.panel._panelWindow = null;

					});
				});

			},

		};

		if(manifest.browser_action)
		{
		}
		else
		if(manifest.page_action)
		{

			if(!manifest.page_action.default_popup)
			{

				/* パネルを閉じたときの処理 */

				chrome.windows.onRemoved.addListener(function(_winId)
				{
					if(WHO.panel._panelWindow === _winId)
					{
						WHO.panel._panelWindow = null;
					}
				});

				/* パネルのサイズを取得 */

				chrome.windows.onFocusChanged.addListener(function(_winId)
				{
					if(WHO.panel.por && WHO.panel._panelWindow)
					{

						WHO.panel._getPanelStatus();

					}
				});

			}

		}

	}//ここまで Chrome

}//ここまで Chrome + OPR
	/**************************************************************************************/

	/* WHO.panel.port の取得 */

	WHO.extension.addMessageListener('__Panel__',function(port,message)
	{

		if(message.method === "setPort")
		{
			WHO.panel.port     = port;
			WHO.panel.port.url = message.url;
		}

	});

	WHO.extension.addEventListener('disconnect',function(e)
	{
		if(WHO.panel.port && e.source === WHO.panel.port.source)
		{

		//	console.log("Panel is closed");
			WHO.panel.port = null;

		}
	});

//	/**************************************************************************************/
//
//	/*  #####    ###   ######   ###   #####  ### */
//	/* #     #  #   #  #       #   #  #    #  #  */
//	/* #       #     # #      #     # #    #  #  */
//	/*  #####  ####### #####  ####### #    #  #  */
//	/*       # #     # #      #     # #####   #  */
//	/* #     # #     # #      #     # #  #    #  */
//	/*  #####  #     # #      #     # #   ## ### */


	/**************************************************************************************/
