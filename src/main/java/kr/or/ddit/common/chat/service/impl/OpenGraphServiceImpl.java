package kr.or.ddit.common.chat.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.chat.service.IOpenGraphService;

@Service
public class OpenGraphServiceImpl implements IOpenGraphService {

	@Override
	public Map<String, String> fetchOpenGraphData(String url) {
	    Map<String, String> ogData = new HashMap<>();

	    try {
	        Document document = Jsoup.connect(url).get();
	        Element title = document.select("meta[property=og:title]").first();
	        Element description = document.select("meta[property=og:description]").first();
	        Element image = document.select("meta[property=og:image]").first();
	        Element urlElement = document.select("meta[property=og:url]").first();

	        ogData.put("title", title != null ? title.attr("content") : "");
	        ogData.put("description", description != null ? description.attr("content") : "");
	        ogData.put("image", image != null ? image.attr("content") : "");
	        ogData.put("url", urlElement != null ? urlElement.attr("content") : "");
	        
	        System.out.println("Fetched Title: " + (title != null ? title.attr("content") : "null"));
	        System.out.println("Fetched Description: " + (description != null ? description.attr("content") : "null"));
	        System.out.println("Fetched Image: " + (image != null ? image.attr("content") : "null"));
	        System.out.println("Fetched URL: " + (urlElement != null ? urlElement.attr("content") : "null"));
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return ogData;
	}

}
