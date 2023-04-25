package model;

public class Product {
	private int product_id;
	private String product_name , product_des, product_img_source, product_type, product_brand;
	private float product_price;
	
	public Product() {}
	public Product(int product_id, String product_name, String product_des, String product_img_source,
			String product_type, String product_brand, float product_price) {
		this.product_id = product_id;
		this.product_name = product_name;
		this.product_des = product_des;
		this.product_img_source = product_img_source;
		this.product_type = product_type;
		this.product_brand = product_brand;
		this.product_price = product_price;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_des() {
		return product_des;
	}
	public void setProduct_des(String product_des) {
		this.product_des = product_des;
	}
	public String getProduct_img_source() {
		return product_img_source;
	}
	public void setProduct_img_source(String product_img_source) {
		this.product_img_source = product_img_source;
	}
	public String getProduct_type() {
		return product_type;
	}
	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	public float getProduct_price() {
		return product_price;
	}
	public void setProduct_price(float product_price) {
		this.product_price = product_price;
	}
	
	
}
