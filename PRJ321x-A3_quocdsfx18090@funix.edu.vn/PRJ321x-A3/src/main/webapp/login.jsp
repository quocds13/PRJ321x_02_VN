<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/styles.css" />
<title>Đăng nhập</title>
</head>
<body>
	<jsp:useBean id="account" class="model.Account" scope="session"></jsp:useBean>
	<% Cookie[] cookies = request.getCookies();
	String usermail = "", check ="";
	if(cookies!=null){
		for(Cookie c : cookies){
			if(c.getName().equals("uname")){
				usermail = c.getValue();
			}else if (c.getName().equals("checkRemb")){
				check = c.getValue();
			}
		}
	}
	%>
	<div class="login">
		<div class="form-header">
			<img alt="" src="./img/login.png">
		</div>
		<p style="text-align: right; margin-right: 1rem; color: red;">
			<i><%=request.getAttribute("validation") == null ? "" : request.getAttribute("validation")%></i>
		</p>
		<div class="form-content">
			<form action="login" method="post">

				<input type="hidden" name="action-login" value="login"> <label
					for="uname">Usermail:</label><br> <input type="text"
					class="container" id="uname" name="usermail"
					placeholder="Mail đăng nhập" value="<%= usermail %>"> <br /> <label
					for="upass">Password:</label><br> <input type="password"
					class="container" id="upass" name="password"
					placeholder="Mật khẩu"><br> <input type="submit"
					class="container" id="btnLogin" value="Đăng nhập">
				<div class="container check">
					<input type="checkbox" id="remember" name="checkRemb"
						<%= check.equals("on")?"checked":null %>>
					<label for="remember">Nhớ tôi</label><br>
				</div>
			</form>
		</div>
		<div class="form-footer">
			<a href="${pageContext.request.contextPath}/register.jsp" >Đăng ký tài khoản</a>
		</div>
	</div>
</body>
</html>