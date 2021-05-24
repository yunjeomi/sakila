package com.gd.sakila;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@ServletComponentScan	//이 프로젝트의 메인 메소드가 실행하는 것 외 다른 것을 스캔하도록 도와준다. -> filter메소드
@SpringBootApplication
@EnableScheduling	//@Scheduled된 메소드가 있으면 얘가 실행시켜준다. -> 어디든지 존재해도 된다.
public class SakilaApplication {

	public static void main(String[] args) {
		SpringApplication.run(SakilaApplication.class, args);
		//@Controller, @Mapper, @Service, .... 스프링이 기존에 갖고있는 @만 스캔을 한다.
	}

}
