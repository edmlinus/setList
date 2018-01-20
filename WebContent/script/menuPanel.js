/**
 * tabMenu and tabPanel. 180113
 */
 //tabPanel함수 정의. tabPanel(selector)
 function tabPanel(selector){
	 var $tabPanel = null;
	 var $tabItems = null;
	 var $selectedTabItem = null;
	 
	 init();
	 
	 function init(){
		 $tabPanel = $(selector);
		 $tabItems = $tabPanel.children(".content");
	 }
	 
	 function setSelectPanelAt(index){
		 if($selectedTabItem != null){
			 $selectedTabItem.removeClass("select");
		 }
		 $selectedTabItem = $tabItems.eq(index);
		 $selectedTabItem.addClass("select");
	 }
	 return {
		 setSelectPanelAt:setSelectPanelAt
	 }
 }
 //tabMenu함수 정의. tabMenu(selector)
 function tabMenu(selector){
	 var $tabMenu = null;
	 var $menuItems = null;
	 var $selectedMenuItem = null;
	 
	 init();
	 initEvent();
	 
	 function init(){
		 $tabMenu = $(selector);
		 $menuItems = $tabMenu.children("li");
	 }
	 
	 function initEvent(){
		 $menuItems.click(function(){
			setSelectItem($(this)); 
		 });
	 }
     function setSelectItem($item){
    	 if($selectedMenuItem!=null){
    		 $selectedMenuItem.removeClass("select");
    	 }
    	 $selectedMenuItem = $item;
    	 $selectedMenuItem.addClass("select");
    	 
    	 dispatchSelectEvent();
     }
     function dispatchSelectEvent(){
    	 //이벤트 객체 생성
    	 var event = jQuery.Event("tabSelect");
    	 //이벤트 데이터 생성
    	 event.selectIndex = $selectedMenuItem.index();
    	 event.selectItem = $selectedMenuItem;
    	 
    	 $tabMenu.trigger(event);
     }
     function setSelectItemAt(index){
    	 var $item = $menuItems.eq(index);
    	 setSelectItem($item);
     }
     return{
    	 $tabMenu: $tabMenu,
    	 setSelectItemAt:setSelectItemAt
     }	
 }