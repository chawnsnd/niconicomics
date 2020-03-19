package com.niconicomics.core.nico.util;

public class RandomScope {

	public static String make(int digits) {
		String tempPassword = ""; 
    	for(int i=0; i<digits; i++) { 
    		int rndVal = (int)(Math.random() * 62); 
    		if(rndVal < 10) { 
    			tempPassword += rndVal; 
    		} else if(rndVal > 35) { 
    			tempPassword += (char)(rndVal + 61);
    		} else { 
    			tempPassword += (char)(rndVal + 55);
    		}
    	}
    	return tempPassword;
	}
	
}
