package com.pwt.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.dto.Types;
import com.pwt.exception.TipException;
import com.pwt.model.Bo.RestResponseBo;
import com.pwt.model.Vo.ContentVo;
import com.pwt.model.Vo.ContentVoExample;
import com.pwt.model.Vo.MetaVo;
import com.pwt.model.Vo.UserVo;
import com.pwt.service.IContentService;
import com.pwt.service.ILogService;
import com.pwt.service.IMetaService;


import com.wordnik.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by pwt on 2017/2/21.
 */
@Controller("articleController")
@RequestMapping("admin/article")
@Transactional(rollbackFor = TipException.class)
public class ArticleController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(ArticleController.class);

    @Autowired
    private IContentService contentsService;

    @Autowired
    private IMetaService metasService;

    @Autowired
    private ILogService logService;

    /**
     * 文章列表
     * @param page
     * @param limit
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "",method = RequestMethod.GET)
    @ApiOperation(value = "获取文章列表", notes = "获取文章列表", httpMethod = "GET", response = ContentVo.class)
    public String index(@RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "limit", defaultValue = "15") int limit, HttpServletRequest request, Model model) {
        ContentVoExample contentVoExample = new ContentVoExample();
        contentVoExample.setOrderByClause("created desc");
        contentVoExample.createCriteria().andTypeEqualTo(Types.ARTICLE.getType());
        PageInfo<ContentVo> contentsPaginator = contentsService.getArticlesWithpage(contentVoExample,page,limit);
        model.addAttribute("articles", contentsPaginator);
        return "admin/article_list";
    }

    /**
     * 文章发表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/publish",method = RequestMethod.GET)
    @ApiOperation(value = "根据类型查询项目列表", notes = "根据类型查询项目列表", httpMethod = "GET", response = MetaVo.class)
    public String newArticle(HttpServletRequest request,Model model) {
        List<MetaVo> categories = metasService.getMetas(Types.CATEGORY.getType());
        model.addAttribute("categories", categories);
        return "admin/article_edit";
    }

    /**
     * 文章编辑
     * @param cid
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/{cid}",method = RequestMethod.GET)
    @ApiOperation(value = "文章编辑", notes = "文章编辑", httpMethod = "GET")
    public String editArticle(@PathVariable("cid") String cid, HttpServletRequest request, Model model) {
        ContentVo contents = contentsService.getContents(cid);
        request.setAttribute("contents", contents);
        List<MetaVo> categories = metasService.getMetas(Types.CATEGORY.getType());
        model.addAttribute("categories", categories);
        model.addAttribute("active", "article");
        return "admin/article_edit";
    }

    /**
     * 文章发表
     * @param contents
     * @param request
     * @return
     */
    @RequestMapping(value = "/publish",method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "文章发表", notes = "文章发表", httpMethod = "POST")
    public RestResponseBo publishArticle(ContentVo contents, HttpServletRequest request) {
        UserVo users = this.user(request);
        contents.setAuthorId(users.getUid());
        contents.setType(Types.ARTICLE.getType());
        if (StringUtils.isBlank(contents.getCategories())) {
            contents.setCategories("默认分类");
        }
        try {
            contentsService.publish(contents);
        } catch (Exception e) {
            String msg = "文章发布失败";
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
     * 文章更新
     * @param contents
     * @param request
     * @return
     */
    @RequestMapping(value = "/modify",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "文章更新", notes = "文章更新", httpMethod = "PUT")
    public RestResponseBo modifyArticle(ContentVo contents,HttpServletRequest request) {
        UserVo users = this.user(request);
        contents.setAuthorId(users.getUid());
        contents.setType(Types.ARTICLE.getType());
        try {
            contentsService.updateArticle(contents);
        } catch (Exception e) {
            String msg = "文章编辑失败";
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
     * 删除文章
     * @param cid
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete",method = RequestMethod.DELETE)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "删除文章", notes = "删除文章", httpMethod = "DELETE")
    public RestResponseBo deleteArticle(@RequestParam("cid") int cid, HttpServletRequest request) {
        try {
            contentsService.deleteByCid(cid);
            logService.insertLog(LogActions.DEL_ARTICLE.getAction(), cid+"", request.getRemoteAddr(), this.getUid(request));
        } catch (Exception e) {
            String msg = "文章删除失败";
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
