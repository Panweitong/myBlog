package com.pwt.service.impl;

import com.pwt.dao.FontUserVoMapper;
import com.pwt.exception.TipException;
import com.pwt.model.Vo.FontUserVo;
import com.pwt.model.Vo.FontUserVoExample;
import com.pwt.service.IFontUserService;
import com.pwt.utils.TaleUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by pwt on 2017/3/3.
 */
@Service("fontUserService")
public class FontUserServiceImpl implements IFontUserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(FontUserServiceImpl.class);

    @Autowired
    private FontUserVoMapper userDao;

    @Override
    public Integer insertUser(FontUserVo userVo){
        Integer uid = 0;
        if (StringUtils.isNotBlank(userVo.getUsername()) && StringUtils.isNotBlank(userVo.getEmail())) {
//            用户密码加密
             String encodePwd = TaleUtils.MD5encode(userVo.getPassword());
             userVo.setPassword(encodePwd);
             try{
                 userDao.insertSelective(userVo);
                 uid = userVo.getUid();
             }catch (DuplicateKeyException e){

             }
        }
        return uid;
    }

    @Override
    public FontUserVo queryUserById(Integer uid) {
        FontUserVo userVo = null;
        if (uid != null) {
            userVo = userDao.selectByPrimaryKey(uid);
        }
        return userVo;
    }

    @Override
    public FontUserVo login(String username, String password) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            throw new TipException("用户名和密码不能为空");
        }
        FontUserVoExample example = new FontUserVoExample();
        FontUserVoExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count = userDao.countByExample(example);
        if (count < 1) {
            throw new TipException("不存在该用户");
        }
        String pwd = TaleUtils.MD5encode(password);
        criteria.andPasswordEqualTo(pwd);
        List<FontUserVo> userVos = userDao.selectByExample(example);
        if (userVos.size()!=1) {
            throw new TipException("用户名或密码错误");
        }
        return userVos.get(0);
    }

    @Override
    public Integer updateByUid(FontUserVo userVo) {
        int i = 0;
        if (null == userVo || null == userVo.getUid()) {
            throw new TipException("userVo is null");
        }
        try{
            i = userDao.updateByPrimaryKeySelective(userVo);
        }catch (DuplicateKeyException e){

        }
        return i;
    }

    @Override
    public Integer updateByName(FontUserVo fontUserVo) {
        int i = 0;
        if (null == fontUserVo || null == fontUserVo.getEmail()) {
            throw new TipException("userVo is null");
        }
        try{
            i = userDao.updateByNameSelective(fontUserVo);
        }catch (DuplicateKeyException e){

        }
        return i;
    }

    @Override
    public FontUserVo findUserByName(String username) {
        FontUserVo userVo = null;
        if (username != null) {
            userVo = userDao.selectByName(username);
        }
        return userVo;
    }

    @Override
    public FontUserVo findUserByEmail(String email) {
        FontUserVo userVo = null;
        if (email != null) {
            userVo = userDao.selectByEmail(email);
        }
        return userVo;
    }
}
