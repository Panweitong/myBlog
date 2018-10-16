package com.pwt.controller.admin;


import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.exception.TipException;
import com.pwt.model.Bo.BackResponseBo;
import com.pwt.model.Bo.RestResponseBo;
import com.pwt.model.Vo.OptionVo;
import com.pwt.service.ILogService;
import com.pwt.service.IOptionService;
import com.pwt.service.ISiteService;
import com.pwt.utils.GsonUtils;
import com.wordnik.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pwt on 2017/3/20.
 */
@Controller
@RequestMapping("/admin/setting")
public class SettingController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(SettingController.class);

    @Autowired
    private IOptionService optionService;

    @Autowired
    private ILogService logService;

    @Autowired
    private ISiteService siteService;

    /**
     * 系统设置
     */
    @RequestMapping(value = "",method = RequestMethod.GET)
    @ApiOperation(value = "获取系统设置", notes = "获取系统设置", httpMethod = "GET")
    public String setting(HttpServletRequest request) {
        List<OptionVo> voList = optionService.getOptions();
        Map<String, String> options = new HashMap<>();
        voList.forEach((option) -> {
            options.put(option.getName(), option.getValue());
        });
        request.setAttribute("options", options);
        return "admin/setting";
    }

    /**
     * 保存系统设置
     */
    @RequestMapping(value = "",method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "保存系统设置", notes = "保存系统设置", httpMethod = "POST")
    public RestResponseBo saveSetting(@RequestParam(required = false) String siteTheme, HttpServletRequest request) {
        try {
            Map<String, String[]> parameterMap = request.getParameterMap();
            Map<String, String> querys = new HashMap<>();
            parameterMap.forEach((key, value) -> {
                querys.put(key, join(value));
            });

            optionService.saveOptions(querys);

            WebConst.initConfig = querys;

            if (StringUtils.isNotBlank(siteTheme)) {
                BaseController.THEME = "themes/" + siteTheme;
            }
            logService.insertLog(LogActions.SYS_SETTING.getAction(), GsonUtils.toJsonString(querys), request.getRemoteAddr(), this.getUid(request));
            return RestResponseBo.ok();
        } catch (Exception e) {
            String msg = "保存设置失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
    }


    /**
     * 系统备份
     *
     * @return
     */
    @RequestMapping(value = "backup",method = RequestMethod.POST)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "系统备份", notes = "系统备份", httpMethod = "POST")
    public RestResponseBo backup(@RequestParam String bkType, @RequestParam String bkPath,
                                 HttpServletRequest request) {
        if (StringUtils.isBlank(bkType)) {
            return RestResponseBo.fail("请确认信息输入完整");
        }
        try {
            String classPath = request.getSession().getServletContext().getRealPath("upload");
            BackResponseBo backResponse = siteService.backup(bkType, bkPath, "yyyyMMddHHmm",classPath);
            logService.insertLog(LogActions.SYS_BACKUP.getAction(), null, request.getRemoteAddr(), this.getUid(request));
            return RestResponseBo.ok(backResponse);
        } catch (Exception e) {
            String msg = "备份失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
    }


    /**
     * 数组转字符串
     *
     * @param arr
     * @return
     */
    private String join(String[] arr) {
        StringBuilder ret = new StringBuilder();
        String[] var3 = arr;
        int var4 = arr.length;

        for (int var5 = 0; var5 < var4; ++var5) {
            String item = var3[var5];
            ret.append(',').append(item);
        }
        return ret.length() > 0 ? ret.substring(1) : ret.toString();
    }

    /**
     * 查看附件或者下载附件
     * @param request
     * @param response
     * @param fileName
     * @return
     */
    @RequestMapping(value = "/showPic/{fileName}",method = RequestMethod.GET)
    @ApiOperation(value = "查看附件或者下载附件", notes = "查看附件或者下载附件", httpMethod = "GET")
    public void  showPic(HttpServletRequest request, HttpServletResponse response, @PathVariable("fileName") String fileName){
        try {
            String classPath = request.getSession().getServletContext().getRealPath("upload");
            String name =  classPath +'/' +fileName+".zip";
            //获取输入流
            InputStream bis = new BufferedInputStream(new FileInputStream(new File(name)));
            //假如以中文名下载的话
            String filename = fileName+".zip";
            //转码，免得文件名中文乱码
            filename = URLEncoder.encode(filename,"UTF-8");
            //设置文件下载头
            response.addHeader("Content-Disposition", "attachment;filename=" + filename);
            //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
            response.setContentType("multipart/form-data");
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
            int len = 0;
            while((len = bis.read()) != -1){
                out.write(len);
                out.flush();
            }
            out.close();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
