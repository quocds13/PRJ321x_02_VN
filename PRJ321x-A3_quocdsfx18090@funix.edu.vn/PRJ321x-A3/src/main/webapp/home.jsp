<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/styles.css" />
<link rel="stylesheet" href="./css/bootstrap.min.css" />
<c:import url="/header.jsp">
	<c:param name="title" value="Trang chủ"></c:param>
</c:import>
</head>
<body>
	<c:import url="./message.jsp" />
	<div class="container-fluid " style="margin: 1rem 0">
		<div class="row">
			<div class="col-2">
				<%@ include file="./slidebar.jsp"%>
			</div>
			<div class="col-8">
				<c:import url="./main.jsp" />
			</div>
			<div class="col-2">
				<div class="d-block" style="height: 100%">
					<div class="card" style="width: 100%">
						<img alt="" src="./img/cart.svg"
							style="height: 50px; height: 50px">
						<div class="card-body text-center">
							<c:if test="${carts.size()>0}"><div id="cart-number">${carts.size()}</div></c:if>
							<p class="card-title">Shooping Cart</p>
							<form
								action="<%=response.encodeURL(request.getContextPath())%>/main">
								<input type="hidden" name="action" value="view-Cart" /> <input
									type="submit" class="btn btn-primary" value="View" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp" />
	<script src="./js/script.js"></script>
	<script src="./js/main.js"></script>
</body>
</html>