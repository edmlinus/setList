<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*,pe.gallery.dto.MyItem,pe.gallery.dao.MyItemManager"%>    
<%
String hp1 = (String)request.getParameter("hp1");
String hp2 = (String)request.getParameter("hp2");
String hp3 = (String)request.getParameter("hp3");
hp1 = hp1!=null ? hp1.trim() : null;
hp2 = hp2!=null ? hp2.trim() : null;
hp3 = hp3!=null ? hp3.trim() : null;
MyItem item = MyItemManager.getMyItem(hp1,hp2,hp3);
List<String> songList = new ArrayList<String>();
String[] songs = null;
if (item!=null) {
	songs =item.songList.split(",");
	for (String song : songs) {
		songList.add(song);
	}
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
   var musicNameDic={
		    "11": "(걸인베) Candy Jelly Love",
		    "12": "(걸인베) 어제처럼 굿나잇",
		    "13": "(걸인베) 이별 Chapter1",
		    "14": "(걸인베) 비밀여행",
		    "15": "(1집리팩) 안녕",
		    "16": "(1집리팩) 놀이공원",
		    "21": "(럽8) 아츄",
		    "22": "(럽8) 작별하나",
		    "23": "(럽8) 예쁜 여자가 되는 법",
		    "24": "(럽8) Hug Me",
		    "25": "(럽8) 새콤달콤",
		    "26": "(럽8) 라푼젤",
		    "31": "(LVLNS) 그대에게",
		    "32": "(LVLNS) Circle",
		    "33": "(LVLNS) BeBe",
		    "41": "(뉴트릴) Destiny",
		    "42": "(뉴트릴) 퐁당",
		    "43": "(뉴트릴) 책갈피",
		    "44": "(뉴트릴) 1 cm",
		    "45": "(뉴트릴) 마음(*취급주의)",
		    "46": "(뉴트릴) 인형",
		    "51": "(2집리팩) 지금,우리",
		    "52": "(2집리팩) 아야(Aya)",
		    "53": "(RUR) WoW!",
		    "54": "(RUR) Cameo",
		    "55": "(RUR) Emotion",
		    "56": "(RUR) 첫눈",
		    "57": "(RUR) 똑똑",
		    "58": "(RUR) Night and Day",
		    "59": "(RUR) 숨바꼭질",
		    "50": "(Fever) Take Me Somewhere",
		    "61": "(폴인럽) 종소리",
		    "62": "(폴인럽) 삼각형",
		    "63": "(폴인럽) 그냥",
		    "64": "(폴인럽) 비밀정원",
		    "65": "(폴인럽) FALLIN'",
		    "66": "(폴인럽) 졸린꿈"
   };
  </script>
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
    			  alert(" 개수가 맞지 않아요.");
    		  } 
    		  return isValid;
    	  	});
            
            function fillForm(itemList) {
            	alert(itemList.join());
            	$("form").find("#inputItemList").attr("value",itemList.join());
            }
           
            function checkListCount(list){
        	  var counts= list.length;
        	  var fullCount = 5;
        	  if(counts>fullCount){
	      		  alert(counts);
	      		  return false;
        	  } else if(counts<fullCount){
	      		  alert(counts);
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
            	  if(counts<25){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> total "+counts+" items in the list<br>must select more items to submit"
            		  $titleItem.prepend($newLine);
            	  }else if(counts>25){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> total "+counts+"items selected <br> delete some from the list</p>"
            		  $titleItem.prepend($newLine);
            	  }else if(counts==25){
            		  $titleItem.children().remove();
            		  var $newLine = "<p> 25 items selected <br> you may submit now</p>"
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
	for (int i=0;i<=47;i++) {
		if(!songList.contains(i+"")) {
%>
    <li value="<%=i%>"><img src="images/<%=i%>.png"></li>
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
<button id="submitBtn" type="button" class="submitBtn"> clickMe </button>
<form class="submitWrap" target="_top" method="get" action="save.jsp">
 <input name="hp1" type="hidden" value="<%=hp1%>">
 <input name="hp2" type="hidden" value="<%=hp2%>">
 <input name="hp3" type="hidden" value="<%=hp3%>">
 <input id="inputItemList" name="songList" type="hidden" value="">
</form>
</body>
</html>