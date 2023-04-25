package bean;

public class Cart {
	private int order_id, product_id, amount_product;
	private String product_name,  user_name, user_address, user_phone, order_discount_code;  
	private float product_price;
	
	public Cart () {}
	public Cart(int order_id, int product_id, int amount_product, String product_name, String user_name,
			String user_address, String user_phone, String order_discount_code, float product_price) {
		super();
		this.order_id = order_id;
		this.product_id = product_id;
		this.amount_product = amount_product;
		this.product_name = product_name;
		this.user_name = user_name;
		this.user_address = user_address;
		this.user_phone = user_phone;
		this.order_discount_code = order_discount_code;
		this.product_price = product_price;
	}
	public float getTotal_price() {
		return product_price * amount_product;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getAmount_product() {
		return amount_product;
	}
	public void setAmount_product(int amount_product) {
		this.amount_product = amount_product;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getOrder_discount_code() {
		return order_discount_code;
	}
	public void setOrder_discount_code(String order_discount_code) {
		this.order_discount_code = order_discount_code;
	}
	public float getProduct_price() {
		return product_price;
	}
	public void setProduct_price(float product_price) {
		this.product_price = product_price;
	}
	
	
}
