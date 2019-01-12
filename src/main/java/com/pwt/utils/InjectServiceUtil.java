package com.pwt.utils;

import com.pwt.service.IVisitTotalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;


@Component
public class InjectServiceUtil {

    @Autowired
    private IVisitTotalService iVisitTotalService;

    @PostConstruct
    public void init(){
        InjectServiceUtil.getInstance().iVisitTotalService = this.iVisitTotalService;
    }

    /**
     *  实现单例 start
     */
    private static class SingletonHolder {
        private static final InjectServiceUtil INSTANCE = new InjectServiceUtil();
    }
    private InjectServiceUtil (){}
    public static final InjectServiceUtil getInstance() {
        return SingletonHolder.INSTANCE;
    }
    /**
     *  实现单例 end
     */
    public static IVisitTotalService getIVisitTotalService(){
        return InjectServiceUtil.getInstance().iVisitTotalService;
    }
}
