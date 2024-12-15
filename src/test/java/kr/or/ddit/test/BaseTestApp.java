package kr.or.ddit.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.or.ddit.common.account.mapper.IAccountMapper;
import kr.or.ddit.common.account.vo.MemberVO;

public class BaseTestApp {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
					new String[] {"kr/or/ddit/test/test-context.xml"}
				);
		IAccountMapper accountMapper = (IAccountMapper)context.getBean("IAccountMapper");
		MemberVO memberVO = accountMapper.getMember("user_002");
		System.out.println(memberVO);
	}
}
