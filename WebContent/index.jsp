<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>identifyUser</title>
<script type="text/javascript" src="script/jqueryLib.js"></script>
<link href="css/inIdentify_design.css" rel="stylesheet" media="all">
<script>
 $(document).ready(function(){
 });
</script>
</head>
<body>
 <div class="formWrap">
  <form action="editList.jsp" method="get" target="_top">
  ��÷ �� ����Ȯ���� ���� �޴��� ��ȣ�� �Է��� �ּ���.<br>
  �������� �޴��� ��ȣ�� ����Ȯ�� �������θ� ���Ǹ�, �̺�Ʈ ����� ��� �����˴ϴ�.<br>
         <div class="phoneNumber">
           <input type="text" class="iText" name="hp1" maxlength="3">
           <span>-</span>
           <input type="text" class="iText" name="hp2" maxlength="4">
           <span>-</span>
           <input type="text" class="iText" name="hp3" maxlength="4">
         </div>
         <input type="submit" value="submit">
  </form>
 </div>
</body>
</html>