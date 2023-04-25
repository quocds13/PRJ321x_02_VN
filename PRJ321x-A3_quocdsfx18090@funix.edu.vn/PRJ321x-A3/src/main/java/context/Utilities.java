package context;

import java.util.Base64;

public class Utilities {
	private static Utilities instance;
	public static Utilities getInstance() {
		if(instance == null) 
			instance = new Utilities();
		return instance;
	}
	public Utilities () {}
	
	public String enCodeBase64(String urlString) {
		return Base64.getUrlEncoder().encodeToString(urlString.getBytes());
	}
	public String deCodeBase64(String urlString) {
		byte[] decodedBytes = Base64.getUrlDecoder().decode(urlString);
		return new String(decodedBytes);
	}
}
