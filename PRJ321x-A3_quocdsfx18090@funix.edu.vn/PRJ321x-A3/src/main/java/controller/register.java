package controller;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.AccountDAO;
import model.Account;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			resp.sendRedirect("./register.jsp");
		}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String uname = "", umail = "", uphone = "", uaddress = "", upass = "", upassAgain = "";
		if (action.equals("register")) {
			Enumeration<String> listPara = request.getParameterNames();
			while (listPara.hasMoreElements()) {
				String para = listPara.nextElement();
				if (para.equals("username")) {
					uname = new String(request.getParameter(para).getBytes("iso-8859-1"), "utf-8");
				} else if (para.equals("usermail")) {
					umail = request.getParameter(para);
				} else if (para.equals("userphone")) {
					uphone = request.getParameter(para);
				} else if (para.equals("user_address")) {
					//giải mã ký tự UTF-8
					uaddress = new String(request.getParameter(para).getBytes("iso-8859-1"), "utf-8");
				} else if (para.equals("password")) {
					upass = request.getParameter(para);
				} else if (para.equals("password-again")) {
					upassAgain = request.getParameter(para);
				}
			}

			Account account = new Account(umail, upass, uname, uaddress, uphone, 0);			
			if (account.isvalidation(0)) {
				if (upass.equals(upassAgain)) {
					
					if (AccountDAO.getInstance().registryAcc(account)) {
						request.getRequestDispatcher("/register.jsp?action=success").forward(request, response);
					} else {
						request.getRequestDispatcher("/register.jsp?action=errors").forward(request, response);
					}
				} else {
					request.setAttribute("validation", "Passwords are not the same");
				}
			} else {
				request.setAttribute("validation", account.getValadiation());
			}
		}
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}
}
