package kr.or.ddit.common.chat.service;

import java.util.Map;

public interface IOpenGraphService {

	public Map<String, String> fetchOpenGraphData(String url);

}
