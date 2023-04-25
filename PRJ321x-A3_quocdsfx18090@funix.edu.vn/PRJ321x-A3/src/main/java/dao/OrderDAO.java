package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.microsoft.sqlserver.jdbc.SQLServerException;
import bean.Cart;
import context.DataProvider;


public class OrderDAO {
	private static OrderDAO instance;
	private float totalBill;

	public static OrderDAO getInstance() {
		if (instance == null)
			instance = new OrderDAO();
		return instance;
	}
	
	
	public float getTotalBill() {
		return this.totalBill;
	}
	
	public boolean createBill(String userMail, int productId, int amount, String discount) {
		boolean result = false;
		try {
			int rs = DataProvider.getInstance().excNonQuery("{call createBill (?, ?, ?, ?)}",
					new Object[] { userMail, productId, amount, discount });
			if (rs > 0) {
				result = true;
			}
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<Cart> getCartNotPay(String userMail) {
		ArrayList<Cart> list = new ArrayList<>();
		totalBill = 0;
		try {
			ResultSet rs = DataProvider.getInstance().excResultSet("{call dbo.getCartNotPay (?)}",
					new Object[] { userMail });
			try {
				while (rs.next()) {
					Cart cart = new Cart(rs.getInt("order_id"), rs.getInt("product_id"), rs.getInt("amount_product"),
							rs.getString("product_name"), rs.getString("user_name"), rs.getString("user_address"),
							rs.getString("user_phone"), rs.getString("order_discount_code"),
							rs.getFloat("product_price"));
					list.add(cart);
					totalBill += cart.getTotal_price();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public void UpdateOrderList(int orderId, int productId, int status) {
		try {
			DataProvider.getInstance().excNonQuery("{call dbo.UpdateOrderList (?, ? ,?)}",
					new Object[] { orderId, productId, status });
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public boolean payBill(int orderId) {
		int rs = 0;
		if (totalBill > 0) {
			try {
				rs = DataProvider.getInstance().excNonQuery("{call dbo.storePayBill (?)}",
						new Object[] {orderId});
			} catch (SQLServerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return rs > 0;
	}
}
