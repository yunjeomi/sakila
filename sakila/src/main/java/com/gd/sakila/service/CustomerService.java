package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;
import com.gd.sakila.mapper.CityMapper;
import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.mapper.CustomerMapper;
import com.gd.sakila.mapper.PaymentMapper;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Customer;
import com.gd.sakila.vo.CustomerForm;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class CustomerService {
	@Autowired CustomerMapper customerMapper;
	@Autowired PaymentMapper paymentMapper;
	@Autowired CountryMapper countryMapper;
	@Autowired CityMapper cityMapper;
	@Autowired AddressMapper addressMapper;
	
	public Map<String, Object> getCustomerList(int currentPage, int rowPerPage, String searchWord, Integer storeId){
		log.debug("●●●●▶ currentPage-> "+currentPage);
		log.debug("●●●●▶ rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ storeId-> "+storeId);
		
		Map<String, Object> getMap = new HashMap<>();
		getMap.put("rowPerPage", rowPerPage);
		getMap.put("searchWord", searchWord);
		getMap.put("storeId", storeId);
		
		//페이징할 때 필요한 것
		//totalPage, lastPage, beginRow
		//totalPage구하기 위해 위 값들을 먼저 넣는다.
		int beginRow = (currentPage-1)*rowPerPage;
		int totalRow = customerMapper.selectCustomerTotal(getMap);
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		log.debug("●●●●▶ totalRow-> "+totalRow);
		log.debug("●●●●▶ lastPage-> "+lastPage);
		
		//customerList얻기 위해 구한 beginRow를 map에 넣어준다.
		getMap.put("beginRow", beginRow);
		
		List<Map<String, Object>> customerList = customerMapper.selectCustomerList(getMap);
		log.debug("●●●●▶ customerList-> "+customerList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("customerList", customerList);
		map.put("lastPage", lastPage);
		map.put("totalRow", totalRow);
		
		return map;
	}
	
	public Map<String, Object> getCustomerOne(int customerId){
		log.debug("●●●●▶ customerId-> "+customerId);
		Map<String, Object> customerOne = customerMapper.selectCustomerOne(customerId);
		log.debug("●●●●▶ customerOne-> "+customerOne);
		Double payment = paymentMapper.selectPaymentByCustomer(customerId);
		log.debug("●●●●▶ 총 구매액 payment-> "+payment);
		
		//return null일 때, not null일 때 구분한다.
		//null -> 0 / not null -> 1
		List<Map<String, Object>> rentalListOfNull = customerMapper.selectRentalListByCustomer(customerId, 0);
		List<Map<String, Object>> rentalListOfNotNull = customerMapper.selectRentalListByCustomer(customerId, 1);
		log.debug("●●●●▶ 대여중 리스트 rentalListOfNull-> "+rentalListOfNull);
		log.debug("●●●●▶ 대여완료 리스트 rentalListOfNotNull-> "+rentalListOfNotNull);
		
		Map<String, Object> map = new HashMap<>();
		map.put("customerOne", customerOne);
		map.put("payment", payment);
		map.put("rentalListOfNull", rentalListOfNull);
		map.put("rentalListOfNotNull", rentalListOfNotNull);
		
		return map;
	}
	
	public Map<String, Object> getPhone(String phone) {
		return customerMapper.selectPhone(phone);
	}
	
	public void addCustomer(CustomerForm customerForm) {
		log.debug("●●●●▶ customerForm-> "+customerForm);
		//customerForm 에서 -> customer, country, city, address 꺼내 vo에 넣어준다.
		
		//address -> district 앞에만 대문자로 수정한다.
		String district = customerForm.getAddress().getDistrict().substring(0, 1).toUpperCase()+customerForm.getAddress().getDistrict().substring(1).toLowerCase();
		Address address = new Address();
		address.setAddress(customerForm.getAddress().getAddress());
		address.setAddress2(customerForm.getAddress().getAddress2());
		address.setDistrict(district);
		address.setCityId(customerForm.getCity().getCityId());
		address.setPostalCode(customerForm.getAddress().getPostalCode());
		address.setPhone(customerForm.getAddress().getPhone());
		log.debug("●●●●▶ address-> "+address);
		
		//customer; addressId는 address 추가 후 넣어준다.
		Customer customer = new Customer();
		customer.setStoreId(customerForm.getCustomer().getStoreId());
		//이름,성 -> 대문자 변환
		//email -> firstName.lastName@sakilacustomer.org
		String firstName = customerForm.getCustomer().getFirstName().toUpperCase();
		String lastName = customerForm.getCustomer().getLastName().toUpperCase();
		customer.setEmail(firstName+"."+lastName+"@sakilacustomer.org");
		customer.setFirstName(firstName);
		customer.setLastName(lastName);
		log.debug("●●●●▶ customer-> "+customer);
		
		//CustomerForm의 city.cityId 0이면(즉 city를 직접입력함), City 추가를 먼저 진행한다.
		
		//city.cityId == 0일 때 city 추가 메소드 실행. city명은 앞 문자만 대문자, 그외 소문자로 한다.
		if(customerForm.getCity().getCityId() == 0) {
			City city = new City();
			String cityName = customerForm.getCity().getCity().substring(0, 1).toUpperCase()+customerForm.getCity().getCity().substring(1).toLowerCase();
			city.setCity(cityName);
			city.setCountryId(customerForm.getCountry().getCountryId());
			log.debug("●●●●▶ city-> "+city);
			//city 추가 메소드
			int addCityCnt = cityMapper.insertCity(city);
			log.debug("●●●●▶ city 추가 완료 1, 실패 0-> "+addCityCnt);
			
			//cityId를 address의 cityId에 새로 넣어준다.
			address.setCityId(city.getCityId());
			log.debug("●●●●▶ 추가한 city의 cityId-> "+city.getCityId());
		}
		
		//0이 아닐 경우 Address 입력 메소드 실행. -> address 입력 후 addressId 얻어 와 customer에 넣어준다.
		int addAddressCnt = addressMapper.insertAddress(address);
		log.debug("●●●●▶ address 추가 완료 1, 실패 0-> "+addAddressCnt);
		customer.setAddressId(address.getAddressId());
		log.debug("●●●●▶ 추가한 address의 addressId-> "+address.getAddressId());
		
		//city 추가 후 customer 등록 메소드 실행.
		int addCustomerCnt = customerMapper.insertCustomer(customer);
		log.debug("●●●●▶ customer 추가 완료 1, 실패 0-> "+addCustomerCnt);
		
	}
	
	public void modifyCustomerActiveByScheduler() {
		log.debug("●●●●▶ modifyCustomerActiveByScheduler()실행");
		int cnt = customerMapper.updateCustomerActiveByScheduled();
		log.debug("●●●●▶ 휴면고객 처리 수-> "+cnt);
	}
}
