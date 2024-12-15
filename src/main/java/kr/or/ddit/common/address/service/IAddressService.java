package kr.or.ddit.common.address.service;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.address.vo.AddressDTO;
import kr.or.ddit.common.address.vo.AddressVO;
import kr.or.ddit.common.address.vo.ContactVO;

public interface IAddressService {

	public List<AddressVO> getAddress(int memNo);

	public List<MemberVO> allAddressList(MemberVO member);

	public List<MemberVO> myGroupAddressList(MemberVO member);

	public List<DepartmentVO> deptList();

	public String addModalAddress(AddressVO address);

	public void delContact(AddressVO address);

	public String delModalAddress(AddressVO address);

	public String modifyModalAddress(AddressVO address);

	public void moveAddress(List<MemberVO> checkedData, int abNo);

	public List<ContactVO> importAddress(ContactVO contact);

	public List<AddressVO> addContact(String memNo);
	
	public void addExContact(ContactVO contact);

	public void deleteChecked(List<ContactVO> contact);

	public List<AddressDTO> getAbNo(int memNo);

	public List<MemberVO> groupAddressList(MemberVO member);

	public void delFavorit(List<ContactVO> contact);

	public ContactVO getContactByAbNo(ContactVO contactVO);

//	public List<ContactVO> importAbNo(int abNo);


}
