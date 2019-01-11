package com.pwt.controller.admin;

import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.exception.TipException;
import com.pwt.model.bo.RestResponseBo;
import com.pwt.model.bo.StatisticsBo;
import com.pwt.model.vo.CommentVo;
import com.pwt.model.vo.ContentVo;
import com.pwt.model.vo.LogVo;
import com.pwt.model.vo.UserVo;
import com.pwt.service.ILogService;
import com.pwt.service.ISiteService;
import com.pwt.service.IUserService;
import com.pwt.utils.GsonUtils;
import com.pwt.utils.TaleUtils;
import com.wordnik.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 后台管理首页
 * Created by pwt on 2017/3/9 009.
 */
@Controller("adminIndexController")
@RequestMapping("/admin")
@Transactional(rollbackFor = TipException.class)
public class IndexController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private ISiteService siteService;

    @Autowired
    private ILogService logService;

    @Autowired
    private IUserService userService;

    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value ={"", "index"},method = RequestMethod.GET)
    @ApiOperation(value = "管理后台首页跳转", notes = "管理后台首页跳转", httpMethod = "GET")
    public String index(HttpServletRequest request){
        LOGGER.info("Enter admin index method");
        List<ContentVo> contents = siteService.recentContents(5);
        List<CommentVo> comments = siteService.recentComments(5);
        StatisticsBo statistics = siteService.getStatistics();
        // 取最新的20条日志
        List<LogVo> logs = logService.getLogs(1, 5);

        request.setAttribute("comments", comments);
        request.setAttribute("articles", contents);
        request.setAttribute("statistics", statistics);
        request.setAttribute("logs", logs);
        LOGGER.info("Exit admin index method");
        return "admin/index";
    }

    /**
     * 个人设置页面
     */
    @RequestMapping(value = "profile",method = RequestMethod.GET)
    @ApiOperation(value = "个人设置页面跳转", notes = "个人设置页面跳转", httpMethod = "GET")
    public String profile() {
        return "admin/profile";
    }


    /**
     * 修改个人信息
     */
    @RequestMapping(value = "/profile",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "修改个人信息", notes = "修改个人信息", httpMethod = "PUT")
    public RestResponseBo saveProfile(@RequestParam String screenName, @RequestParam String email, HttpServletRequest request, HttpSession session) {

        UserVo users = this.user(request);
        if (StringUtils.isNotBlank(screenName) && StringUtils.isNotBlank(email)) {
            UserVo temp = new UserVo();
            temp.setUid(users.getUid());
            temp.setScreenName(screenName);
            temp.setEmail(email);
            userService.updateByUid(temp);
            logService.insertLog(LogActions.UP_INFO.getAction(), GsonUtils.toJsonString(temp), request.getRemoteAddr(), this.getUid(request));

            //更新session中的数据
            UserVo original = (UserVo) session.getAttribute(WebConst.LOGIN_SESSION_KEY);
            original.setScreenName(screenName);
            original.setEmail(email);
            session.setAttribute(WebConst.LOGIN_SESSION_KEY, original);
        }
        return RestResponseBo.ok();
    }

    /**
     * 修改密码
     */
    @RequestMapping(value = "/password",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "修改密码", notes = "修改密码", httpMethod = "PUT")
    public RestResponseBo upPwd(@RequestParam String oldPassword, @RequestParam String password, HttpServletRequest request, HttpSession session) {
        UserVo users = this.user(request);
        if (StringUtils.isBlank(oldPassword) || StringUtils.isBlank(password)) {
            return RestResponseBo.fail("请确认信息输入完整");
        }

        if (!users.getPassword().equals(TaleUtils.md5Encode(users.getUsername() + oldPassword))) {
            return RestResponseBo.fail("旧密码错误");
        }
        if (password.length() < 6 || password.length() > 14) {
            return RestResponseBo.fail("请输入6-14位密码");
        }

        try {
            UserVo temp = new UserVo();
            temp.setUid(users.getUid());
            String pwd = TaleUtils.md5Encode(users.getUsername() + password);
            temp.setPassword(pwd);
            userService.updateByUid(temp);
            logService.insertLog(LogActions.UP_PWD.getAction(), null, request.getRemoteAddr(), this.getUid(request));

            //更新session中的数据
            UserVo original= (UserVo)session.getAttribute(WebConst.LOGIN_SESSION_KEY);
            original.setPassword(pwd);
            session.setAttribute(WebConst.LOGIN_SESSION_KEY,original);
            return RestResponseBo.ok();
        } catch (Exception e){
            String msg = "密码修改失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
    }
}
