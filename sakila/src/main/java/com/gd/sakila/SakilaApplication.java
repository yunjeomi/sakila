package com.gd.sakila;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan	//이 프로젝트의 메인 메소드가 실행하는 것 외 다른 것을 스캔하도록 도와준다.
@SpringBootApplication
public class SakilaApplication {

	public static void main(String[] args) {
		SpringApplication.run(SakilaApplication.class, args);
		//@Controller, @Mapper, @Service, .... 스프링이 기존에 갖고있는 @만 스캔을 한다.
	}

}
