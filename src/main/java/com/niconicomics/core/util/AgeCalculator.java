package com.niconicomics.core.util;

import java.time.LocalDate;
import java.time.Period;

public class AgeCalculator {
    public static int calculateAge(String birthDate) {
    	LocalDate localDate = LocalDate.parse(birthDate);
        if ((birthDate != null)) {
            return Period.between(localDate, LocalDate.now()).getYears();
        } else {
            return 0;
        }
    }
}