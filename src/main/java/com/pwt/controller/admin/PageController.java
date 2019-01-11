package com.pwt.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.dto.Types;
import com.pwt.exception.TipException;
import com.pwt.model.bo.RestResponseBo;
import com.pwt.model.vo.ContentVo;
import com.pwt.model.vo.ContentVoExample;
import com.pwt.model.vo.UserVo;
import com.pwt.service.IContentService;
import com.pwt.service.ILogService;
import com.wordnik.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by pwt on 2017/2/21.
 */
@Controller
@RequestMapping("admin/page")
public class PageController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(PageController.class);

    @Autowired
    private IContentService contentsService;

    @Autowired
    private ILogService logService;

    @RequestMapping(value = "",method = RequestMethod.GET)
    @ApiOperation(value = "获取自定义页面列表", notes = "获取自定义页面列表", httpMethod = "GET")
    public String index(HttpServletRequest request) {
        ContentVoExample contentVoExample = new ContentVoExample();
        contentVoExample.setOrderByClause("created desc");
        contentVoExample.createCriteria().andTypeEqualTo(Types.PAGE.getType());
        PageInfo<ContentVo> contentsPaginator = contentsService.getArticlesWithpage(contentVoExample, 1, WebConst.MAX_POSTS);
        request.setAttribute("articles", contentsPaginator);
        return "admin/page_list";
    }

    @RequestMapping(value = "new",method = RequestMethod.GET)
    @ApiOperation(value = "增加自定义页面", notes = "增加自定义页面", httpMethod = "GET")
    public String newPage(HttpServletRequest request) {
        return "admin/page_edit";
    }


    @RequestMapping(value = "/{cid}",method = RequestMethod.GET)
    @ApiOperation(value = "编辑自定义页面跳转", notes = "编辑自定义页面跳转", httpMethod = "GET")
    public String editPage(@PathVariable String cid, HttpServletRequest request) {
        ContentVo contents = contentsService.getContents(cid);
        request.setAttribute("contents", contents);
        return "admin/page_edit";
    }

    @RequestMapping(value = "publish",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "增加自定义页面", notes = "增加自定义页面", httpMethod = "POST")
    @Transactional(rollbackFor = TipException.class)
    public RestResponseBo publishPage(@RequestParam String title, @RequestParam String content,
                                      @RequestParam String status, @RequestParam String slug,
                                      @RequestParam boolean allowComment, @RequestParam boolean allowPing,
                                      @RequestParam boolean allowFeed,HttpServletRequest request) {

        UserVo users = this.user(request);
        ContentVo contents = new ContentVo();
        contents.setTitle(title);
        contents.setContent(content);
        contents.setStatus(status);
        contents.setSlug(slug);
        contents.setType(Types.PAGE.getType());

        contents.setAllowComment(allowComment);
        contents.setAllowPing(allowPing);
        contents.setAllowFeed(allowFeed);

        contents.setAuthorId(users.getUid());

        try {
            contentsService.publish(contents);
        } catch (Exception e) {
            String msg = "页面发布失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }

    @RequestMapping(value = "modify",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "修改自定义页面", notes = "修改自定义页面", httpMethod = "PUT")
    public RestResponseBo modifyArticle(@RequestParam Integer cid, @RequestParam String title,
                                        @RequestParam String content, @RequestParam String status,
                                        @RequestParam String slug, @RequestParam boolean allowComment,
                                        @RequestParam boolean allowPing, @RequestParam boolean allowFeed,
                                        HttpServletRequest request) {

        UserVo users = this.user(request);
        ContentVo contents = new ContentVo();
        contents.setCid(cid);
        contents.setTitle(title);
        contents.setContent(content);
        contents.setStatus(status);
        contents.setSlug(slug);
        contents.setType(Types.PAGE.getType());
        contents.setAllowComment(allowComment);
        contents.setAllowPing(allowPing);
        contents.setAllowFeed(allowFeed);

        contents.setAuthorId(users.getUid());
        try {
            contentsService.updateArticle(contents);
        } catch (Exception e) {
            String msg = "页面编辑失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }

    @RequestMapping(value = "delete",method = RequestMethod.DELETE)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "删除自定义页面", notes = "删除自定义页面", httpMethod = "DELETE")
    public RestResponseBo delete(@RequestParam int cid, HttpServletRequest request) {
        try {
            contentsService.deleteByCid(cid);
            logService.insertLog(LogActions.DEL_PAGE.getAction(), cid + "", request.getRemoteAddr(), this.getUid(request));
        } catch (Exception e) {
            String msg = "页面删除失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }
}
