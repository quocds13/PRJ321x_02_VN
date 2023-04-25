package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.Cart;
import dao.OrderDAO;
import dao.ProductDAO;
import model.Product;

@WebServlet("/main")
public class main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		String keyword_search = request.getParameter("keyword");
		String product_id = request.getParameter("product_id");
		String userMail = (String) session.getAttribute("usermail");
		String numberDisplayProduct = request.getParameter("num");
		ArrayList<Product> products = null;
		ArrayList<Cart> carts = null;
		Product product = null;
		try {
			if (action == null) {
				if (numberDisplayProduct == null)
					products = ProductDAO.getInstance().getListProducts(1, 8);
				else {
					products = ProductDAO.getInstance().getListProducts(1, Integer.parseInt(numberDisplayProduct));
				}
				if (userMail != null) {
					carts = OrderDAO.getInstance().getCartNotPay(userMail);
					if (carts != null) {
						session.setAttribute("carts", carts);
					}
				}			
			} else if (action.equals("paging")) {
				int numberPage = Integer.parseInt(request.getParameter("id"));
				products = ProductDAO.getInstance().getListProducts(numberPage, Integer.parseInt(numberDisplayProduct));
			} else if (action.equals("get_Product_by_id")) {
				product = ProductDAO.getInstance().getProductByID(Integer.parseInt(product_id));
			} else if (action.equals("search")) {
				products = ProductDAO.getInstance().getListProducts(keyword_search);
			} else if (action.equals("view-Cart")) {
				if (userMail != null) {
					carts = OrderDAO.getInstance().getCartNotPay(userMail);
					if (carts != null) {
						session.setAttribute("carts", carts);
						session.setAttribute("totalBill", OrderDAO.getInstance().getTotalBill());
					}

				} else {
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
			} else if (action.equals("update")) {
				Integer status = Integer.parseInt(request.getParameter("status"));
				Integer order_id = Integer.parseInt(request.getParameter("order_id"));
				OrderDAO.getInstance().UpdateOrderList(order_id, Integer.parseInt(product_id), status);
				request.getRequestDispatcher("/main?action=view-Cart").forward(request, response);
//				response.sendRedirect(request.getContextPath()+"/main?action=view-Cart");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (products != null) {
			session.setAttribute("products", products);
			try {
				int size = ProductDAO.getInstance().getSize();
				session.setAttribute("sizeProducts", size);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		if (product != null)
			session.setAttribute("product", product);
		request.getRequestDispatcher("/home.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String keyword_search = request.getParameter("keyword");
		HttpSession session = request.getSession();
		String userMail = (String) session.getAttribute("usermail");
		ArrayList<Product> products = null;
		ArrayList<Cart> carts1 = null;
		try {
			if (action == null || action.equals("success") || action.equals("errors")) {
				products = ProductDAO.getInstance().getListProducts(1, 8);
				if (userMail != null) {
					carts1 = OrderDAO.getInstance().getCartNotPay(userMail);
					if (carts1 != null) {
						session.setAttribute("carts", carts1);
					}
				}
			} else if (action.equals("search")) {
				products = ProductDAO.getInstance().getListProducts(keyword_search);
			} else if (action.equals("payBill")) {
				@SuppressWarnings("unchecked")
				ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
				if (carts != null) {
					int order_id = 0;
					for (Cart c : carts) {
						if (c.getOrder_id() != order_id) {
							order_id = c.getOrder_id();
							OrderDAO.getInstance().payBill(order_id);
						}
					}
					request.getRequestDispatcher("/main?action=success").forward(request, response);
				}
			}
		} catch (SQLException e) {
			request.getRequestDispatcher("/main?action=errors").forward(request, response);
		}
		if (products != null)
			session.setAttribute("products", products);
		request.getRequestDispatcher("/home.jsp").forward(request, response);
	}
}
