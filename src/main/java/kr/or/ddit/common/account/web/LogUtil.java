package kr.or.ddit.common.account.web;

import javax.servlet.http.HttpServletRequest;

public class LogUtil {
    public static String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }

        return ip;
    }
	
	public String getOperatingSystem(String userAgent) {
	    if (userAgent == null) {
	        return "Unknown OS";
	    }

	    if (userAgent.contains("Windows")) {
	        return "Windows";
	    } else if (userAgent.contains("Mac OS X")) {
	        return "Mac OS";
	    } else if (userAgent.contains("Linux")) {
	        return "Linux";
	    } else if (userAgent.contains("Android")) {
	        return "Android";
	    } else if (userAgent.contains("iOS") || userAgent.contains("iPhone") || userAgent.contains("iPad")) {
	        return "iOS";
	    }

	    return "Unknown OS";
	}
	
	public String getBrowser(String userAgent) {
	    if (userAgent == null) {
	        return "Unknown Browser";
	    }

	    if (userAgent.contains("Chrome")) {
	        return "Chrome";
	    } else if (userAgent.contains("Firefox")) {
	        return "Firefox";
	    } else if (userAgent.contains("Safari") && !userAgent.contains("Chrome")) {
	        return "Safari";
	    } else if (userAgent.contains("Edge")) {
	        return "Edge";
	    } else if (userAgent.contains("Opera") || userAgent.contains("OPR")) {
	        return "Opera";
	    } else if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
	        return "Internet Explorer";
	    }

	    return "Unknown Browser";
	}
}
