package kr.or.ddit.common.address.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.address.mapper.IAddressMapper;
import kr.or.ddit.common.address.service.IAddressService;
import kr.or.ddit.common.address.vo.AddressDTO;
import kr.or.ddit.common.address.vo.AddressVO;
import kr.or.ddit.common.address.vo.ContactVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AddressServiceImpl implements IAddressService{

	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	private IAddressMapper addressMapper;
	
	@Override
	public List<AddressVO> getAddress(int memNo) {
		return addressMapper.getAddress(memNo);
	}

	@Override
	public List<MemberVO> allAddressList(MemberVO member) {
		List<MemberVO> memList = addressMapper.allAddressList(member);
		log.info("## memList :" + memList);
		return memList;
	}

	@Override
	public List<MemberVO> myGroupAddressList(MemberVO member) {
		return addressMapper.myGroupAddressList(member);
	}

	@Override
	public List<DepartmentVO> deptList() {
		return addressMapper.deptList();
	}

	@Override
	public String addModalAddress(AddressVO address) {
		int result = addressMapper.addModalAddress(address);  // 삽입 작업의 결과값
	    return (result > 0) ? "SUCCESS" : "FAIL";
	}

	@Override
	public void delContact(AddressVO address) {
		addressMapper.delContact(address);
	}
	
	@Override
	public String delModalAddress(AddressVO address) {
		int result = addressMapper.delModalAddress(address);
		return (result > 0) ? "성공" : "실패";
	}

	@Override
	public String modifyModalAddress(AddressVO address) {
		int result = addressMapper.modifyModalAddress(address);
		return (result > 0) ? "성공" : "실패";
	}

	@Override
	public void moveAddress(List<MemberVO> checkedData, int abNo) {
			log.info("## abNo 값 들어오니?? "+ abNo);
			log.info("## checkedData 값 잘 들어오니?" + checkedData );
		
		List<Map<String, Object>> paramMaps = new ArrayList<Map<String,Object>>();
		for(MemberVO member : checkedData) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("abNo", abNo);
			paramMap.put("member", member);
			paramMaps.add(paramMap);
			log.info("## service쪽 값 : " + paramMaps);
			
		}
		log.info("# for문 밖 Maps : " + paramMaps);
		// 선택한 사원의 데이터를 contact에 넣는 방법
		// 첫번째 방법 - mapper를 반복적으로 처리하는 방법
		for(int i = 0; i < paramMaps.size(); i++) {
			addressMapper.moveAddress(paramMaps.get(i));
		}
		
		// 두번째 방법 - 리스트 데이터를 던져서 처리하는 방법
//		addressMapper.moveAddress2(paramMaps);
	}

	@Override
	public List<ContactVO> importAddress(ContactVO contact) {
		return addressMapper.importAddress(contact);
	}

	@Override
	public List<AddressVO> addContact(String memNo) {
		return addressMapper.addContact(memNo);
	}

	@Override
	public void addExContact(ContactVO contact) {
		MultipartFile file = contact.getConProfileImg();
		File fileRoot = new File(localPath+"/address");
		if (!fileRoot.exists()) {
			fileRoot.mkdirs();
		}
		
		String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		contact.setConProfile("/address/" + fileName);
		File targat = new File(fileRoot, fileName);
		try {
			FileCopyUtils.copy(file.getBytes(), targat);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		addressMapper.addExContact(contact);
	}

	@Override
	public void deleteChecked(List<ContactVO> contact) {
		addressMapper.deleteChecked(contact);
	}

	@Override
	public List<AddressDTO> getAbNo(int memNo) {
		return addressMapper.getAbNo(memNo);
	}

	@Override
	public List<MemberVO> groupAddressList(MemberVO member) {
		return addressMapper.groupAddressList(member);
	}

	@Override
	public void delFavorit(List<ContactVO> contact) {
		addressMapper.delFavorit(contact);
	}

	@Override
	public ContactVO getContactByAbNo(ContactVO contactVO) {
		return addressMapper.getContactByAbNo(contactVO);
	}

//	@Override
//	public List<ContactVO> importAbNo(int abNo) {
//		return addressMapper.importAbNo(abNo);
//	}

	


}
