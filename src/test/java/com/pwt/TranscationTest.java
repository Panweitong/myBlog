package com.pwt;

import com.pwt.exception.TipException;
import com.pwt.model.vo.UserVo;
import com.pwt.service.IOptionService;
import com.pwt.service.IUserService;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.mybatis.spring.annotation.MapperScan;

import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * 测试数据库事务
 * Created by BlueT on 2017/3/8.
 */
@MapperScan("com.pwt.dao")
@RunWith(SpringJUnit4ClassRunner.class) //表示继承了SpringJUnit4ClassRunner类
@Transactional(rollbackFor = TipException.class)
public class TranscationTest {

    @Resource
    private IUserService userService;

    @Resource
    private IOptionService optionService;

    @org.junit.Test
    @Ignore
    public void test() {
        UserVo user = new UserVo();
        user.setUsername("wangqiang111");
        user.setPassword("123456");
        user.setEmail("8888");
        userService.insertUser(user);
        optionService.insertOption("site_keywords", "qwqwq");
    }
}
