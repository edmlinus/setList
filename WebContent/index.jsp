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
  <div class="infoWrap">
  </div>
  <form action="editList.jsp" method="post" target="_top">
 �̺�Ʈ ���� ��ũ(�ܿﳪ���� ������1, alwayz �¸���Ʈ�� ���⼭ ���� �� �ֽ��ϴ�):<br>
 <a href="http://kksoo20002.cafe24.com/winterland2/">(���� �����̴�?!)�ܿﳪ���� ������ 2 �¸���Ʈ ���߱� �̺� ���� ��ũ</a><br><br>
��ǰ �Ŀ� :<br>
 <a href="https://open.kakao.com/o/s1vBlzt">�̺�Ʈ ��ǰ �Ŀ� ����ī��</a><br><br>
  ��÷ �� ����Ȯ���� ���� �޴��� ��ȣ�� �Է��� �ּ���.<br>
  �������� �޴��� ��ȣ�� ����Ȯ�� �������θ� ���Ǹ�, �̺�Ʈ ����� ��� �����˴ϴ�.<br>
         <div class="phoneNumber">
           <input type="text" class="iText" name="hp1" maxlength="3">
           <span>-</span>
           <input type="text" class="iText" name="hp2" maxlength="4">
           <span>-</span>
           <input type="text" class="iText" name="hp3" maxlength="4">
           <input type="submit" value="����">
         </div>

  </form>
 </div>
</body>
</html>