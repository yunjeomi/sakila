package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Staff;

@Mapper	//bean에 mapper를 생성
public interface StaffMapper {	
	//xml Mapper를 사용하지 않는 경우 여기다 쿼리를 작성.. 하지만 xml로 쿼리를 분리해놨는데 굳이 여기다 쿼리를 작성할 이유 없다.
	Staff selectStaffByLogin(Staff staff);
	
	//가져올 정보 : view-staff_list
	List<Map<String, Object>> selectStaffList();
	int insertStaff(Staff staff);
}
