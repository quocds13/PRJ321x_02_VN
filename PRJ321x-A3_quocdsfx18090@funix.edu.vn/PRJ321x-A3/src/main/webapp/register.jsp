<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/register.css" />
</head>
<body>
	<c:import url="./message.jsp"/>
	<div class="main">
		<div class="register">
			<h3>Tạo tài khoản</h3>
			<p style="text-align: right; margin-right: 1rem; color: red;"
				id="message">
				<i><%=request.getAttribute("validation") == null ? "" : request.getAttribute("validation")%></i>
			</p>
			<form id="reg-form" action="./register" method="post">
				<input type="hidden" name="action" value="register" />
				<div>
					<label for="username">Họ tên (*)</label> <input type="text"
						id="username" name="username" spellcheck="false"
						placeholder="Nhập họ tên" required="required" />
				</div>
				<div>
					<label for="usermail">Tài khoản email (*)</label> <input
						type="email" id="usermail" name="usermail" spellcheck="false"
						placeholder="abcd@xyz.com" required="required" />
				</div>
				<div>
					<label for="userphone">Số điện thoại (*)</label> <input type="text"
						name="userphone" id="userphone" spellcheck="false"
						placeholder="Nhập số điện thoại" maxlength="10"
						required="required" />
				</div>
				<div>
					<label for="user_address">Địa chỉ</label> <input type="text"
						name="user_address" id="user_address" spellcheck="false"
						placeholder="Nhập địa chỉ" />
				</div>
				<div>
					<label for="password">Mật khẩu (*)</label> <input type="password"
						name="password" id="password" placeholder="Nhập mật khẩu mới"
						required="required" />
				</div>
				<div>
					<label for="password-again">Nhập lại mật khẩu (*)</label> <input
						type="password" id="password-again"
						placeholder="Nhập lại mật khẩu" name="password-again"
						required="required" />
				</div>
				<div>
					<label></label> <input type="submit" value="Tạo tài khoản"
						id="create-account" class="button" />
				</div>
			</form>
		</div>
		<script src="./js/script.js"></script>	
		<script src="./js/register.js"></script>	
	</div>
</body>
</html>