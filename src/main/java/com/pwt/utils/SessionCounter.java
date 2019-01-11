package com.pwt.utils;

import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Date;

/**
 * count 当前在线用户数
 * all 总访问量
 * today 今日访问量
 * day 今日日期
 */
@Component
public class SessionCounter implements HttpSessionListener {

    private static Integer count = 0;
    private static long today = 0;
    private static long all = 0;
    private static int day = 0;

    //session创建
    @Override
    public void sessionCreated(HttpSessionEvent arg0) {
        ServletContext context = arg0.getSession().getServletContext();
        count = (Integer) context.getAttribute("onlineCount");
        if (count == null) {
            count = new Integer(1);
        } else {
            int co = count.intValue();
            count = new Integer(co + 1);
        }
        // 保存人数
        context.setAttribute("onlineCount", count);
        all++;
        Date date=new Date();
        int tday=date.getDate();
        //如果日期发生变化则将today置为1，否则将today加1
        if(tday!=day){
            day=tday;
            today=1;
        }else{
            today++;
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent arg0) {
        ServletContext context = arg0.getSession().getServletContext();
        count = (Integer) context.getAttribute("onlineCount");
        int co = count.intValue();
        count = new Integer(co - 1);
        count = count >= 0 ? count : 0;
        context.setAttribute("onlineCount", count);
    }

    public static Integer getCount() {
        return count;
    }

    public long getAll(){
        return all;
    }

    public long getToday(){
        return today;
    }
}