<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:if test="${param.action == 'success'}">
		<div id="successfully"></div>
	</c:if>
	<c:if test="${param.action == 'errors'}">
		<div id="errors"></div>
	</c:if>
	<script
		src="./js/sweetalert2.all.min.js"></script>
</body>
</html>