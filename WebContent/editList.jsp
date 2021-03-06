<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*,pe.gallery.dto.MyItem,pe.gallery.dao.MyItemManager"%>    
<%
String hp1 = (String)request.getParameter("hp1");
String hp2 = (String)request.getParameter("hp2");
String hp3 = (String)request.getParameter("hp3");
hp1 = hp1!=null ? hp1.trim() : "";
hp2 = hp2!=null ? hp2.trim() : "";
hp3 = hp3!=null ? hp3.trim() : "";
if (hp1.length()==0 || hp2.length()==0 || hp3.length()==0) {
	response.sendRedirect("index.jsp");
}
MyItem item = MyItemManager.getMyItem(hp1,hp2,hp3);

String[] initSong = new String[] {
		"1","2","3","4","5","6","7","8","9","10",
		"12","13","14","15","16","17","18","19","20",
		"22","23","24","25","26","27","29","30",
		"31","32","33","34","35","36","37","38","39","40",
		"42","43","44","45","46","47"
};
String[] songs = new String[] {"42","2"};
if (item!=null) {
	songs =item.songList.split(",");
}	
List<String> songList = new ArrayList<String>();
for (String song : songs) {
	songList.add(song);
} 
%>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=EUC-KR">
  <meta charset="EUC-KR">
  <meta name="viewport" content="width=device-width, initial-scale=1"> 
  <title>setListEdit</title> 
  <meta name="author" content="forresst" />
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0-alpha.2/jquery.mobile-1.4.0-alpha.2.min.css" />
  <link href="css/editlist.css" rel="stylesheet" media="all">
  <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
  <script src="http://code.jquery.com/mobile/1.4.0-alpha.2/jquery.mobile-1.4.0-alpha.2.min.js"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
  <script src="http://forresst.github.io/js/jquery.ui.touch-punch.min.js"></script>
  <script>
  $(document).ready(function(e) {
	    (function() {
            var listTab = getSelect($(".listTab"),function(){
            	var nameList = listTab.getSelectedItemsList();
            	selectTab.addItem(nameList);
            });
            
            var selectTab = getSelect($(".selectTab"),function(){
            	var nameList = selectTab.getSelectedItemsList();
            	listTab.addItem(nameList);
            	selectTab.removeItem();
            });
            $("#submitBtn").on("click",function() {
            	$("form").submit();
            });
            
            $("form").on("submit",function(){
              var itemList = listTab.getItemsList(); 	
      		  var isValid = checkListCount(itemList);
    		  if(isValid) {
    			  fillForm(itemList);
    		  } else {
    			  alert("셋리스트에 20개의 곡이 들어가 있지 않습니다.");
    		  } 
    		  return isValid;
    	  	});
            
            function fillForm(itemList) {
            	$("form").find("#inputItemList").attr("value",itemList.join());
            }
           
            var fullCount = 20;
            
            function checkListCount(list){
        	  var counts= list.length;       	  
        	  if(counts>fullCount){
	      		  return false;
        	  } else if(counts<fullCount){
	      		  return false;
        	  } else {
        		  return true;
        	  }
            }
           
            function getSelect($item,callback){
              var $div = $item
              var $titleItem = $div.find(".titleWrap");
              var $infoItem = $div.find(".infoWrap");
              var $ulItem = $div.find(".listWrap ul");
              var $liItem = $ulItem.find("li");
              var $btns = $div.find(".buttonWrap ul.buttons");
              var $selectedItems = null;
              var $unselectBtn = $btns.find("li.unselectBtn");
              var $removeBtn = $btns.find("li.removeBtn");
              var $addBtn = $btns.find("li.addBtn");
              
              initEvent();


              function initEvent(){
              	  $ulItem.on("click","li",function(){
              		  selectItem($(this));
              	  });  
              	  $unselectBtn.on("click",function(){
              		  unselectItem();
              	  });
              	  $removeBtn.on("click",function(){

              		  if(callback){
              			  callback();
              		  }
              		  removeItem();
              	  });
              	  $addBtn.on("click",function(){
              		  if(callback){
              			  callback();
              		  }
              	  });
              }
              
              function selectItem($itm){
            	  var $item=$itm;
            	  if($item.attr("class")!="selected"){
            		  $item.addClass("selected");
            	  }else{
            		  $item.removeClass("selected");
            	  }
            	  updateSelectedItemsList();
              }
              
              function unselectItem(){
            	  if ($selectedItems!=null){
            		  $selectedItems.removeClass("selected");
            	  }
            	  else{
            		  alert("선택된 항목이 없습니다.");
            	  }
                  updateSelectedItemsList();
              }
              
              function removeItem(){
            	  if ($selectedItems!=null){
            		  $selectedItems.remove();
            		  updateSelectedItemsList();
            		  updateItemsList();
            	  }
            	  else{
            		  alert("선택된 항목이 없습니다.");
            	  }
              }
                         
              function addItem(array){
            	  var itemNamesList= array;
            	  for(var i=0;i<itemNamesList.length;i++){
                  var musicKey = itemNamesList[i];
            	  var newItem = "<li value="+musicKey+"><img src='images/"+musicKey+".png'></li>";
            	  $ulItem.prepend(newItem);
            	  }
            	  updateItemsList();

              }
              
              function updateItemsList(){
            	  $liItem=$ulItem.children();
                  updateInfoItem($liItem.length);
              }
              
              function updateInfoItem(length){
            	  var counts = length;
            	  if(counts<fullCount){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> 셋리스트에 총 "+counts+"곡이 있습니다.<br>셋리스트에 20곡이 있어야 제출할 수 있습니다."
            		  $titleItem.prepend($newLine);
            	  }else if(counts>fullCount){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> 셋리스트에 총 "+counts+"곡이 있습니다.<br>셋리스트에 20곡이 있어야 제출할 수 있습니다.</p>"
            		  $titleItem.prepend($newLine);
            	  }else if(counts==fullCount){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> 셋리스트에 총 20 곡이 있습니다.</p>"
            	  }
              }
              
              function updateSelectedItemsList(){
            	  $selectedItems=$ulItem.children("li.selected");
            	  if($selectedItems.length!==0){
            		  $infoItem.css("display","block");
            		  $infoItem.children().remove();
            		  var $newLine = "<p>총 "+$selectedItems.length+" 개의 항목을 선택하셨습니다</p>"
            		  $infoItem.prepend($newLine);
            	  }else{
            		  $infoItem.css("display","none");
            	  }
              }
              
              function getSelectedItemsList(){
            	  var selectedItemsList = [];
	           	  $selectedItems.each(function(index){
	           		  selectedItemsList.push($(this).attr("value"));
	           	  });
            	  return selectedItemsList;
              }
              
              function getItemsList(){
            	  var itemsList =[];
            	  $liItem = $ulItem.children();
            	  $liItem.each(function(index){
            		  itemsList.push($(this).attr("value"));
            	  }); 
            	  return itemsList;
              }
            
              return {
            	  removeItem:removeItem,
            	  addItem:addItem,
            	  getSelectedItemsList:getSelectedItemsList,
            	  getItemsList:getItemsList           
              }
            }
	    })();
	  }); 
 /*
  var $selectedItems1 = null;
  var $selectedItems2 = null;
  */


  
  $(document).bind('pageinit', function() {
    $( "#sortable" ).sortable({
       items: "li:not(.ui-li-divider)"
    });
    $( "#sortable" ).sortable();
    $( "#sortable" ).disableSelection();
    $( "#sortable" ).bind( "sortstop", function(event, ui) {
      $('#sortable').listview('refresh');
    });
  });

  <% if (item!=null) { %>
	if (!confirm("이미 참여하셨습니다. 수정하시겠습니까?")) {
		window.location.replace("index.jsp");	
	}
<% } %> 
  </script>  
