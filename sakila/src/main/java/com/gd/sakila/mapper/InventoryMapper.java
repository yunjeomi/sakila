package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Inventory;

@Mapper
public interface InventoryMapper {
	List<Map<String, Object>> selectInventoryList(Map<String, Object> map);
	int selectInventoryTotal(Map<String, Object> map);
	int insertInventory(Inventory inventory);
	int selectLastInventoryId(Inventory inventory);
	int deleteInventory(int inventoryId);
}
