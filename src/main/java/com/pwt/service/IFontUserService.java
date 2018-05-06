package com.pwt.service;


import com.pwt.model.Vo.FontUserVo;

/**
 * Created by pwt on 2017/3/3.
 */
public interface IFontUserService {

    /**
     * 保存用户数据
     *
     * @param fontUserVo 用户数据
     * @return 主键
     */

    Integer insertUser(FontUserVo fontUserVo);

    /**
     * 通过uid查找对象
     * @param uid
     * @return
     */
    FontUserVo queryUserById(Integer uid);

    /**
     * 用戶登录
     * @param username
     * @param password
     * @return
     */
    FontUserVo login(String username, String password);

    /**
     * 根据主键更新user对象
     * @param fontUserVo
     * @return
     */
    Integer updateByUid(FontUserVo fontUserVo);

    /**
     * 通过email查找对象
     * @param email
     * @return
     */
    FontUserVo findUserByEmail(String email);

    /**
     * 根据用户名更新user对象
     * @param fontUserVo
     * @return
     */
    Integer updateByName(FontUserVo fontUserVo);

    /**
     * 通过username查找对象
     * @param username
     * @return
     */
    FontUserVo findUserByName(String username);

}