</head>
<body> 
<div class="contentsArea">
<div class="selectTab">
<div class="songsWrap">

</div>
<div class="listWrap">
<ul>
<% 
	for (String s : initSong) {
		if(!songList.contains(s)) {
%>
    <li value="<%=s%>"><img src="images/<%=s%>.png"></li>
<%			
		}
	}
%> 
</ul>
</div>
<div class="infoWrap">

</div>
<div class="buttonWrap">
 <ul class="buttons">
  <li class="unselectBtn"><img src="images/unselect.png"></li>
  <li class="addBtn"><img src="images/addItem.png"></li>
 </ul>
</div>
</div>
<div class="listTab">
<div class="titleWrap">

</div>
<div class="listWrap">
 <ul id="sortable">
<% 
	for (String s : songList) {
%>
    <li value="<%=s%>"><img src="images/<%=s%>.png"></li>
<%			
	}
%>
 </ul>
</div>
<div class="infoWrap">

</div>
<div class="buttonWrap">
 <ul class="buttons">
  <li class="unselectBtn"><img src="images/unselect.png"></li>
  <li class="removeBtn"><img src="images/removeItem.png"></li>
 </ul>
</div>
</div>
</div>

<form target="_top" method="post" action="save.jsp">
 <button id="submitBtn" type="button" class="submitBtn">응답 제출 </button>
 <input name="hp1" type="hidden" value="<%=hp1%>">
 <input name="hp2" type="hidden" value="<%=hp2%>">
 <input name="hp3" type="hidden" value="<%=hp3%>">
 <input id="inputItemList" name="songList" type="hidden" value="">
</form>


</body>
</html>