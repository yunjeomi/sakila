package com.gd.sakila.vo;

import lombok.Data;

@Data
public class CustomerForm {
	private Customer customer;
	private Address address;
	private City city;
	private Country country;
	private String addCity;
}
