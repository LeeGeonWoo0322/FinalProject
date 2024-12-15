package kr.or.ddit.common.todoList.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.todoList.vo.ToDoVO;

public interface IToDoListService {


//	public List<ToDoVO> listToDo(PaginationInfoVO<ToDoVO> todoVO, Authentication auth);
//	
//	public int countList(PaginationInfoVO<ToDoVO> todoVO, Authentication auth);

	public ServiceResult insertTodo(ToDoVO todoVO);

	public List<ToDoVO> dayTodo(Authentication auth);

	public ServiceResult delTodo(int tdNo);

	public List<ToDoVO> mainTodo(Authentication auth);

	public List<ToDoVO> weekTodo(Authentication auth);

	public List<ToDoVO> monthTodo(Authentication auth);

	public ServiceResult updateTodo(ToDoVO todoVO);

	public List<ToDoVO> allList(Authentication auth);

	public ServiceResult finTodo(ToDoVO todoVO);

	public List<ToDoVO> dayModal(ToDoVO todoVO, Authentication auth);

	public List<ToDoVO> weekModal(ToDoVO todoVO, Authentication auth);

	public List<ToDoVO> monthModal(ToDoVO todoVO, Authentication auth);

	public List<Map<String, Object>> finTotal(ToDoVO todoVO, Authentication auth);

	public Map<String, Object> insertTodo1(ToDoVO todoVO, Authentication auth);

	public List<ToDoVO> homeTodo(int memNo);








}
