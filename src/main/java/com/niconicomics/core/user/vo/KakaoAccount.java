package com.niconicomics.core.user.vo;

import lombok.Data;

@Data
public class KakaoAccount {

	private boolean profile_needs_agreement;
	private KakaoProfile profile;
	private boolean email_needs_agreement;
	private boolean is_email_valid;
	private boolean is_email_verified;
	private String email;
	private boolean age_range_needs_agreement;
	private String age_range;
	private boolean birthday_needs_agreement;
	private String birthday;
	private boolean gender_needs_agreement;
	private String gender;
	
}
