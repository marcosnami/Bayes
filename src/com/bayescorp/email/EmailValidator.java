package com.bayescorp.email;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailValidator {

	private static Pattern pattern = Pattern.compile("^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
 
    public static boolean validateEmailAddress(String email){
        
        Matcher mtch = pattern.matcher(email);
        if(mtch.matches()){
            return true;
        }
        return false;
    }

}
