<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="pe.gallery.dto.MyItem,pe.gallery.dao.MyItemManager"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String hp1 = (String)request.getParameter("hp1");
String hp2 = (String)request.getParameter("hp2");
String hp3 = (String)request.getParameter("hp3");
hp1 = hp1!=null ? hp1.trim() : null;
hp2 = hp2!=null ? hp2.trim() : null;
hp3 = hp3!=null ? hp3.trim() : null;
String songList = (String)request.getParameter("songList");
java.util.Date date = new java.util.Date();
java.sql.Timestamp regdt = new java.sql.Timestamp(date.getTime());

MyItem item = MyItemManager.getMyItem(hp1, hp2, hp3);
if (item==null) {
	item = new MyItem(hp1,hp2,hp3,songList,regdt);
	MyItemManager.createMyItem(item);
} else {
	item.songList = songList;
	item.regdt = regdt;
	MyItemManager.updateMyItem(item);
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
저장을 완료하였습니다.
</body>
</html>