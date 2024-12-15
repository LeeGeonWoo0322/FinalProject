package kr.or.ddit.common.alarm.mapper;

import java.util.List;

import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;

public interface IAlarmMapper {

	public void insertAlarm(AlarmVO alarm);

	public int chkBanAlarm(AlarmBanVO alarmBanVO);

	public AlarmVO getAlarm(int alarmNo);

	public int getUnreadAlarmCount(int receiverNo);

	public List<AlarmVO> notificationList(int receiverNo);

	public int readNotification(AlarmVO alarmVO);

	public int markAllAsRead(int memNo);

	public int deleteNotification(int alarmNo);

}
