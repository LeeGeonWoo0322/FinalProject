package kr.or.ddit.common.security.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.common.account.mapper.IAccountMapper;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.security.vo.CustomUser;

public class CustomUserDetailsService implements UserDetailsService{

	private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Inject
	private IAccountMapper loginMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("# CustomUserDetailsService:loadUserByUsername : " + username);
		
		try {
			MemberVO member = loginMapper.readByUserId(username);
			return member == null ? null : new CustomUser(member);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
