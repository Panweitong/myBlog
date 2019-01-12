package com.pwt.service.impl;

import com.pwt.dao.VisitTotalMapper;
import com.pwt.exception.TipException;
import com.pwt.model.vo.VisitTotalVo;
import com.pwt.service.IVisitTotalService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;

/**
 * visitTotal表的service
 * Created by pwt on 2017/3/7.
 */
@Service("visitTotalService")
public class VisitTotalServiceImpl implements IVisitTotalService {

    private static final Logger LOGGER = LoggerFactory.getLogger(VisitTotalServiceImpl.class);

    @Autowired
    private VisitTotalMapper visitTotalDao;

    @Override
    public Integer queryCountByVisitDate(Date date){
        return visitTotalDao.selectByVisitDate(new java.sql.Date(date.getTime()));
    }

    @Override
    public int querySumByVisitCount() {
        return visitTotalDao.selectSumByVisitCount();
    }

    @Override
    public void queryVisitTotalByVisitDate(VisitTotalVo visitTotalVo){
        if (null == visitTotalVo) {
            throw new TipException("visitTotalVo is null");
        }
        try {
            visitTotalDao.insertOrUpdate(visitTotalVo);
        }catch (Exception e){
             e.printStackTrace();
        }
    }

//    @Override
//    public void updateByVisitDate(VisitTotalVo visitTotalVo) {
//        if (null == visitTotalVo || null == visitTotalVo.getVisitId()) {
//            throw new TipException("visitTotalVo is null");
//        }
//        int i = visitTotalDao.updateByVisitDateSelective(visitTotalVo);
//        if(i!=1){
//            throw new TipException("update visitTotal by date and return is not one");
//        }
//    }

//    @Override
//    public int insertVisitTotal(VisitTotalVo visitTotalVo) {
//        return visitTotalDao.insertSelective(visitTotalVo);
//    }
}
