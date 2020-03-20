package com.niconicomics.core.nico.vo;

import java.util.Map;

import lombok.Data;

@Data
public class KakaoPayApprove {

	private String aid; // Request 고유 번호 String
	private String tid; // 결제 고유 번호 String
	private String cid; // 가맹점 코드 String
	private String sid; // subscription id. 정기(배치)결제 CID로 결제요청한 경우 발급 String
	private String partner_order_id; // 가맹점 주문번호 String
	private String partner_user_id; // 가맹점 회원 id String
	private String payment_method_type; // 결제 수단. CARD, MONEY 중 하나 String
	private Map<String, String> amount; // 결제 금액 정보 JSON Object
	private Map<String, String> card_info; // 결제 상세 정보(결제수단이 카드일 경우만 포함) JSON Object
	private String item_name; // 상품 이름. 최대 100자 String
	private String item_code; // 상품 코드. 최대 100자 String
	private int quantity; // 상품 수량 Integer
	private String created_at; // 결제 준비 요청 시각 Datetime
	private String approved_at; // 결제 승인 시각 Datetime
	private String payload; // Request로 전달한 값 String

}
