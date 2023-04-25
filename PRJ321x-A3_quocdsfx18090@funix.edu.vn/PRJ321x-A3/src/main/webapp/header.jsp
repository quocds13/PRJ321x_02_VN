<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>${param.title}</title>
<header class="p-3 bg-dark text-white">
	<div class="container-fluid">
		<div
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<a href="${pageContext.request.contextPath}/home"
				class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
				<img alt="" src="./img/brand.svg" style="height: 40px; width: 40px">
			</a>

			<ul
				class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li><a href="${pageContext.request.contextPath}/home"
					class="nav-link px-2 text-secondary">Home</a></li>
				<li><a href="#" class="nav-link px-2 text-white">Features</a></li>
				<li><a href="#" class="nav-link px-2 text-white">Pricing</a></li>
				<li><a href="#" class="nav-link px-2 text-white">FAQs</a></li>
				<li><a href="#" class="nav-link px-2 text-white">About</a></li>
			</ul>

			<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3"
				action="./header" method="get">
				<input type="hidden" name="action" value="search"> <input
					type="search" class="form-control form-control-dark"
					placeholder="Search..." aria-label="Search" name="keyword">
			</form>

			<div class="text-center d-flex">
				<%
				if (session.getAttribute("usermail") == null) {
				%>
				<button id="btn-login" type="button"
					class="btn btn-outline-light me-2">Login</button>
				<button id="btn-signup" type="button" class="btn btn-warning">Sign-up</button>
				<%
				} else {
				%>
				<p class="pe-2"> Wellcome: <%=session.getAttribute("username")%></p>
				<form
					action="<%=response.encodeUrl(request.getContextPath())%>/logout"
					method="post" class="nav-item text-nowrap">
					<input id="btn-logout" type="submit" name="btnlogout"
						class="btn btn-danger" value="Sign out">
				</form>
				<%
				}
				%>
			</div>
		</div>
	</div>
</header>