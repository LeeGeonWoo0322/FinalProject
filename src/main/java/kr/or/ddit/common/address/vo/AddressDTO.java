package kr.or.ddit.common.address.vo;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import lombok.Data;

@Data
public class AddressDTO {
	private int abNo;
	private int conNo;
	private int memNo;
    private List<MemberVO> checkedData;
    private List<MemberVO> favorites;
}
