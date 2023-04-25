package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import dao.AccountDAO;
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if (session.getAttribute("usermail") == null) {
			req.getRequestDispatcher("login.jsp").forward(req, resp);
		} else {
			req.getRequestDispatcher("/home").forward(req, resp);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = request.getSession();
			// Lấy giá trị para trên URL
			String usermail = request.getParameter("usermail");
			String password = request.getParameter("password");
			String action = request.getParameter("action-login");
			String checkRemember = request.getParameter("checkRemb");
			// Chức năng nhớ mật khẩu
			Cookie cookie = new Cookie("uname", usermail);
			Cookie cookie2 = new Cookie("checkRemb", checkRemember);
			if (checkRemember == null) {
				cookie.setValue("");
				cookie2.setValue(null);
			}
			response.addCookie(cookie);
			response.addCookie(cookie2);

			// Khởi tạo mới đối tượng account check vaidate form
			Account account = new Account(usermail, password, "", "", "", 0);
//			
//			// Lấy para init trong web.xml
//			String uname = getServletContext().getInitParameter("username");
//			String upass = getServletContext().getInitParameter("password");

			if (action.equals("login")) {
				//status = 1 o trang thai login k check tai khoan da ton tai
				if (account.isvalidation(1)) {
					if (AccountDAO.getInstance().loginAcc(usermail,password)) {
						Account acc = AccountDAO.getInstance().getRole(usermail);
						account.setRole(acc.getRole());
						account.setName(acc.getName());
						session.setAttribute("username", account.getName());
						session.setAttribute("usermail", account.getUsermail());
						//0: admin; 1: tai khoan thuong
						if (account.getRole() == 1) {
							request.getRequestDispatcher("/index").forward(request, response);
						} else {
							request.getRequestDispatcher("/main").forward(request, response);
						}
					} else {
						request.setAttribute("validation", "Username or Password is invalid");
						request.getRequestDispatcher("/login.jsp").forward(request, response);
					}
				} else {
					request.setAttribute("validation", account.getValadiation());
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}
			request.getRequestDispatcher("/main").forward(request, response);
		} catch (Exception e) {
			response.getWriter().println(e.getMessage());
		}

	}

}
