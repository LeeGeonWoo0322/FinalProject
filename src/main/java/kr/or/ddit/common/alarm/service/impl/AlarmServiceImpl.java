package kr.or.ddit.common.alarm.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.alarm.mapper.IAlarmMapper;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements IAlarmService {
	
	@Inject
    private IAlarmMapper alarmMapper;
    
    private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>(); // 사용자별 SSE emitters

    @Override
    public AlarmVO insertAlarm(AlarmVO alarm) {
    	alarmMapper.insertAlarm(alarm);
    	int alarmNo=alarm.getAlarmNo();
    	alarm=getAlarm(alarmNo);
    	return alarm;
    }

    
    // 특정 memNo 사용자들에게만 알림을 전송
    @Override
    public void sendNotificationToUsers(List<AlarmVO> alarmList) {
        ObjectMapper objectMapper = new ObjectMapper(); // Jackson ObjectMapper 사용
        objectMapper.configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
        for (AlarmVO alarm : alarmList) {
            int memNo = alarm.getReceiverNo(); // 알림 수신자 번호
            SseEmitter emitter = emitters.get(memNo);
            if (emitter != null) { // 해당 유저의 Emitter가 등록되어 있는 경우만
                try {
                    // AlarmVO 객체를 JSON 문자열로 변환
                    String alarmJson = objectMapper.writeValueAsString(alarm);
                    System.out.println("알람 JSON, memNo " + memNo + ": " + alarmJson);

                    emitter.send(SseEmitter.event().data(alarmJson, MediaType.APPLICATION_JSON));
                } catch (IOException e) {
                    // 전송 실패 시 emitter를 제거
                    emitters.remove(memNo);
                }
            }
        }
    }


    public void registerEmitter(int memNo, SseEmitter emitter) {
        emitters.put(memNo, emitter);

        // 연결 종료 시 제거
        emitter.onCompletion(() -> emitters.remove(memNo));

        // 타임아웃 시 제거
        emitter.onTimeout(() -> emitters.remove(memNo));
    }

	@Override
	public int chkBanAlarm(AlarmBanVO alarmBanVO) {
		return alarmMapper.chkBanAlarm(alarmBanVO);
	}

	@Override
	public int getUnreadAlarmCount(int receiverNo) {
		return alarmMapper.getUnreadAlarmCount(receiverNo);
	}

	@Override
	public List<AlarmVO> notificationList(int receiverNo) {
		return alarmMapper.notificationList(receiverNo);
	}

	@Override
	public AlarmVO getAlarm(int alarmNo) {
		return alarmMapper.getAlarm(alarmNo);
	}

	@Override
	public int readNotification(AlarmVO alarmVO) {
		return alarmMapper.readNotification(alarmVO);
	}

	@Override
	public int markAllAsRead(int memNo) {
		return alarmMapper.markAllAsRead(memNo);
	}

	@Override
	public int deleteNotification(int alarmNo) {
		return alarmMapper.deleteNotification(alarmNo);
	}

}
