package com.pwt.controller.admin;

import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.MetaDto;
import com.pwt.dto.Types;
import com.pwt.exception.TipException;
import com.pwt.model.bo.RestResponseBo;
import com.pwt.service.IMetaService;
import com.wordnik.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by pwt on 2017/2/21.
 */
@Controller
@RequestMapping("admin/category")
public class CategoryController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CategoryController.class);

    @Autowired
    private IMetaService metasService;

    /**
     * 分类页
     * @param request
     * @return
     */
    @RequestMapping(value = "",method = RequestMethod.GET)
    @ApiOperation(value = "分类页跳转", notes = "分类页跳转", httpMethod = "GET")
    public String index(HttpServletRequest request) {
        List<MetaDto> categories = metasService.getMetaList(Types.CATEGORY.getType(), null, WebConst.MAX_POSTS);
        List<MetaDto> tags = metasService.getMetaList(Types.TAG.getType(),  null, WebConst.MAX_POSTS);
        request.setAttribute("categories", categories);
        request.setAttribute("tags", tags);
        return "admin/category";
    }

    @RequestMapping(value = "save",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "修改分类", notes = "修改分类", httpMethod = "PUT")
    public RestResponseBo saveCategory(@RequestParam String cname, @RequestParam Integer mid) {
        try {
            metasService.saveMeta(Types.CATEGORY.getType(),cname,mid);
        } catch (Exception e) {
            String msg = "分类保存失败";
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
     * 删除分类
     * @param mid
     * @return
     */
    @RequestMapping(value = "delete",method = RequestMethod.DELETE)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "删除分类", notes = "删除分类", httpMethod = "DELETE")
    public RestResponseBo delete(@RequestParam int mid) {
        try {
            metasService.delete(mid);
        } catch (Exception e) {
            String msg = "删除失败";
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
