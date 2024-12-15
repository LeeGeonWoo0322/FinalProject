package kr.or.ddit.common.todoList.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.mapper.IAccountMapper;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.security.vo.CustomUser;
import kr.or.ddit.common.todoList.mapper.IToDoListMapper;
import kr.or.ddit.common.todoList.service.IToDoListService;
import kr.or.ddit.common.todoList.vo.ToDoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ToDoListServiceImpl implements IToDoListService {
	@Inject
	private IToDoListMapper todoMap;
	
	@Inject
	private IAccountMapper memMap;

	
	// 모든 todo
	@Override
	public List<ToDoVO> allList(Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		return todoMap.allList(memberVO.getMemNo());
	}
	
	// 오늘의 todo
	@Transactional
	@Override
	public List<ToDoVO> dayTodo(Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		return todoMap.dayTodo(memberVO.getMemNo());
	}
	
	// 메인 todo이자 오늘의 투두
	@Override
	public List<ToDoVO> mainTodo(Authentication auth) {

		User user = (User) auth.getPrincipal();
		MemberVO memberVO = memMap.getMember(user.getUsername());
		
		return todoMap.dayTodo(memberVO.getMemNo());

		
	}
	
	// todo 생성
	@Transactional
	@Override
	public ServiceResult insertTodo(ToDoVO todoVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		todoVO.setMemNo(memberVO.getMemNo());
		ServiceResult res = null;
		int status = 0;
		status = todoMap.insertTodo(todoVO);
		
		if(status > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
		
	}

	// todo 삭제
	@Transactional
	@Override
	public ServiceResult delTodo(int tdNo) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		
		int status = 0;
		ServiceResult res = null;
		
		status = todoMap.delTodo(tdNo);
		
		if(status > 0 ) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}


	@Override
	public List<ToDoVO> weekTodo(Authentication auth) {
		
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = memMap.getMember(user.getUsername());
		
		return todoMap.weekTodo(memberVO.getMemNo());
	}


	@Override
	public List<ToDoVO> monthTodo(Authentication auth) {
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = memMap.getMember(user.getUsername());
		
		return todoMap.monthTodo(memberVO.getMemNo());
	}


	@Override
	public ServiceResult updateTodo(ToDoVO todoVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		todoVO.setMemNo(memberVO.getMemNo());
		int status = 0;
		ServiceResult res = null;
		
		status = todoMap.updateTodo(todoVO);
		if(status > 0 ) { 
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		
		return res;
	}

	@Override
	public ServiceResult finTodo(ToDoVO todoVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		todoVO.setMemNo(memberVO.getMemNo());
		
		int status = 0;
		ServiceResult res = null;
		status = todoMap.finTodo(todoVO);
		if(status > 0 ) { 
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		
		return res;
	}

	@Override
	public List<ToDoVO> dayModal(ToDoVO todoVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		todoVO.setMemNo(memberVO.getMemNo());
		
		
		return todoMap.dayModel(todoVO);
	}

	@Override
	public List<ToDoVO> weekModal(ToDoVO todoVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		todoVO.setMemNo(memberVO.getMemNo());
		
		
		
		return todoMap.dayModel(todoVO);
	}

	@Override
	public List<ToDoVO> monthModal(ToDoVO todoVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		todoVO.setMemNo(memberVO.getMemNo());
		
		
		
		
		return todoMap.dayModel(todoVO);
	}

	@Override
	public List<Map<String, Object>> finTotal(ToDoVO todoVO, Authentication auth) {
	    CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    MemberVO memberVO = customUser.getMember();
	    todoVO.setMemNo(memberVO.getMemNo());
	    
	    List<Map<String, Object>> res = new ArrayList<>();
	    
	    for (int i = 0; i < todoVO.getTdTypeList().length; i++) {
	        todoVO.setTdType(todoVO.getTdTypeList()[i]);
	        todoVO.setRegDate(todoVO.getRegDateList()[i]);
	        System.out.println(todoVO);
	       
	        Map<String, Object> status = todoMap.finTotal(todoVO);
	        System.out.println(status);
	        if(status != null) {
	        	res.add(status); 
	        } else {
	        	System.out.println("에러발새애애애애애앵");
	        }
	    }
	    System.out.println("res========="+res);
	    

	    return res;
	}

	@Override
	public Map<String, Object> insertTodo1(ToDoVO todoVO, Authentication auth) {
		Map<String,Object> res = new HashMap<>();
	 	CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    MemberVO memberVO = customUser.getMember();
	    todoVO.setMemNo(memberVO.getMemNo());
		int todo = todoMap.insertTodo1(todoVO);
		if(todo > 0) {
			res.put("status", "OK");
			res.put("todo", todoVO);
		} else {
			res.put("status", "FAILED");
		}
		
		return res;
	}

	@Override
	public List<ToDoVO> homeTodo(int memNo) {
		// TODO Auto-generated method stub
		return todoMap.dayTodo(memNo);
	}



	/*
	 * @Override public List<ToDoVO> listToDo(PaginationInfoVO<ToDoVO> pageVO,
	 * Authentication auth) { User user = (User) auth.getPrincipal(); MemberVO
	 * memberVO = memMap.getMember(user.getUsername());
	 * pageVO.setMemNo(memberVO.getMemNo());
	 * 
	 * return todoMap.listToDo(pageVO); }
	 * 
	 * 
	 * @Override public int countList(PaginationInfoVO<ToDoVO> pageVO,
	 * Authentication auth) { CustomUser customUser = (CustomUser)
	 * SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	 * MemberVO memberVO = customUser.getMember();
	 * pageVO.setMemNo(memberVO.getMemNo()); return todoMap.countList(pageVO); }
	 */
	
}
