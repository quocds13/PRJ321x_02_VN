<header
	class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-2 shadow">
	<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="#">ADMIN
		PAGE </a>
	<button class="navbar-toggler position-absolute d-md-none collapsed"
		type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
		aria-controls="sidebarMenu" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="navbar-nav d-flex flex-row align-items-center">
		<% if (session.getAttribute("username") != null) { %>
		<p class="text-white mb-0 me-1">
			Wellcome :
			<%=session.getAttribute("username")%></p>
		<% } %>
		<form action="<%=response.encodeUrl(request.getContextPath())%>/logout" method="post" class="nav-item text-nowrap">
			<input type="submit" name="btnlogout" class="btn btn-danger"
				value="Sign out">
		</form>
	</div>
</header>
