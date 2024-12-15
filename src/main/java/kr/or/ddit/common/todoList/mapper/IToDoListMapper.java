package kr.or.ddit.common.todoList.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.todoList.vo.ToDoVO;

public interface IToDoListMapper {

	public int countList(PaginationInfoVO<ToDoVO> pageVO);

	public int insertTodo(ToDoVO todoVO);

	public List<ToDoVO> dayTodo(int memNo);

	public int delTodo(int tdNo);

	public List<ToDoVO> weekTodo(int memNo);

	public List<ToDoVO> monthTodo(int memNo);

	public int updateTodo(ToDoVO todoVO);

	public List<ToDoVO> allList(int memNo);
	
	public List<ToDoVO> monthModel(ToDoVO todoVO);
	public List<ToDoVO> weekModel(ToDoVO todoVO);
	public List<ToDoVO> dayModel(ToDoVO todoVO);

	public int finTodo(ToDoVO todoVO);

	public Map<String, Object> finTotal(ToDoVO todoVO);

	public int insertTodo1(ToDoVO todoVO);




	

}
