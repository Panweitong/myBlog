package com.pwt.dao;
import com.pwt.model.Vo.FontUserVo;
import com.pwt.model.Vo.FontUserVoExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FontUserVoMapper {
    long countByExample(FontUserVoExample example);

    int deleteByExample(FontUserVoExample example);

    int deleteByPrimaryKey(Integer uid);

    int insert(FontUserVo record);

    int insertSelective(FontUserVo record);

    List<FontUserVo> selectByExample(FontUserVoExample example);

    FontUserVo selectByPrimaryKey(Integer uid);

    int updateByExampleSelective(@Param("record") FontUserVo record, @Param("example") FontUserVoExample example);

    int updateByExample(@Param("record") FontUserVo record, @Param("example") FontUserVoExample example);

    int updateByPrimaryKeySelective(FontUserVo record);

    int updateByPrimaryKey(FontUserVo record);

    FontUserVo selectByEmail(String email);

    FontUserVo selectByName(String name);

    int updateByNameSelective(FontUserVo record);

    int updateByName(FontUserVo fontUserVo);
}