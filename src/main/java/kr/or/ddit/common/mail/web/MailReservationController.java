package kr.or.ddit.common.mail.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MailReservationController {
  
  @Scheduled(cron = "0 0/10 * * * ?")
  public void sheduler() {
    Calendar calendar = Calendar.getInstance();
    Date date = calendar.getTime();
    String today = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    System.out.println("스케쥴러 작동 시간 : " + today);
  }

}