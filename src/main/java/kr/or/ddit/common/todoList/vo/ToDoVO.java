package kr.or.ddit.common.todoList.vo;

import lombok.Data;

@Data
public class ToDoVO {

	private int tdNo;
	private int memNo;
	private String finYn;
	private String regDate;
	
	private String tdContent;
	private String importYn;
	private String tdType;
	private String [] tdTypeList;
	private String [] regDateList;
	private int rownum;
	private int finTodo;
	private int totalTodo;
}
