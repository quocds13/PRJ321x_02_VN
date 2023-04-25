package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import context.DataProvider;
import model.Product;

public class ProductDAO {
	private static ProductDAO instance;
	public static ProductDAO getInstance() {
		if(instance == null) 
			instance = new ProductDAO();
		return instance;
	}
	
	public int getSize() throws SQLException {
		int size = 0;
		ResultSet rs = DataProvider.getInstance().excResultSet("Select count(*) from Products", null);
		while (rs.next()) {
			size = rs.getInt(1);
		}
		return size;
	}
	//show Products - query sql
	public ArrayList<Product> getListProducts(int pageNumber, int productDisplayNumber) throws SQLException {
		ArrayList<Product> list = new ArrayList<Product>();
		ResultSet rs = DataProvider.getInstance().excResultSet("{call sp_getPaging(?, ?)}", new Object[] {pageNumber,productDisplayNumber});
		while (rs.next()) {
			Product product = new Product(rs.getInt("product_id"), rs.getString("product_name"), rs.getString("product_des"), rs.getString("product_img_source"), rs.getString("product_type"), rs.getString("product_brand"), rs.getFloat("product_price"));
			list.add(product);
		}
		return list;
	}
	//search Products - call Store Produce
	public ArrayList<Product> getListProducts(String keyword) throws SQLException {
		ArrayList<Product> list = new ArrayList<Product>();
		ResultSet rs = DataProvider.getInstance().excResultSet("{call dbo.searchProduct(?)}", new Object [] {keyword});
		while (rs.next()) {
			Product product = new Product(rs.getInt("product_id"), rs.getString("product_name"), rs.getString("product_des"), rs.getString("product_img_source"), rs.getString("product_type"), rs.getString("product_brand"), rs.getFloat("product_price"));
			list.add(product);
		}
		return list;
	}
	//[get/search] Product by id - call Store Produce
	public Product getProductByID(int id_product) throws SQLException {
		Product product = new Product();
		ResultSet rs = DataProvider.getInstance().excResultSet("{call dbo.getProductById(?)}", new Object [] {id_product});
		while (rs.next()) {
			product= new Product(rs.getInt("product_id"), rs.getString("product_name"), rs.getString("product_des"), rs.getString("product_img_source"), rs.getString("product_type"), rs.getString("product_brand"), rs.getFloat("product_price"));
		}
		return product;
	}
	
}
