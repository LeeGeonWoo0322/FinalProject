package kr.or.ddit.common.todoList.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.todoList.service.IToDoListService;
import kr.or.ddit.common.todoList.vo.ToDoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/todo")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class ToDoListController {
	
	@Inject
	private IToDoListService todoService;
	
	
	
//	// 완료 갯수, 총 갯수 확인용
//	@PostMapping("/finTotal")
//	public ResponseEntity<Map<String,Object>> finTotal(@RequestBody ToDoVO todoVO, Authentication auth) {
//		Map<String,Object> response = new HashMap<>();
//		ResponseEntity<Map<String, Object>> finTotalTodo = todoService.finTotal(todoVO,auth);
//		if(finTotalTodo != null) {
//			response.put("status", "success");
//			response.put("todoVO", todoVO);
//		} else {
//			response.put("status", "fail");
//		}
//		return ResponseEntity.ok(response);	
//	}
//	
	
	@GetMapping("/autoHome") 
	public String autoHome (){
		return "todo/autoHome";
	}
	
//	@PostMapping("/autoMake")
//	public ResponseEntity<Map<String, Object>> autoMake(@RequestBody ToDoVO todoVO, Authentication auth) {
//		 Map<String, Object> response = new HashMap<>();
//		 
//		 
//		 return ResponseEntity.ok(response);
//	}
	
	@PostMapping("/finTotal")
	public ResponseEntity<Map<String, Object>> finTotal(@RequestBody ToDoVO todoVO, Authentication auth) {
	    Map<String, Object> response = new HashMap<>();
	        List<Map<String, Object>> finTotalTodo = todoService.finTotal(todoVO, auth);
	        System.out.println("=====================finTotalTodo================:"+finTotalTodo);
	        if (finTotalTodo != null && finTotalTodo.size() > 0) {
	            response.put("status", "success");
	            response.put("todoVO", finTotalTodo);
	            System.out.println("ddddddddddd");
	        } else {
	            response.put("status", "fail");
	            System.out.println("xxxxxxxxxxxxxxxxxxxxx");
	        }

	    return ResponseEntity.ok(response);
	}
	
	// 투두 리스트 신규 등록
	@PostMapping("/insertTodo")
	public ResponseEntity<Map<String,Object>> insertTodo(@RequestBody ToDoVO todoVO, Authentication auth) {
		

		Map<String,Object> response = new HashMap<>();
		ServiceResult res = todoService.insertTodo(todoVO); 
		if(res == ServiceResult.OK) {
			if(todoVO.getTdType().equals("day")) {
				List<ToDoVO> todo = todoService.dayTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else if(todoVO.getTdType().equals("week")){
				List<ToDoVO> todo = todoService.weekTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else if(todoVO.getTdType().equals("month")) {
				List<ToDoVO> todo = todoService.monthTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} 
		} else {
			response.put("status", "fail");
		}
				
		return ResponseEntity.ok(response);	
		
		
	}
	@PostMapping("/insertTodo1")
	public ResponseEntity<Map<String,Object>> insertTodo1(@RequestBody ToDoVO todoVO, Authentication auth) {
		
		
		Map<String,Object> res = new HashMap<>();
		res = todoService.insertTodo1(todoVO,auth);
		return ResponseEntity.ok(res);	
		
		
	}
	
	// 투두리스트 수정
	@PostMapping("/updateTodo")
	public ResponseEntity<Map<String,Object>> updateTodo( @RequestBody ToDoVO todoVO,Authentication auth){
		Map<String, Object> response = new HashMap<>();
		System.out.println("todoVO==============:"+todoVO);
		ServiceResult res = todoService.updateTodo(todoVO);
		System.out.println("todoVO==============:"+todoVO);
		if(res == ServiceResult.OK) {
			if(todoVO.getTdType().equals("day")) {
				List<ToDoVO> todo = todoService.dayTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else if(todoVO.getTdType().equals("week")){
				List<ToDoVO> todo = todoService.weekTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else  {
				List<ToDoVO> todo = todoService.monthTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} 
		} else {
			response.put("status", "fail");
		}
				
		return ResponseEntity.ok(response);	
	}
	
	// 체크 시 완료를 나타내는 컨트롤러
	@PostMapping("/finTodo")
	public ResponseEntity<Map<String,Object>> finTodo( @RequestBody ToDoVO todoVO,Authentication auth){
		Map<String, Object> response = new HashMap<>();
		System.out.println("todoVO==============:"+todoVO);
		ServiceResult res = todoService.finTodo(todoVO);
		System.out.println("todoVO==============:"+todoVO);
		if(res.equals(ServiceResult.OK)) {
			response.put("status", "success");
		} else {
			response.put("status", "failed");
		}
		
		return ResponseEntity.ok(response);	
		
		
		
	}
	
	// 투두 삭제
	// 단일 객체 ajax를 받아올때는 Map을 사용하여 키 벨류 형태로 받는다. 
	//	public  ResponseEntity<Map<String,Object>> delTodo(@RequestBody Map<String,Integer> tdMap, Authentication auth) {
	@PostMapping("/delTodo")
	public  ResponseEntity<Map<String, Object>> delTodo(@RequestBody ToDoVO todoVO, Authentication auth) {
		Map<String, Object> response = new HashMap<>();
		ServiceResult res = todoService.delTodo(todoVO.getTdNo());
		if(res == ServiceResult.OK) {
			if(todoVO.getTdType().equals("day")) {
				List<ToDoVO> todo = todoService.dayTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else if(todoVO.getTdType().equals("week")){
				List<ToDoVO> todo = todoService.weekTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} else  {
				List<ToDoVO> todo = todoService.monthTodo(auth);
				response.put("status", "success");
				response.put("todo", todo);
			} 
		} else {
			response.put("status", "fail");
		}
				
		return ResponseEntity.ok(response);	
		
		
	}
	
	
	// 모든 리스트 
	@GetMapping("/allTodo")
	public String allList(Authentication auth, Model model) {
		
		List<ToDoVO> todoVO = todoService.allList(auth);
			model.addAttribute("todoVO",todoVO);
		return "todo/allList";
		
	}
	
	// 모델 ajax 값
	@PostMapping("/modalList")
	public ResponseEntity<Map<String,Object>>  modalList(Authentication auth, @RequestBody ToDoVO todoVO) {
		Map<String, Object> response = new HashMap<>();
		 System.out.println("111111111111111111"+todoVO);
		 
		if(todoVO.getTdType().equals("day")) {
			List<ToDoVO> todo = todoService.dayModal(todoVO, auth);
				if(todo.size() > 0) {
					response.put("status", "success");
					response.put("todo", todo);
				} else {
					response.put("status", "fail");
				}
		} else if(todoVO.getTdType().equals("week")){
			List<ToDoVO> todo = todoService.weekModal(todoVO, auth);
			if(todo.size() > 0) {
				response.put("status", "success");
				response.put("todo", todo);
			} else {
				response.put("status", "fail");
			}
		} else{
			List<ToDoVO> todo = todoService.monthModal(todoVO, auth);
			if(todo.size() > 0) {
				response.put("status", "success");
				response.put("todo", todo);
			} else {
				response.put("status", "fail");
			}
			
		}
		System.out.println("222222222"+response);
		return ResponseEntity.ok(response);	
	}
	
	
	// 오늘의 투두 (메인)
	@GetMapping("/list")
	public String list(Authentication auth, Model model) {
		
		List<ToDoVO> todoVO = todoService.mainTodo(auth);
		
		model.addAttribute("todoVO",todoVO);
		
		return "todo/todohome";
	}
	
	// 오늘의 투두 사이드바
	@GetMapping("/dayTodo")
	public String dayTodo(Authentication auth, Model model) {
		
		List<ToDoVO> todoVO = todoService.dayTodo(auth);
		model.addAttribute("todoVO",todoVO);
		return "todo/dayTodo";
	}
	
	// 주간 투두 사이드바
	@GetMapping("/weekTodo")
	public String weekTodo(Authentication auth, Model model ) {
		
		List<ToDoVO> todoVO = todoService.weekTodo(auth);
		model.addAttribute("todoVO",todoVO);
		return "todo/weekTodo";
	}
	
	// 월간 투두 사이드바
	@GetMapping("/monthTodo")
	public String monthTodo(Authentication auth, Model model) {
		
		List<ToDoVO> todoVO = todoService.monthTodo(auth);
		model.addAttribute("todoVO",todoVO);
		return "todo/monthTodo";
	}
	
	
}
