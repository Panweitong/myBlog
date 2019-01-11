package com.pwt.controller.admin;

import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.exception.TipException;
import com.pwt.model.bo.RestResponseBo;
import com.pwt.model.vo.UserVo;
import com.pwt.service.ILogService;
import com.pwt.service.IUserService;
import com.pwt.utils.Commons;
import com.pwt.utils.TaleUtils;
import com.wordnik.swagger.annotations.ApiOperation;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户后台登录/登出
 * Created by pwt on 2017/3/11.
 */
@Controller
@RequestMapping("/admin")
@Transactional(rollbackFor = TipException.class)
public class AuthController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private IUserService usersService;

    @Autowired
    private ILogService logService;

    @RequestMapping(value = "/login",method =RequestMethod.GET)
    @ApiOperation(value = "登录界面跳转", notes = "登录界面跳转", httpMethod = "GET")
    public String login() {
        return "admin/login";
    }

    /**
     * 管理后台登录
     * @param username
     * @param password
     * @param remeberMe
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "管理后台登录", notes = "管理后台登录", httpMethod = "POST")
    public RestResponseBo doLogin(@RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam(required = false) String remeberMe,
                                  HttpServletRequest request,
                                  HttpServletResponse response) {

        Integer errorCount = cache.get("login_error_count");
        try {
            UserVo user = usersService.login(username, password);
            request.getSession().setAttribute(WebConst.LOGIN_SESSION_KEY, user);
            if (StringUtils.isNotBlank(remeberMe)) {
                TaleUtils.setCookie(response, user.getUid());
            }
            logService.insertLog(LogActions.LOGIN.getAction(), null, request.getRemoteAddr(), user.getUid());
        } catch (Exception e) {
            errorCount = null == errorCount ? 1 : errorCount + 1;
            int count = 3;
            if (errorCount > count) {
                return RestResponseBo.fail("您输入密码已经错误超过3次，请10分钟后尝试");
            }
            cache.set("login_error_count", errorCount, 10 * 60);
            String msg = "登录失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }

    /**
     * 注销
     * @param session
     * @param response
     */
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    @ApiOperation(value = "管理后台注销", notes = "管理后台注销", httpMethod = "GET")
    public void logout(HttpSession session, HttpServletResponse response) {
        session.removeAttribute(WebConst.LOGIN_SESSION_KEY);
        Cookie cookie = new Cookie(WebConst.USER_IN_COOKIE, "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        try {
            //response.sendRedirect(Commons.site_url());
            response.sendRedirect(Commons.siteLogin());
            System.out.println("index-----------logout");
        } catch (IOException e) {
            e.printStackTrace();
            LOGGER.error("注销失败", e);
        }
    }
}
