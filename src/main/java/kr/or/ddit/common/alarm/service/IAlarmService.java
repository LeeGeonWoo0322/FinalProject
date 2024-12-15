package kr.or.ddit.common.alarm.service;

import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;

public interface IAlarmService {

	public AlarmVO insertAlarm(AlarmVO alarm);

	public void registerEmitter(int memNo, SseEmitter emitter);

	void sendNotificationToUsers(List<AlarmVO> alarmList);

	public int chkBanAlarm(AlarmBanVO alarmBanVO);

	public int getUnreadAlarmCount(int receiverNo);

	public List<AlarmVO> notificationList(int receiverNo);

	public AlarmVO getAlarm(int alarmNo);

	public int readNotification(AlarmVO alarmVO);

	public int markAllAsRead(int memNo);

	public int deleteNotification(int alarmNo);

}
