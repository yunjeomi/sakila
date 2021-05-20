package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Boardfile {
	private int boardFileId;
	private int boardId;
	private String boardfileName;
	private String boardfileType;
	private long boardfileSize; 
}
