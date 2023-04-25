<nav id="sidebarMenu"
	class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
	<div class="position-sticky pt-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/home-outline.svg" height="24" width="24">  Dashboard
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/document-outline.svg" height="24" width="24">  Orders
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/cart-outline.svg" height="24" width="24">  Products
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/people-outline.svg" height="24" width="24">  Customers
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/stats-chart-outline.svg" height="24" width="24">  Reports
			</a></li>
		</ul>

		<h6
			class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
			<span>Saved reports</span> <a class="link-secondary" href="#"
				aria-label="Add a new report"><img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/add-circle-outline.svg" height="24" width="24"> 
			</a>
		</h6>
		<ul class="nav flex-column mb-2">
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/document-text-outline.svg" height="24" width="24">  Current month
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/document-text-outline.svg" height="24" width="24">  Last quarter
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/document-text-outline.svg" height="24" width="24">  Social engagement
			</a></li>
			<li class="nav-item"><a class="d-flex nav-link active align-items-center gap-2"
				aria-current="page" href="#"> <img alt="" src="<%=response.encodeUrl(request.getContextPath())%>/img/document-text-outline.svg" height="24" width="24">  Year-end sale
			</a></li>
		</ul>
	</div>
</nav>