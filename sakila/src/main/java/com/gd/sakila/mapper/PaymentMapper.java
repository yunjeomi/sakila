package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Payment;

@Mapper
public interface PaymentMapper {
	Double selectPaymentByCustomer(int customerId);
	List<Map<String, Object>> selectSalesListByCategory();
	List<Map<String, Object>> selectBestSellerList();
	List<Map<String, Object>> selectSalesListByStore();
	int insertPayment(Payment payment);
	Double selectAmountFromRentalDate(int rentalId);
}
