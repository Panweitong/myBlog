package com.pwt.service;

import com.pwt.model.vo.VisitTotalVo;

import java.util.Date;

/**
 * @author pwt
 */
public interface IVisitTotalService {

    /**
     * 通过date查找对象
     * @param date  今日日期
     * @return 今日访问量
     */
    Integer queryCountByVisitDate(Date date);

    /**
     * 统计网站总访问量
     * @return 网站总访问量
     */
    int querySumByVisitCount();


    /**
     * 根据访问日期更新visitTotal对象
     * @param visitTotalVo 网站统计数据
     * @return
     */
//    void updateByVisitDate(VisitTotalVo visitTotalVo);


    /**
     * 保存网站统计数据
     *
     * @param visitTotalVo 网站统计数据
     * @return 主键
     */
//    int insertVisitTotal(VisitTotalVo visitTotalVo);


    /**
     * 通过date查看对象存不存在
     * @param visitTotalVo  对象
     * @return
     */
    void queryVisitTotalByVisitDate(VisitTotalVo visitTotalVo);

}
