package web.until;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MaHoa {
	public static String toMD5(String str) {
	String result = null;
	try
	{
		// Khởi tạo đối tượng MessageDigest với thuật toán MD5
		MessageDigest md = MessageDigest.getInstance("MD5");

		// Chuyển đổi chuỗi thành mảng byte
		byte[] dataBytes = str.getBytes();

		// Mã hóa mảng byte
		byte[] digestBytes = md.digest(dataBytes);

		// Chuyển đổi kết quả thành chuỗi hexa
		StringBuilder sb = new StringBuilder();
		for (byte b : digestBytes) {
			sb.append(String.format("%02x", b));
		}
		result = sb.toString();
	} catch(NoSuchAlgorithmException e)
	{
		e.printStackTrace();
	}
	return result;
	}
	public static void main(String[] args) {
		System.out.println(toMD5("123456"));
	}
}
