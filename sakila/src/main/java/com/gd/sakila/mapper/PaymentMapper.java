package com.gd.sakila.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
	Double selectPaymentByCustomer(int customerId);
}
