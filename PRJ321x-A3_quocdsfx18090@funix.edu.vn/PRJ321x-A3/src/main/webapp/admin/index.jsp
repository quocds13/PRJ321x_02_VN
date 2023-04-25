<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=response.encodeUrl(request.getContextPath())%>/css/bootstrap.min.css">
<title>Trang Admin</title>
</head>
<body>
	<%@ include file="/admin/header.jsp"%>
	<%
		if (session.getAttribute("username") != null) {
	%>
	<div class="row">
		<%@ include file="/admin/slidebar.jsp"%>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<%@ include file="/admin/main.jsp"%>
		</main>
	</div>
	<%
	}
	%>>
	<script src="<%=response.encodeUrl(request.getContextPath())%>/js/bootstrap.bundle.min.js"></script>
	<script src="<%=response.encodeUrl(request.getContextPath())%>/js/feather.min.js"></script>
</body>
</html>