package com.pwt.utils;

import com.pwt.model.vo.VisitTotalVo;
import com.pwt.service.IVisitTotalService;
import org.springframework.stereotype.Component;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author pwt
 */
@Component
public class SessionCounter implements HttpSessionListener {

    private static IVisitTotalService iVisitTotalService;

    private static Map sessionMap = new HashMap();

    public SessionCounter() {}

    @Override
    public void sessionCreated(HttpSessionEvent arg0) {
        ServletContext context = arg0.getSession().getServletContext();
        Date date = new Date();
        boolean flag = true;
        for(Object key : sessionMap.keySet()){
            if(key.toString().equals(arg0.getSession().getId())){
                flag = false;
            }
        }
        if(flag){
            sessionMap.put(arg0.getSession().getId(), arg0.getSession());
        }

        context.setAttribute("onlineCount", sessionMap.size());
        VisitTotalVo visitTotalVo = new VisitTotalVo();
        iVisitTotalService = InjectServiceUtil.getIVisitTotalService();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        try {
            visitTotalVo.setVisitDate(new java.sql.Date(sdf.parse(sdf.format(date)).getTime()));
            iVisitTotalService.queryVisitTotalByVisitDate(visitTotalVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent arg0) {

        boolean flag = false;
        for(Object key : sessionMap.keySet()){
            if(key.toString().equals(arg0.getSession().getId())){
                flag = true;
            }
        }
        if(flag){
            sessionMap.remove(arg0.getSession().getId());
        }
        ServletContext context = arg0.getSession().getServletContext();
        context.setAttribute("onlineCount", sessionMap.size());
    }
}