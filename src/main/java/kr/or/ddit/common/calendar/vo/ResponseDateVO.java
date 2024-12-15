package kr.or.ddit.common.calendar.vo;

import java.util.List;

import lombok.Data;

@Data
public class ResponseDateVO {

	private List<ScheduleVO> events; // 개인 스케줄 리스트
    private List<ScheduleVO> vacationSchedules; // 휴가 스케줄 리스트
    
}
