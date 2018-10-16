package com.pwt.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pwt.constant.WebConst;
import com.pwt.controller.BaseController;
import com.pwt.dto.LogActions;
import com.pwt.dto.Types;
import com.pwt.exception.TipException;
import com.pwt.model.Bo.RestResponseBo;
import com.pwt.model.Vo.AttachVo;
import com.pwt.model.Vo.UserVo;
import com.pwt.service.IAttachService;
import com.pwt.service.ILogService;
import com.pwt.utils.Commons;
import com.pwt.utils.TaleUtils;
import com.wordnik.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * 附件管理
 *
 * Created by pwt on 2017/2/21.
 */
@Controller
@RequestMapping("admin/attach")
public class AttachController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AttachController.class);

    public static String classPath = "";

    @Autowired
    private IAttachService attachService;

    @Autowired
    private ILogService logService;

    /**
     * 附件页面
     *
     * @param request
     * @param page
     * @param limit
     * @param model
     * @return
     */
    @RequestMapping(value = "",method=RequestMethod.GET)
    @ApiOperation(value = "显示附件列表", notes = "显示附件列表", httpMethod = "GET")
    public String index(HttpServletRequest request, Model model,@RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "limit", defaultValue = "12") int limit) {
        PageInfo<AttachVo> attachPaginator = attachService.getAttachs(page, limit);
        request.setAttribute("attachs", attachPaginator);
        model.addAttribute(Types.ATTACH_URL.getType(), Commons.siteOption(Types.ATTACH_URL.getType(), Commons.siteUrl()));
        model.addAttribute("max_file_size", WebConst.MAX_FILE_SIZE / 1024);
        return "admin/attach";
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
        UserVo users = this.user(request);
        Integer uid = users.getUid();
        List<String> errorFiles = new ArrayList<>();
        classPath = request.getSession().getServletContext().getRealPath("upload");
        try {
            for (MultipartFile multipartFile : multipartFiles) {
                String fname = multipartFile.getOriginalFilename();
                if (multipartFile.getSize() <= WebConst.MAX_FILE_SIZE) {
                    String fkey = TaleUtils.getFileKey(fname);
                    String ftype = TaleUtils.isImage(multipartFile.getInputStream()) ? Types.IMAGE.getType() : Types.FILE.getType();
                    File file = new File(classPath+fkey);
                    try {
                        FileCopyUtils.copy(multipartFile.getInputStream(),new FileOutputStream(file));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    attachService.save(fname, fkey, ftype, uid);
                } else {
                    errorFiles.add(fname);
                }
            }
        } catch (Exception e) {
            return RestResponseBo.fail();
        }
        return RestResponseBo.ok(errorFiles);
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
    public void  showPic(HttpServletRequest request, HttpServletResponse response,@PathVariable("fileName") String fileName){
        try {
            classPath = request.getSession().getServletContext().getRealPath("upload");
            String fkey =  attachService.selectByFkey(fileName);
            String name =  classPath + fkey;
            //获取输入流
            InputStream bis = new BufferedInputStream(new FileInputStream(new File(name)));
            //假如以中文名下载的话
            String filename = fkey.split("/")[1];
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


    /**
     * 删除附件
     * @param id
     * @param request
     * @return
     */
    @RequestMapping(value = "delete",method = RequestMethod.DELETE)
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    @ApiOperation(value = "删除附件", notes = "删除附件", httpMethod = "DELETE")
    public RestResponseBo delete(@RequestParam Integer id, HttpServletRequest request) {
        try {
            AttachVo attach = attachService.selectById(id);
            classPath = request.getSession().getServletContext().getRealPath("upload");
            if (null == attach) {
                return RestResponseBo.fail("不存在该附件");
            }
            attachService.deleteById(id);
            new File(classPath+attach.getFkey()).delete();
            logService.insertLog(LogActions.DEL_ARTICLE.getAction(), attach.getFkey(), request.getRemoteAddr(), this.getUid(request));
        } catch (Exception e) {
            String msg = "附件删除失败";
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
