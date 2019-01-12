package com.pwt.dao;

import com.pwt.model.vo.VisitTotalVo;
import com.pwt.model.vo.VisitTotalVoExample;

import java.sql.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface VisitTotalMapper {
    int countByExample(VisitTotalVoExample example);

    int deleteByExample(VisitTotalVoExample example);

    int deleteByPrimaryKey(Integer visitId);

    int insert(VisitTotalVo record);

    int insertSelective(VisitTotalVo record);

    List<VisitTotalVo> selectByExample(VisitTotalVoExample example);

    VisitTotalVo selectByPrimaryKey(Integer visitId);

    int updateByExampleSelective(@Param("record") VisitTotalVo record, @Param("example") VisitTotalVoExample example);

    int updateByExample(@Param("record") VisitTotalVo record, @Param("example") VisitTotalVoExample example);

    int updateByPrimaryKeySelective(VisitTotalVo record);

    int updateByPrimaryKey(VisitTotalVo record);

    int updateByVisitDateSelective(VisitTotalVo record);

    int updateByVisitDate(VisitTotalVo record);

    Integer selectByVisitDate(Date date);

    Integer selectSumByVisitCount();

    int insertOrUpdate(VisitTotalVo record);

}