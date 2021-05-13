package com.gd.sakila.vo;

import lombok.Data;

@Data
//페이징을 위한 vo
public class Page {
	private int beginRow;
	private int rowPerPage;
	private String searchWord;
}
