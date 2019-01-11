package com.pwt.controller;

import com.pwt.constant.WebConst;
import com.pwt.model.vo.FontUserVo;
import com.pwt.model.vo.OptionVo;
import com.pwt.model.vo.UserVo;
import com.pwt.service.IOptionService;
import com.pwt.utils.MapCache;
import com.pwt.utils.TaleUtils;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pwt on 2017/2/21.
 */
public class BaseController {

    protected MapCache cache = MapCache.single();

    public static String THEME = "themes/default";

    public static String MOBILE_THEME = "mobile/default";

    @Autowired
    private IOptionService optionService;

    /**
     * PC 端的页面主题
     * @param viewName
     * @return
     */
    public static String render(String viewName) {
        return THEME + "/" + viewName;
    }

    /**
     * 移动端的页面主题
     * @param viewName
     * @return
     */
    public static String mobileRender(String viewName) {
        return MOBILE_THEME + "/" + viewName;
    }

    public BaseController title(HttpServletRequest request, String title) {
        request.setAttribute("title", title);
        return this;
    }

    public BaseController keywords(HttpServletRequest request, String keywords) {
        request.setAttribute("keywords", keywords);
        return this;
    }

    public BaseController commons(HttpServletRequest request) {
        List<OptionVo> voList = optionService.getOptions();
        Map<String, String> options = new HashMap<>();
        voList.forEach((option) -> {
            options.put(option.getName(), option.getValue());
        });
        WebConst.initConfig = options;
        return this;
    }

    /**
     * 获取请求绑定的登录对象
     * @param request
     * @return
     */
    public UserVo user(HttpServletRequest request) {
        return TaleUtils.getLoginUser(request);
    }

    /**
     * 获取前台请求绑定的登录对象
     * @param request
     * @return
     */
    public FontUserVo fontUser(HttpServletRequest request) {
        return TaleUtils.getLoginFontUser(request);
    }

    public Integer getUid(HttpServletRequest request){
        return this.user(request).getUid();
    }

    public static String renderTo404() {
        return "comm/error_404";
    }


}
