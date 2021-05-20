package com.gd.sakila.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.sakila.service.StaffService;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j		//log를 사용하기 위해
@Controller	//서블릿을 사용하기 위해
public class HomeController {
	@Autowired StaffService staffService;	//의존객체 주입
	
	//Logger log = LoggerFactory.getLogger(this.getClass());	//(Homecontroller.class);
	
	//로그인 페이지
	@GetMapping({"/", "/home", "/index"})	//mapping을 배열타입으로; 셋의 요청을 전부다 실행한다.
	public String home() {
		//System.out.println("home...; 이 출력되고 404에러가 떴다? -> 컨트롤러까지 들어왔지만 view를 찾지 못했다.");	//최소한의 디버깅 코드는 2개를 출력하자.
		log.debug("●●●●▶home...");
		return "home";
	}
	
	//로그인 action
	@PostMapping("/login")
	public String login(HttpSession session, Staff staff) {	//HttpSession을 직접 가져왔음(spring 기능)
		//log.debug("●●●●▶login staff param-> "+staff.toString()); //service에서 debugging하였음
		
		Staff loginStaff = staffService.login(staff);
		log.debug("●●●●▶login staff return-> "+loginStaff);
		
		//로그인 성공 -> 세션에 로그인 정보를 저장하자.
		if(loginStaff != null) {
			session.setAttribute("loginStaff", loginStaff); //new Staff();
		}
		return "redirect:/";
	}
	
	//logout 클릭 -> get; 매개값으로 직접 HttpSession 넣을 수 있음
	@GetMapping("/admin/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		log.debug("●●●●▶로그아웃 완료");
		return "redirect:/";
	}
}
