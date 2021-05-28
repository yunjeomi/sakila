package com.gd.sakila.vo;

import java.util.List;

import lombok.Data;

@Data
public class FilmForm {
	private Category category;	//원래는 categoryId 이나, categoryId를 외래키로 잡아서 Category vo를 대신,,
	private Film film;			//원래는 filmId 또한 filmId를 외래키로 잡아서 Film vo를 대신 사용. 카테고리 하나에 여러 필름이 존재하기에 1:n관계이다.
	private String lastUpdate;
	private List<String> specialFeatures;
	
	//specialFeatures의 구분자는 ,이기 때문에 얘 없이 그냥 써도 되긴함.. 만약 db에서 ,가 아닌 / 띄어쓰기 등 다른 구분자로 구분하였을 때는
	//sb.append(sf+",")를 사용해서 구분해준다.
	//ex) Trailers, Behind the Scenes, 요 값이 Trailers, Behind the Scenes만 들어가도록
	public void setSpecialFeatures(List<String> specialFeatures) {
		if(specialFeatures != null) {
			StringBuffer sb = new StringBuffer();
			for(String sf : specialFeatures) {
				sb.append(sf+",");
			}
			this.film.setSpecialFeatures(sb.toString().substring(0, sb.toString().length()-1));
		}
	}
}
