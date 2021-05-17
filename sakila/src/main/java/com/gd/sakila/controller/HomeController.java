package com.gd.sakila.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j		//log를 사용하기 위해
@Controller	//서블릿을 사용하기 위해
public class HomeController {
	//Logger log = LoggerFactory.getLogger(this.getClass());	//(Homecontroller.class);
	@GetMapping({"/", "/home", "/index"})	//mapping을 배열타입으로; 셋의 요청을 전부다 실행한다.
	public String home() {
		//System.out.println("home...; 이 출력되고 404에러가 떴다? -> 컨트롤러까지 들어왔지만 view를 찾지 못했다.");	//최소한의 디버깅 코드는 2개를 출력하자.
		log.debug("home...");
		return "home";
	}
	
}
