package bbs;

import java.math.BigInteger;
import java.security.MessageDigest;

public class SHA {
	
	// uses SHA-512 algorithm to generate hash for input string
	public String getSHA512(String input){

		String toReturn = null;
		try {
		    MessageDigest digest = MessageDigest.getInstance("SHA-512");
		    digest.reset();
		    digest.update(input.getBytes("utf8"));
		    toReturn = String.format("%0128x", new BigInteger(1, digest.digest()));
		} catch (Exception e) {
		    e.printStackTrace();
		}
		
		return toReturn;
	    }
}