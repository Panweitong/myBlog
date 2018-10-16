package com.pwt.interceptor;


import com.pwt.dto.Types;
import com.pwt.model.Vo.UserVo;
import com.pwt.service.IUserService;
import com.pwt.utils.*;
import com.pwt.constant.WebConst;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义拦截器
 *
 * @author pwt
 * @date 2017/3/9
 */
@Component
public class BaseInterceptor implements HandlerInterceptor {
    private static final Logger LOGGE = LoggerFactory.getLogger(BaseInterceptor.class);
    private static final String USER_AGENT = "user-agent";

    @Autowired
    private IUserService userService;

    private MapCache cache = MapCache.single();

    @Autowired
    private Commons commons;

    @Autowired
    private AdminCommons adminCommons;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        String uri = request.getRequestURI();

        LOGGE.info("UserAgent: {}", request.getHeader(USER_AGENT));
        LOGGE.info("用户访问地址: {}, 来路地址: {}", uri, IPKit.getIpAddrByRequest(request));


        //请求拦截处理
        UserVo user = TaleUtils.getLoginUser(request);

        if (null == user) {
            Integer uid = TaleUtils.getCookieUid(request);
            if (null != uid) {
                //这里还是有安全隐患,cookie是可以伪造的
                user = userService.queryUserById(uid);
                request.getSession().setAttribute(WebConst.LOGIN_SESSION_KEY, user);
            }
        }

        if (uri.startsWith("/myBlog/admin") && !uri.startsWith("/myBlog/admin/login") && user == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return false;
        }

        else if(uri.startsWith("/myBlog/api")&& user == null){
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return false;
        }

        //设置get请求的token
        if ("GET".equals(request.getMethod())) {
                String csrfToken = UUID.uu64();
                // 默认存储30分钟
                cache.hset(Types.CSRF_TOKEN.getType(), csrfToken, uri, 30 * 60);
                request.setAttribute("csrfToken", csrfToken);
        }
        return true;

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        httpServletRequest.setAttribute("commons", commons);
        //一些工具类和公共方法
        httpServletRequest.setAttribute("adminCommons", adminCommons);
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
