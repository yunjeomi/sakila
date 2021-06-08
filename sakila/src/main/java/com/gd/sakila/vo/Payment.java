package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Payment {
	private int paymentId;
	private int customerId;
	private int staffId;
	private int rentalId;
	private double amount;
	private String paymentdate;
	private String lastUpdate;
}
