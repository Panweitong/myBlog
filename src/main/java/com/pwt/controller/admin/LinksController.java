package com.pwt.controller.admin;

import com.pwt.controller.BaseController;
import com.pwt.dto.Types;
import com.pwt.exception.TipException;
import com.pwt.model.bo.RestResponseBo;
import com.pwt.model.vo.MetaVo;
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
@RequestMapping("admin/links")
public class LinksController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(LinksController.class);

    @Autowired
    private IMetaService metasService;

    /**
     * 友链
     * @param request
     * @return
     */
    @RequestMapping(value = "",method = RequestMethod.GET)
    @ApiOperation(value = "获取友链", notes = "获取友链", httpMethod = "GET")
    public String index(HttpServletRequest request) {
        List<MetaVo> metas = metasService.getMetas(Types.LINK.getType());
        request.setAttribute("links", metas);
        return "admin/links";
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "保存友链", notes = "保存友链", httpMethod = "POST")
    public RestResponseBo saveLink(@RequestParam String title, @RequestParam String url,
                                   @RequestParam String logo, @RequestParam Integer mid,
                                   @RequestParam(value = "sort", defaultValue = "0") int sort) {
        try {
            MetaVo metas = new MetaVo();
            metas.setName(title);
            metas.setSlug(url);
            metas.setDescription(logo);
            metas.setSort(sort);
            metas.setType(Types.LINK.getType());
            if (null != mid) {
                metas.setMid(mid);
                metasService.update(metas);
            } else {
                metasService.saveMeta(metas);
            }
        } catch (Exception e) {
            String msg = "友链保存失败";
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
    @ApiOperation(value = "删除友链", notes = "删除友链", httpMethod = "DELETE")
    public RestResponseBo delete(@RequestParam int mid) {
        try {
            metasService.delete(mid);
        } catch (Exception e) {
            String msg = "友链删除失败";
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
