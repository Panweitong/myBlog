package com.pwt.service.impl;

import com.pwt.dao.UserVoMapper;
import com.pwt.exception.TipException;
import com.pwt.model.vo.UserVo;
import com.pwt.model.vo.UserVoExample;
import com.pwt.service.IUserService;
import com.pwt.utils.TaleUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import java.util.List;

/**
 * Created by pwt on 2017/3/3.
 */
@Service("userService")
public class UserServiceImpl implements IUserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserVoMapper userDao;

    @Override
    public Integer insertUser(UserVo userVo) {
        Integer uid = null;
        if (StringUtils.isNotBlank(userVo.getUsername()) && StringUtils.isNotBlank(userVo.getEmail())) {
//            用户密码加密
             String encodePwd = TaleUtils.md5Encode(userVo.getUsername() + userVo.getPassword());
             userVo.setPassword(encodePwd);
             userDao.insertSelective(userVo);
        }
        return userVo.getUid();
    }

    @Override
    public UserVo queryUserById(Integer uid) {
        UserVo userVo = null;
        if (uid != null) {
            userVo = userDao.selectByPrimaryKey(uid);
        }
        return userVo;
    }

    @Override
    public UserVo login(String username, String password) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            throw new TipException("用户名和密码不能为空");
        }
        UserVoExample example = new UserVoExample();
        UserVoExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count = userDao.countByExample(example);
        if (count < 1) {
            throw new TipException("不存在该用户");
        }
        String pwd = TaleUtils.md5Encode(username+password);
        criteria.andPasswordEqualTo(pwd);
        List<UserVo> userVos = userDao.selectByExample(example);
        if (userVos.size()!=1) {
            throw new TipException("用户名或密码错误");
        }
        return userVos.get(0);
    }

    @Override
    public void updateByUid(UserVo userVo) {
        if (null == userVo || null == userVo.getUid()) {
            throw new TipException("userVo is null");
        }
        int i = userDao.updateByPrimaryKeySelective(userVo);
        if(i!=1){
            throw new TipException("update user by uid and return is not one");
        }
    }
}
