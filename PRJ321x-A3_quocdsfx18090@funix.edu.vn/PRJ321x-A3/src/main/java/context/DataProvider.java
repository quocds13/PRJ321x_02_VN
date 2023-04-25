package context;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import com.microsoft.sqlserver.jdbc.*;

public class DataProvider {
	private static DataProvider instance;
	private Connection con = null;
	private SQLServerDataSource ds = null;

	public DataProvider() throws SQLServerException {
		ds = new SQLServerDataSource();
		ds.setUser("sa");
		ds.setPassword("12345678");
		ds.setServerName("localhost");
		ds.setPortNumber(1433);
		ds.setDatabaseName("ShoppingDB");
		ds.setEncrypt("false");
	}

	public static DataProvider getInstance() throws SQLServerException {
		if (instance == null)
			instance = new DataProvider();
		return instance;
	}

	public void closeConect() {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ResultSet excResultSet(String query, Object[] para) {
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			try {
				if (para == null) {
					Statement stmt = con.createStatement();	
					rs = stmt.executeQuery(query);
				}else {
					CallableStatement pstmt = con.prepareCall(query);
					int i = 1;
					for(Object t : para) {
						if (t instanceof Byte) {
							pstmt.setInt(i, ((Byte) t).intValue());
			            } else if (t instanceof String) {
			            	pstmt.setString(i, (String) t);
			            } else if (t instanceof Integer) {
			            	pstmt.setInt(i, ((Integer) t).intValue());
			            } else if (t instanceof Long) {
			            	pstmt.setLong(i, ((Long) t).longValue());
			            } else if (t instanceof Float) {
			            	pstmt.setFloat(i, ((Float) t).floatValue());
			            } else if (t instanceof Double) {
			            	pstmt.setDouble(i, ((Double) t).doubleValue());
			            } else if (t instanceof byte[]) {
			            	pstmt.setBytes(i, (byte[]) t);
			            } else if (t instanceof java.sql.Date) {
			            	pstmt.setDate(i, (java.sql.Date) t);
			            }
						i++;
					}
                    rs = pstmt.executeQuery();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// Iterate through the data in the result set and display it.
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public int excNonQuery(String query, Object[] para) {
		int rs = 0;
		try {
			con = ds.getConnection();
			try {
				if (para == null) {
					Statement stmt = con.createStatement();	
					rs = stmt.executeUpdate(query);
				}else {
					CallableStatement pstmt = con.prepareCall(query);
					int i = 1;
					for(Object t : para) {
						if (t instanceof Byte) {
							pstmt.setInt(i, ((Byte) t).intValue());
			            } else if (t instanceof String) {
			            	pstmt.setString(i, (String) t);
			            } else if (t instanceof Integer) {
			            	pstmt.setInt(i, ((Integer) t).intValue());
			            } else if (t instanceof Long) {
			            	pstmt.setLong(i, ((Long) t).longValue());
			            } else if (t instanceof Float) {
			            	pstmt.setFloat(i, ((Float) t).floatValue());
			            } else if (t instanceof Double) {
			            	pstmt.setDouble(i, ((Double) t).doubleValue());
			            } else if (t instanceof byte[]) {
			            	pstmt.setBytes(i, (byte[]) t);
			            } else if (t instanceof java.sql.Date) {
			            	pstmt.setDate(i, (java.sql.Date) t);
			            }
						i++;
					}
                    rs = pstmt.executeUpdate();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// Iterate through the data in the result set and display it.
		} catch (SQLServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
}
