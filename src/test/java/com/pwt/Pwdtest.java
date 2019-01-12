package com.pwt;

import com.pwt.model.vo.UserVo;
import com.pwt.utils.TaleUtils;

/**
 * Created by shuaihan on 2017/4/2.
 */
public class Pwdtest {
    public static void main(String args[]){
        UserVo user = new UserVo();
        user.setUsername("admin");
        user.setPassword("asdfasdfs");
        String encodePwd = TaleUtils.md5Encode(user.getUsername() + user.getPassword());
        System.out.println(encodePwd);
    }
}
