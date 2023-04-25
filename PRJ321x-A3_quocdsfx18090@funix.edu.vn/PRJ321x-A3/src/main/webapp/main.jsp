<%@page import="java.lang.reflect.Parameter"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="container-fluid d-flex flex-wrap gap-3 bg-gradient">
	<c:choose>
		<c:when test="${param.action == 'view-Cart' }">
			<table class="table table-light table-hover">
				<th>#</th>
				<th>Tên sản phẩm</th>
				<th>Giá sản phẩm</th>
				<th>Số lượng</th>
				<th>Thành tiền</th>
				<th></th>
				<c:set var="i" value="1" />
				<c:forEach var="item" items="${carts}">
					<tr>
						<td>${i}</td>
						<td>${item.getProduct_name()}</td>
						<td>${item.getProduct_price()}$</td>
						<td><a title="Tăng"
							href="${pageContext.request.contextPath}/main?action=update&product_id=${item.getProduct_id()}&order_id=${item.getOrder_id()}&status=1"
							class="btn btn-success btn-sm">+</a> <span class="px-2">${item.getAmount_product()}</span>
							<a title="Giảm"
							href="${pageContext.request.contextPath}/main?action=update&product_id=${item.getProduct_id()}&order_id=${item.getOrder_id()}&status=0")"
							class="btn btn-danger btn-sm" style="width: 26px">-</a></td>
						<td>${item.getTotal_price()}$</td>
						<td><a title="Xóa"
							href="${pageContext.request.contextPath}/main?action=update&product_id=${item.getProduct_id()}&order_id=${item.getOrder_id()}&status=2")"
							class="btn btn-warning "><img
								src="${pageContext.request.contextPath}/img/trash-outline.svg"
								height="24" width="24"></a></td>
					</tr>
					<c:set var="i" value="${i+1}" />
				</c:forEach>
				<tr>
					<td colspan="4"><strong>Tổng tiền</strong></td>
					<td colspan="2"><strong>${totalBill} $</strong></td>
				</tr>
			</table>
			<c:if test="${carts.size()>0}">
				<table>
					<tr>
						<td colspan="2"><strong>Tên khách hàng:</strong></td>
						<td />
						<td colspan="4">${carts[0].getUser_name()}</td>
					</tr>
					<tr>
						<td colspan="2"><strong>Địa chỉ nhận:</strong></td>
						<td />
						<td colspan="4">${carts[0].getUser_address()}</td>
					</tr>
					<tr>
						<td colspan="2"><strong>Mã giảm giá: </strong></td>
						<td />
						<td colspan="4">${carts[0].getOrder_discount_code()}</td>
					</tr>
					<tr>
						<td>
							<form
								action="<%=response.encodeUrl(request.getContextPath())%>/main"
								method="post">
								<input type="hidden" name="action" value="payBill"> <input
									class="btn btn-primary mt-2" type="submit" value="Thanh toán" />
							</form>
						</td>
					</tr>
				</table>
			</c:if>
		</c:when>
		<c:when test="${param.action == null || param.action == 'search' || param.action == 'paging'}">
			<c:if test="${param.action != 'search'}">
				<div class="container-fluid text-end">
					<label for="numDisplayProduct">Số sản phẩm hiển thị:</label> <select
						name="numDisplayProduct" id="numDisplayProduct">
						<option>Chọn</option>
						<option value="4">4</option>
						<option value="8">8</option>
						<option value="12">12</option>
						<option value="16">16</option>
						<option value="20">20</option>
					</select>
				</div>
			</c:if>
			<c:forEach var="product" items="${products}">
				<div class="card text-center" style="width: 23%; height: auto">
					<img class="container"
						src="<c:out value='${product.getProduct_img_source()}'/>"
						class="card-img-top" alt="...">
					<div class="card-body">
						<hr />
						<h6 class="card-title">
							<c:out value="${product.getProduct_name()}" />
						</h6>
						<p class="card-text text-danger">
							<c:out value='${product.getProduct_price()}' />
							<span style="background-color: red; color: white"> <i>-5%</i>
							</span>
						</p>
						<a
							href="${pageContext.request.contextPath}/main?action=get_Product_by_id&product_id=${product.getProduct_id()}"
							class="btn btn-primary">Details</a>
					</div>
				</div>
			</c:forEach>
			<c:if test="${param.action != 'search'}">
				<div class="container-fluid d-flex justify-content-center gap-3">
					<c:set var="total_Page"
						value="${sizeProducts/(param.num==null?8:param.num)}" />
					<c:set var="total_Page"
						value="${sizeProducts%(param.num==null?8:param.num)>0?total_Page+1:total_Page}" />
					<c:forEach var="i" begin="1" end="${total_Page}" step="1"
						varStatus="status">
						<a class="btn btn-primary"
							href="${pageContext.request.contextPath}/main?action=paging&id=${i}&num=${param.num==null?8:param.num}">${i}</a>
					</c:forEach>

				</div>
			</c:if>
		</c:when>
		<c:when test="${param.action == 'get_Product_by_id' }">
			<h2>
				<c:out value="${product.getProduct_name()}" />
			</h2>
			<div class="d-flex">
				<div class="container p-0 " style="width: 35%">
					<img class="container"
						src="<c:out value='${product.getProduct_img_source()}'/>"
						alt="...">
				</div>
				<div class="container">
					<h5 class="card-text text-danger">
						<c:out value='${product.getProduct_price()}' />
						$
					</h5>
					<table class="table">
						<tr>
							<td>Nhà sản xuất:</td>
							<td>${fn:toUpperCase(product.getProduct_brand())}</td>
						</tr>
						<tr>
							<td>Nhà phân phối:</td>
							<td>${fn:toUpperCase(product.getProduct_type())}</td>
						</tr>
						<tr>
							<td>Thông tin sản phẩm :</td>
							<td>${product.getProduct_des()}</td>
						</tr>
						<p></p>
					</table>
					<a
						href="<%=response.encodeUrl(request.getContextPath())%>/orderBill?product_id=${product.getProduct_id()}&usermail=<%=session.getAttribute("usermail")!=null?session.getAttribute("usermail"):""%>"
						class="btn btn-primary">Add to cart</a>
				</div>
			</div>
		</c:when>
	</c:choose>
</div>