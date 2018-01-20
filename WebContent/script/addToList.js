/**
 * add to List
 */
 //전역 함수 정의
 function init(){
	 $menu=$("ul.topList");
	 $menuName=$("#menuName");
 }
 function initEvent(){
	 //add
	 $("#add").click(function(){
		addMenu(); 
	 });
	 //sslect
	 $menu.on("click","li",function(){
		 selectItem($(this));
	 });
 }
 function addMenu(){
	 var menuName = $menuName.val();
	 var newMenuItem = "<li>"+menuName+"</li>";
	 if($selectedItem!=null){
		 $selectedItem.after(newMenuItem);
	 }else{
		 $menu.append(newMenuItem);
	 }
	 
 }
 function selectItem($item){
	 if($selectedItem!=null){
		$selectedItem.removeClass("selected"); 
	 }
	 $selectedItem=$item;
	 $selectedItem.addClass("selected");
 }