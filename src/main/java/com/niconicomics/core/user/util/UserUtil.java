package com.niconicomics.core.user.util;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserUtil {
	public static String makeSalt() {
		String salt ="";
		for(int i=0; i<2; i++) {
			int rndVal = (int)(Math.random() * 62); 
    		if(rndVal < 10) { 
    			salt += rndVal; 
    		} else if(rndVal > 35) { 
    			salt += (char)(rndVal + 61);
    		} else { 
    			salt += (char)(rndVal + 55);
    		}
		}
		return salt;
	}
	
	public static String hashBySHA256(String input, String salt) {
		String result = "";
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("SHA-256");
			digest.reset();
			digest.update((salt+input).getBytes("utf8"));
			result =  String.format("%064x", new BigInteger(1, digest.digest()));
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return result;
	}

}
