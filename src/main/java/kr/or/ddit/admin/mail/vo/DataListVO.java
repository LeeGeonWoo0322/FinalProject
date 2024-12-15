package kr.or.ddit.admin.mail.vo;

import java.util.List;

import lombok.Data;

@Data
public class DataListVO {
	private String period;
	private String periodData1;
	private String periodData2;
	private String dataType;
	
	private List<String> periodData;
	
	public DataListVO() {
		
	}
	
	public DataListVO(String period, String dataType) {
		this.period = period;
		this.dataType = dataType;
	}
}
