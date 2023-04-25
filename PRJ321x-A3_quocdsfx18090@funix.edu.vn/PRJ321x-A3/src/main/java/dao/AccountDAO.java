package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.microsoft.sqlserver.jdbc.SQLServerException;
import context.DataProvider;
import model.Account;

public class AccountDAO {
	private static AccountDAO instance;
	public static AccountDAO getInstance() {
		if(instance == null) 
			instance = new AccountDAO();
		return instance;
	}
	
	public boolean loginAcc(String uml, String pw) throws SQLException {
		boolean rs = false;
		try {
			ResultSet kq = DataProvider.getInstance().excResultSet("{call getAccount (?, ?)}", new Object[] {uml, pw});
			while(kq.next()) {
				rs = kq.getInt("count")>0?true:false;
				break;
			}
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public Account getRole (String uml ) throws SQLException {
		Account acc = new Account();
		try {
			ResultSet rs = DataProvider.getInstance().excResultSet("{call getRole (?)}", new Object[] {uml});
			while(rs.next()) {
				acc.setRole(rs.getInt("account_role"));
				acc.setName(rs.getString("user_name"));
				break;
			}
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return acc;
	}
	public boolean checkUserMailAlreadyExist (String usermail) {
		boolean rs = false;
		try {
			ResultSet resultSet = DataProvider.getInstance().excResultSet("Select count(*) as count from Account where user_mail = '"+usermail+"'", null);
			while(resultSet.next()) {
				if(resultSet.getInt(1)==0)
					rs = true;
				break;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public boolean registryAcc(Account acc) {
		boolean rs = false;
		//status 0 o trang thai dang ky kiem tra tk da ton tai chua
		if(acc.isvalidation(0)) {
			try {
				rs= DataProvider.getInstance().excNonQuery("{call registryAccount (?, ?, ?, ?, ?, ?)}",
						new Object[] {acc.getUsermail(), acc.getPassword(),acc.getName(), acc.getAddress(), acc.getPhone(), acc.getRole()})>0?true:false;
			} catch (SQLServerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return rs;
	}
}
