package com.pwt.controller.front;

import com.github.pagehelper.PageInfo;
import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.*;
import com.pwt.exception.TipException;
import com.pwt.model.Bo.ArchiveBo;
import com.pwt.model.Bo.CommentBo;
import com.pwt.model.Bo.RestResponseBo;
import com.pwt.model.Vo.*;
import com.pwt.service.*;
import com.pwt.utils.*;
import com.vdurmont.emoji.EmojiParser;
import com.wordnik.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.IllegalBlockSizeException;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 首页
 * Created by pwt on 2017/3/8 008.
 */
@Controller
@RequestMapping(value = "/")
public class FontIndexController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(FontIndexController.class);

    @Autowired
    private IContentService contentService;

    @Autowired
    private IMetaService metaService;

    @Autowired
    private ISiteService siteService;

    @Autowired
    private IAttachService attachService;

    @Autowired
    private IFontUserService fontUserService;

    public static String CLASSPATH = "";

    @Autowired
    private ICommentService commentService;



    /**
     * 首页
     *
     * @return
     */
    @RequestMapping(value = {"/", "index"}, method = RequestMethod.GET)
    @ApiOperation(value = "首页跳转", notes = "首页跳转", httpMethod = "GET")
    public String index(HttpServletRequest request, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        this.commons(request);
        return this.index(request, 1, limit);
    }

    /**
     * 首页分页
     *
     * @param request request
     * @param p       第几页
     * @param limit   每页大小
     * @return 主页
     */
    @RequestMapping(value = "page/{p}", method = RequestMethod.GET)
    @ApiOperation(value = "首页分页", notes = "首页分页", httpMethod = "GET")
    public String index(HttpServletRequest request, @PathVariable("p") int p, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        p = p < 0 || p > WebConst.MAX_PAGE ? 1 : p;
        PageInfo<ContentVo> articles = contentService.getContents(p, limit);
        request.setAttribute("articles", articles);
        if (p > 1) {
            this.title(request, "第" + p + "页");
        }
        return render("index");
    }


    /**
     * 友链页
     *
     * @return
     */
    @RequestMapping(value = "links",method = RequestMethod.GET)
    @ApiOperation(value = "友链页跳转", notes = "友链页跳转", httpMethod = "GET")
    public String links(HttpServletRequest request) {
        List<MetaVo> links = metaService.getMetas(Types.LINK.getType());
        request.setAttribute("links", links);
        return render("links");
    }


    /**
     * 归档页
     *
     * @return
     */
    @RequestMapping(value = "archives",method = RequestMethod.GET)
    @ApiOperation(value = "归档页跳转", notes = "归档页跳转", httpMethod = "GET")
    public String archives(HttpServletRequest request) {
        List<ArchiveBo> archives = siteService.getArchives();
        request.setAttribute("archives", archives);
        return render("archives");
    }


    /**
     * 标签页
     *
     * @param name
     * @return
     */
    @RequestMapping(value = "tag/{name}",method = RequestMethod.GET)
    @ApiOperation(value = "标签页跳转", notes = "标签页跳转", httpMethod = "GET")
    public String tags(HttpServletRequest request, @PathVariable("name") String name, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        return this.tags(request, name, 1, limit);
    }

    /**
     * 标签分页
     *
     * @param request
     * @param name
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "tag/{name}/{page}",method = RequestMethod.GET)
    @ApiOperation(value = "标签页分页", notes = "标签页分页", httpMethod = "GET")
    public String tags(HttpServletRequest request, @PathVariable("name") String name, @PathVariable("page") int page, @RequestParam(value = "limit", defaultValue = "12") int limit) {

        page = page < 0 || page > WebConst.MAX_PAGE ? 1 : page;
//        对于空格的特殊处理
        name = name.replaceAll("\\+", " ");
        MetaDto metaDto = metaService.getMeta(Types.TAG.getType(), name);
        if (null == metaDto) {
            return render_404();
        }

        PageInfo<ContentVo> contentsPaginator = contentService.getArticles(metaDto.getMid(), page, limit);
        request.setAttribute("articles", contentsPaginator);
        request.setAttribute("meta", metaDto);
        request.setAttribute("type", "标签");
        request.setAttribute("keyword", name);

        return render("page-category");
    }


    /**
     * 分类页
     *
     * @return
     */
    @RequestMapping(value = "category/{keyword}", method = RequestMethod.GET)
    @ApiOperation(value = "分类页跳转", notes = "分类页跳转", httpMethod = "GET")
    public String categories(HttpServletRequest request, @PathVariable("keyword") String keyword, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        return this.categories(request, keyword, 1, limit);
    }

    @RequestMapping(value = "category/{keyword}/{page}", method = RequestMethod.GET)
    @ApiOperation(value = "分类页分页", notes = "分类页分页", httpMethod = "GET")
    public String categories(HttpServletRequest request, @PathVariable("keyword") String keyword,
                             @PathVariable("page") int page, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        page = page < 0 || page > WebConst.MAX_PAGE ? 1 : page;
        MetaDto metaDto = metaService.getMeta(Types.CATEGORY.getType(), keyword);
        if (null == metaDto) {
            return render_404();
        }

        PageInfo<ContentVo> contentsPaginator = contentService.getArticles(metaDto.getMid(), page, limit);

        request.setAttribute("articles", contentsPaginator);
        request.setAttribute("meta", metaDto);
        request.setAttribute("type", "分类");
        request.setAttribute("keyword", keyword);

        return render("page-category");
    }

    /**
     * 注销
     *
     * @param session
     * @param response
     */
    @RequestMapping(value = "logout",method = RequestMethod.GET)
    @ApiOperation(value = "注销", notes = "注销", httpMethod = "GET")
    public void logout(HttpSession session, HttpServletResponse response) {
        TaleUtils.logout(session, response);
    }

    /**
     * 前台登录
     * 页面跳转
     */
    @RequestMapping(value = "login",method =RequestMethod.GET)
    @ApiOperation(value = "前台登录跳转", notes = "前台登录跳转", httpMethod = "GET")
    public String login(HttpServletRequest request) {
        int uid=0;
        try{
            uid=TaleUtils.getCookieUid(request);
            FontUserVo fontUserVo = fontUserService.queryUserById(uid);
            fontUserVo.setPassword("");
            Cookie[] cookie = request.getCookies();
            for (int i = 0; i < cookie.length; i++) {
                Cookie cook = cookie[i];
                if(cook.getName().equalsIgnoreCase("password")){
                    fontUserVo.setPassword(cook.getValue().toString());
                }
                else if(cook.getName().equalsIgnoreCase("remeber_me")){
                    request.setAttribute("remeber_me",cook.getValue().toString());
                }
            }
            request.setAttribute("fontUser",fontUserVo);
        }catch (NullPointerException e){

        }
        return "themes/default/login";
    }

    /**
     * 前台登录
     * @param username
     * @param password
     * @param remeber_me
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "前台登录", notes = "前台登录", httpMethod = "POST")
    public RestResponseBo doLogin(@RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam(required = false) String remeber_me,
                                  org.apache.catalina.servlet4preview.http.HttpServletRequest request,
                                  HttpServletResponse response) {

        Integer error_count = cache.get("login_error_count");
        try {
            try{
                password = AesUtil.aesDecrypt(password,"abcdefgabcdefg12");
            }catch(IllegalBlockSizeException e){

            }

            FontUserVo user = fontUserService.login(username, password);
            if (StringUtils.isNotBlank(remeber_me)) {
                TaleUtils.setCookie(response, user.getUid());
                cookie("password",password,5*365*24*60*60,response);
                cookie("remeber_me",remeber_me,5*365*24*60*60,response);
            }
            else{
                TaleUtils.setCookie(response, user.getUid());
                cookie("password",password,0,response);
                cookie("remeber_me",remeber_me,0,response);
            }
            request.getSession().setAttribute(WebConst.FONTLOGIN_SESSION_KEY, user);
//            logService.insertLog(LogActions.LOGIN.getAction(), null, request.getRemoteAddr(), user.getUid());
        } catch (Exception e) {
            error_count = null == error_count ? 1 : error_count + 1;
            String msg = "登录失败";
            if (error_count > 3) {
                return RestResponseBo.fail("您输入密码已经错误超过3次，请10分钟后尝试");
            }
            cache.set("login_error_count", error_count, 10 * 60);
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
     * 前台用户注册
     * 页面跳转
     */
    @RequestMapping(value = "register",method =RequestMethod.GET)
    @ApiOperation(value = "前台注册跳转", notes = "前台注册跳转", httpMethod = "GET")
    public String register() {
        return "themes/default/register";
    }

    /**
     * 前台用户注册
     * 表单提交
     */
    @RequestMapping(value = "register",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "前台注册", notes = "前台注册", httpMethod = "POST")
    public RestResponseBo register(HttpServletRequest request,UserRegisterForm form) {
        FontUserVo fontUserVo = new FontUserVo();
        if(form.getPassword().equals(form.getConfirmpassword())){
            fontUserVo.setUsername(form.getUsername());
            fontUserVo.setPassword(form.getPassword());
            fontUserVo.setEmail(form.getEmail());
            fontUserVo.setHeadPhoto("/static/user/img/logo.jpg");
            fontUserVo.setScreenName(form.getUsername());
            int time = DateKit.getCurrentUnixTime();
            fontUserVo.setCreated(time);
            int uid=fontUserService.insertUser(fontUserVo);
            if(uid!=0){
                this.fontUser(request);
                fontUserVo=fontUserService.login(form.getUsername(), form.getPassword());
                request.getSession().setAttribute(WebConst.FONTLOGIN_SESSION_KEY, fontUserVo);
//              logService.insertLog(LogActions.LOGIN.getAction(), null, request.getRemoteAddr(), fontUserVo.getUid());
                return RestResponseBo.ok();
            }
            else{
                String msg = "用户名或者邮箱已存在!";
                return RestResponseBo.fail(msg);
            }
        }
        else{
            String msg = "两次输入的密码不一致!";
            return RestResponseBo.fail(msg);
        }
    }

    /**
     * 查看个人资料
     * 页面跳转
     */
    @RequestMapping(value = "profile",method =RequestMethod.GET)
    @ApiOperation(value = "查看个人资料", notes = "查看个人资料", httpMethod = "GET")
    public String profile(HttpServletRequest request) {
        FontUserVo fontUserVo = this.fontUser(request);
        request.setAttribute("fontUser",fontUserVo);
        return "themes/default/profile";
    }

    /**
     * 修改个人资料
     * 更新资料提交
     */
    @RequestMapping(value = "profile",method =RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "修改个人资料", notes = "修改个人资料", httpMethod = "PUT")
    public RestResponseBo profile(@RequestParam String username,
                                  @RequestParam String email,
                                  @RequestParam String headPhoto,
                                  HttpServletRequest request) {
        FontUserVo userVo = new FontUserVo();
        userVo.setUid(((FontUserVo) request.getSession().getAttribute("login_fontUser")).getUid());
        userVo.setHeadPhoto(headPhoto);
        userVo.setUsername(username);
        userVo.setEmail(email);
        int i = fontUserService.updateByUid(userVo);
        if(i==1){
            ((FontUserVo)request.getSession().getAttribute("login_fontUser")).setHeadPhoto(headPhoto);
            ((FontUserVo)request.getSession().getAttribute("login_fontUser")).setUsername(username);
            ((FontUserVo)request.getSession().getAttribute("login_fontUser")).setEmail(email);
            return RestResponseBo.ok();
        }
        else{
            String msg = "用户名或者邮箱已经存在!";
            return RestResponseBo.fail(msg);
        }
    }

    /**
     * 修改密码
     * 修改密码提交
     */
    @RequestMapping(value = "changePass",method =RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "修改密码", notes = "修改密码", httpMethod = "PUT")
    public RestResponseBo changePass(@RequestParam String oldPassword,
                                     @RequestParam String newPassword,
                                     @RequestParam String confirmPassword,
                                     HttpServletRequest request,HttpServletResponse response){
        FontUserVo fontUserVo = fontUserService.queryUserById(((FontUserVo) request.getSession().getAttribute("login_fontUser")).getUid());
        String encodePwd = TaleUtils.MD5encode(oldPassword);
        if(encodePwd.equals(fontUserVo.getPassword())){
            if(newPassword.equals(confirmPassword)){
                FontUserVo userVo = new FontUserVo();
                userVo.setUid(((FontUserVo) request.getSession().getAttribute("login_fontUser")).getUid());
                userVo.setPassword(TaleUtils.MD5encode(newPassword));
                fontUserService.updateByUid(userVo);
                return RestResponseBo.ok();
            }
            else{
                String msg = "两次输入的新密码不一致!";
                return RestResponseBo.fail(msg);
            }
        }else{
            String msg = "输入的旧密码不正确!";
            return RestResponseBo.fail(msg);
        }
    }

    /**
     * 找回密码
     * 页面跳转
     */
    @RequestMapping(value = "forget",method =RequestMethod.GET)
    @ApiOperation(value = "找回密码", notes = "找回密码", httpMethod = "GET")
    public String forget(HttpServletRequest request){
        return "themes/default/forget_pwd";
    }

    /**
     * 忘记密码
     * 申请提交
     */
    @RequestMapping(value = "forget",method =RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "提交找回密码申请", notes = "提交找回密码申请", httpMethod = "POST")
    public RestResponseBo forgetPass(HttpServletRequest request, String email,String code){
        String msg="";
        if(code.equals(request.getSession().getAttribute("rand"))){
            FontUserVo users = fontUserService.findUserByEmail(email);
            if(users == null){              //用户名不存在
                msg = "邮箱不存在,你不会忘记邮箱了吧?";
                return RestResponseBo.fail(msg);
            }
            else{
                try{
                    String secretKey= java.util.UUID.randomUUID().toString();  //密钥
                    Timestamp outDate = new Timestamp(System.currentTimeMillis()+30*60*1000);//30分钟后过期
                    users.setSecretKey(secretKey);
                    users.setOutDate(outDate);
                    fontUserService.updateByName(users);    //保存到数据库
                    users = fontUserService.findUserByEmail(email);
                    String key = users.getUsername()+"$"+ users.getOutDate().getTime()/1000*1000 +"$"+secretKey;
                    String digitalSignature = TaleUtils.MD5encode(key);                 //数字签名
                    //邮箱配置
                    String serverHost = "smtp.qq.com";
                    String serverPort = "465";
                    Boolean isValidate = true;
                    String userName = "1025103647@qq.com";
                    String password = "fsuqcgiueuojbdjj";
                    String toMailAddress = email;
                    String emailTitle = "Blog密码找回";
                    String path = request.getContextPath();
                    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
                    String resetPassHref =  basePath+"findPass?sid="+digitalSignature+"&userName="+users.getUsername();
                    String emailContent = "请勿回复本邮件.点击下面的链接,重设密码<br/><a href="+resetPassHref +" target='_BLANK'>点击我重新设置密码</a>" +
                            "<br/>提示:本邮件超过30分钟,链接将会失效，需要重新申请找回密码";

                    MailUtil.setMail(serverHost, serverPort, isValidate, userName, password, toMailAddress, emailTitle, emailContent);
                    return RestResponseBo.ok();
                }catch (Exception e){
                    e.printStackTrace();
                    msg="系统错误，请稍后再试!";
                    return RestResponseBo.fail(msg);
                }
            }
        }
        else{
            msg="验证码错误，请重新提交";
            return RestResponseBo.fail(msg);
        }
    }

    /**
     *  生成验证码
     */
    @RequestMapping(value = "codeMaker",method =RequestMethod.GET)
    @ApiOperation(value = "生成验证码", notes = "生成验证码", httpMethod = "GET")
    public void codeMaker(HttpServletRequest request, HttpServletResponse response){
        System.out.println("生成验证码");
        // 清空缓冲区
        response.reset();

        // 注意这里的MIME类型
        response.setContentType("image/png");

        // 设置页面不缓存
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        // 创建一个图像,验证码显示的图片大小
        BufferedImage image = new BufferedImage(200, 42,BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文
        Graphics g = image.getGraphics();

        // 设置背景
        g.setColor(CodeMakerUtil.getRandColor(200,250));
        g.fillRect(0, 0, 200, 42);

        for (int i = 0; i < 4; i++)
        {
            CodeMakerUtil.drawCode(g, i);
        }
        //添加干扰线
        CodeMakerUtil.drawNoise(g, 12);

        // 绘制边框
        //g.setColor(Color.gray);
        //g.drawRect(0, 0, width - 1, height - 1);

        String codeNumbers = CodeMakerUtil.codeNumbers;

        // 将验证码内容保存进session中，用于验证用户输入是否正确时使用
        HttpSession session = request.getSession(true);
        session.removeAttribute("rand");
        session.setAttribute("rand", codeNumbers);
        // 重设字符串
        codeNumbers = "";
        CodeMakerUtil.codeNumbers = codeNumbers;
        // 利用ImageIO类的write方法对图像进行编码
        ServletOutputStream sos = null;
        try {
            sos = response.getOutputStream();
            ImageIO.write(image, "PNG", sos);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                sos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 该方法用于处理从邮箱链接过来的修改密码请求
     */
    @RequestMapping(value = "findPass",method =RequestMethod.GET)
    @ApiOperation(value = "处理从邮箱链接过来的修改密码请求", notes = "处理从邮箱链接过来的修改密码请求", httpMethod = "GET")
    public String toFindPassword3(HttpServletRequest request,String sid,String userName){
        String message="";
        if(StringUtils.isBlank(sid)||StringUtils.isBlank(userName)){
            System.out.println("请求的链接不正确,请重新操作.");
            message="请求的链接不正确,请重新操作.";
            request.setAttribute("message", message);
            return "themes/default/error";
        }
        else{
            FontUserVo stu=fontUserService.findUserByName(userName);
            if(stu!=null){
                //获取当前用户申请找回密码的过期时间
                //找回密码链接已经过期
                if((stu.getOutDate().getTime()/1000*1000)<=System.currentTimeMillis()){
                    System.out.println("链接已经过期");
                    message="链接已经过期";
                    request.setAttribute("message", message);
                    return "themes/default/error";
                }
                else{
                    //获取当前登陆人的加密码
                    String key = stu.getUsername()+"$"+stu.getOutDate().getTime()/1000*1000+"$"+stu.getSecretKey();//数字签名
                    String digitalSignature = TaleUtils.MD5encode(key); // 数字签名
                    if(!digitalSignature.equals(sid)){
                        System.out.println("链接加密密码不正确");
                        message="链接加密密码不正确";
                        request.setAttribute("message", message);
                        return "themes/default/error";
                    }else{
                        //验证成功,跳入到修改密码界面
                        request.setAttribute("user", stu);
                        return "themes/default/find_pwd";
                    }
                }
            }else{
                System.out.println("用户信息不存在");
                message="用户信息不存在";
                request.setAttribute("message", message);
                return "themes/default/error";
            }
        }
    }

    /**
     *  重置密码
     *  表单提交
     */
    @RequestMapping(value = "resetPwd",method = RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "重置密码", notes = "重置密码", httpMethod = "PUT")
    public  RestResponseBo  resetPassword(HttpServletRequest request,String username,String password,String confirmPassword){
        if(password.equals(confirmPassword)){
            FontUserVo userVo = fontUserService.findUserByName(username);
            password = TaleUtils.MD5encode(password);
            userVo.setPassword(password);
            int i = fontUserService.updateByName(userVo);
            if(i!=0){
                return RestResponseBo.ok();
            }
            else{
                String msg="重置密码失败!";
                return RestResponseBo.fail(msg);
            }
        }
        else{
            String msg="两次输入的密码不一致,请重新输入!";
            return RestResponseBo.fail(msg);
        }
    }


    /**
     * 文章页（预览）
     *
     * @param request 请求
     * @param cid     文章主键
     * @return
     */
    @RequestMapping(value = {"article/{cid}/preview", "article/{cid}"}, method = RequestMethod.GET)
    @ApiOperation(value = "查看文章页", notes = "查看文章页", httpMethod = "GET")
    public String articlePreview(HttpServletRequest request, @PathVariable("cid") String cid) {
        ContentVo contents = contentService.getContents(cid);
        if (null == contents) {
            return render_404();
        }
        request.setAttribute("article", contents);
        request.setAttribute("is_post", true);
        completeArticle(request, contents);
        updateArticleHit(contents.getCid(), contents.getHits());
        return BaseController.render("post");
    }

    /**
     * 自定义页面,如关于的页面
     */
    @RequestMapping(value = "/{pagename}",method = RequestMethod.GET)
    @ApiOperation(value = "查看自定义页面", notes = "查看自定义页面", httpMethod = "GET")
    public String page(@PathVariable("pagename") String pagename, HttpServletRequest request) {
        ContentVo contents = contentService.getContents(pagename);
        if (null == contents) {
            return render_404();
        }
        if (contents.getAllowComment()) {
            String cp = request.getParameter("cp");
            if (StringUtils.isBlank(cp)) {
                cp = "1";
            }
            PageInfo<CommentBo> commentsPaginator = commentService.getComments(contents.getCid(), Integer.parseInt(cp), 6);
            request.setAttribute("comments", commentsPaginator);
        }
        request.setAttribute("article", contents);
        updateArticleHit(contents.getCid(), contents.getHits());
        return render("page");
    }


    /**
     * 博客列表页
     * 1.博客列表（文章标题/内容简介/发布时间）
     * 2.标签（mid/文章总数）
     */
    @RequestMapping(value = "/post/{p}", method = RequestMethod.GET)
    @ApiOperation(value = "博客列表页分页", notes = "博客列表页分页", httpMethod = "GET")
    public String pPostList(HttpServletRequest request, @PathVariable("p") int p, @RequestParam(value = "limit", defaultValue = "12") int limit, Integer mid){
        p = p < 0 || p > WebConst.MAX_PAGE ? 1 : p;
        PageInfo<ContentVo> articles = null;
        if (null != mid) {
            articles =contentService.getArticles(mid , p, limit);
            request.setAttribute("id", mid);
        } else {
            articles = contentService.getContents(p, limit);
            request.setAttribute("id", "");
        }
        request.setAttribute("articles", articles);
        if (p > 1) {
            this.title(request, "第" + p + "页");
        }
        List<MetaDto> tag = metaService.getMetaList(Types.TAG.getType(),null,limit);
        request.setAttribute("tag", tag);
        return render("posts");
    }


    /**
     * 博客列表页
     * 1.博客列表（文章标题/内容简介/发布时间）
     * 2.标签（mid/文章总数）
     */
    @RequestMapping(value = "/post", method = RequestMethod.GET)
    @ApiOperation(value = "查看博客列表页", notes = "查看博客列表页", httpMethod = "GET")
    public String PostList(HttpServletRequest request, @RequestParam(value = "limit", defaultValue = "12") int limit,Integer mid){
        return this.pPostList(request,1,limit,mid);
    }

    /**
     * 文章搜索结果页
     * 1.博客列表（文章标题/内容简介/发布时间）
     */
    @RequestMapping(value = "/postsearch", method = RequestMethod.GET)
    @ApiOperation(value = "查看文章搜索结果页", notes = "查看文章搜索结果页", httpMethod = "GET")
    public String PostSearch(HttpServletRequest request,@RequestParam(value = "limit", defaultValue = "12") int limit,ArticleSearchForm form){
        return this.pPostSearch(request,1,limit,form);
    }

    /**
     * 文章搜索结果页
     * <p>
     * 根据指定条件查找文章
     * <p>
     * 视图模型：
     * 博客列表（文章标题/内容简介/发布时间）
     */
    @RequestMapping(value = "/postsearch/{p}", method = RequestMethod.GET)
    @ApiOperation(value = "文章搜索结果页分页", notes = "文章搜索结果页分页", httpMethod = "GET")
    public String pPostSearch(HttpServletRequest request, @PathVariable("p") int p, @RequestParam(value = "limit", defaultValue = "12") int limit,ArticleSearchForm form){
        p = p < 0 || p > WebConst.MAX_PAGE ? 1 : p;
        PageInfo<ContentVo> article = null;
        if (null != form) {
            article =contentService.getArticles(form , p, limit);
            request.setAttribute("name",form.getName());
        } else {
            article = contentService.getContents(p, limit);
            request.setAttribute("name","");
        }
        request.setAttribute("articles", article);
        List<MetaDto> tag = metaService.getMetaList(Types.TAG.getType(),null,limit);
        request.setAttribute("tag", tag);
        if (p > 1) {
            this.title(request, "第" + p + "页");
        }
        return render("postsearch");
    }

    /**
     * 评论操作
     */
    @RequestMapping(value = "comment", method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "评论操作", notes = "评论操作", httpMethod = "POST")
    public RestResponseBo comment(HttpServletRequest request, HttpServletResponse response,
                                  @RequestParam("cid") Integer cid, @RequestParam("coid") Integer coid,
                                  @RequestParam("author") String author, @RequestParam("mail") String mail,
                                  @RequestParam("url") String url, @RequestParam("text") String text, @RequestParam("_csrf_token") String _csrf_token) {

        String ref = request.getHeader("Referer");
        if (StringUtils.isBlank(ref) || StringUtils.isBlank(_csrf_token)) {
            return RestResponseBo.fail(ErrorCode.BAD_REQUEST);
        }

        String token = cache.hget(Types.CSRF_TOKEN.getType(), _csrf_token);
        if (StringUtils.isBlank(token)) {
            return RestResponseBo.fail(ErrorCode.BAD_REQUEST);
        }

        if (null == cid || StringUtils.isBlank(text)) {
            return RestResponseBo.fail("请输入完整后评论");
        }

        if (StringUtils.isNotBlank(author) && author.length() > 50) {
            return RestResponseBo.fail("姓名过长");
        }

        if (StringUtils.isNotBlank(mail) && !TaleUtils.isEmail(mail)) {
            return RestResponseBo.fail("请输入正确的邮箱格式");
        }

        if (StringUtils.isNotBlank(url) && !PatternKit.isURL(url)) {
            return RestResponseBo.fail("请输入正确的URL格式");
        }

        if (text.length() > 200) {
            return RestResponseBo.fail("请输入200个字符以内的评论");
        }

        String val = IPKit.getIpAddrByRequest(request) + ":" + cid;
        Integer count = cache.hget(Types.COMMENTS_FREQUENCY.getType(), val);
        if (null != count && count > 0) {
            return RestResponseBo.fail("您发表评论太快了，请过会再试");
        }

        author = TaleUtils.cleanXSS(author);
        text = TaleUtils.cleanXSS(text);

        author = EmojiParser.parseToAliases(author);
        text = EmojiParser.parseToAliases(text);

        CommentVo comments = new CommentVo();
        comments.setAuthor(author);
        comments.setCid(cid);
        comments.setIp(request.getRemoteAddr());
        comments.setUrl(url);
        comments.setContent(text);
        comments.setMail(mail);
        comments.setParent(coid);
        comments.setStatus("not_audit");
        try {
            commentService.insertComment(comments);
            cookie("tale_remember_author", URLEncoder.encode(author, "UTF-8"), 7 * 24 * 60 * 60, response);
            cookie("tale_remember_mail", URLEncoder.encode(mail, "UTF-8"), 7 * 24 * 60 * 60, response);
            if (StringUtils.isNotBlank(url)) {
                cookie("tale_remember_url", URLEncoder.encode(url, "UTF-8"), 7 * 24 * 60 * 60, response);
            }
            // 设置对每个文章1分钟可以评论一次
            cache.hset(Types.COMMENTS_FREQUENCY.getType(), val, 1, 60);
            return RestResponseBo.ok();
        } catch (Exception e) {
            String msg = "评论发布失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
    }

    /**
     * 搜索页
     *
     * @param keyword
     * @return
     */
    @RequestMapping(value = "search/{keyword}",method = RequestMethod.GET)
    @ApiOperation(value = "查看搜索页", notes = "查看搜索页", httpMethod = "GET")
    public String search(HttpServletRequest request, @PathVariable String keyword, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        return this.search(request, keyword, 1, limit);
    }

    @RequestMapping(value = "search/{keyword}/{page}",method = RequestMethod.GET)
    @ApiOperation(value = "搜索页分页", notes = "搜索页分页", httpMethod = "GET")
    public String search(HttpServletRequest request, @PathVariable String keyword, @PathVariable int page, @RequestParam(value = "limit", defaultValue = "12") int limit) {
        page = page < 0 || page > WebConst.MAX_PAGE ? 1 : page;
        PageInfo<ContentVo> articles = contentService.getArticles(keyword, page, limit);
        request.setAttribute("articles", articles);
        request.setAttribute("type", "搜索");
        request.setAttribute("keyword", keyword);
        return render("page-category");
    }

    /**
     * 更新文章的点击率
     *
     * @param cid
     * @param chits
     */
    @Transactional(rollbackFor = TipException.class)
    public void updateArticleHit(Integer cid, Integer chits) {
        Integer hits = cache.hget("article", "hits");
        if (chits == null) {
            chits = 0;
        }
        hits = null == hits ? 1 : hits + 1;
        if (hits >= WebConst.HIT_EXCEED) {
            ContentVo temp = new ContentVo();
            temp.setCid(cid);
            temp.setHits(chits + hits);
            contentService.updateContentByCid(temp);
            cache.hset("article", "hits", 1);
        } else {
            cache.hset("article", "hits", hits);
        }
    }

    /**
     * 抽取公共方法
     *
     * @param request
     * @param contents
     */
    public void completeArticle(HttpServletRequest request, ContentVo contents) {
        if (contents.getAllowComment()) {
            String cp = request.getParameter("cp");
            if (StringUtils.isBlank(cp)) {
                cp = "1";
            }
            request.setAttribute("cp", cp);
            PageInfo<CommentBo> commentsPaginator = commentService.getComments(contents.getCid(), Integer.parseInt(cp), 6);
            request.setAttribute("comments", commentsPaginator);
        }
    }

    /**
     * 设置cookie
     *
     * @param name
     * @param value
     * @param maxAge
     * @param response
     */
    public void cookie(String name, String value, int maxAge, HttpServletResponse response) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setSecure(false);
        response.addCookie(cookie);
    }

    /**
     * 上传文件接口
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "upload",method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "上传文件", notes = "上传文件", httpMethod = "POST")
    public RestResponseBo upload(HttpServletRequest request, @RequestParam("file") MultipartFile[] multipartFiles) throws IOException {
        List<String> errorFiles = new ArrayList<>();
        FontUserVo users = this.fontUser(request);
        Integer uid = users.getUid();
        CLASSPATH = request.getSession().getServletContext().getRealPath("upload");
        try{
            for (MultipartFile multipartFile : multipartFiles) {
                String fname = multipartFile.getOriginalFilename();
                if (multipartFile.getSize() <= WebConst.MAX_FILE_SIZE) {
                    String fkey = TaleUtils.getFileKey(fname);
                    String ftype = TaleUtils.isImage(multipartFile.getInputStream()) ? Types.IMAGE.getType() : Types.FILE.getType();
                    File file = new File(CLASSPATH+fkey);
                    try {
                        FileCopyUtils.copy(multipartFile.getInputStream(),new FileOutputStream(file));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    FontUserVo userVo = new FontUserVo();
                    userVo.setUid(uid);
                    users.setHeadPhoto("/upload"+fkey);
                    request.getSession().setAttribute(WebConst.FONTLOGIN_SESSION_KEY, users);
                    userVo.setHeadPhoto("/upload"+fkey);
                    fontUserService.updateByUid(userVo);
//                    attachService.save(fname, fkey, ftype, uid);
                } else {
                    errorFiles.add(fname);
                }
            }
        } catch (Exception e) {
            return RestResponseBo.fail();
        }
        return RestResponseBo.ok(errorFiles);
    }
}
