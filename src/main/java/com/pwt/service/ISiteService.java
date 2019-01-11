package com.pwt.service;

import com.pwt.dto.MetaDto;
import com.pwt.model.bo.ArchiveBo;
import com.pwt.model.bo.BackResponseBo;
import com.pwt.model.bo.StatisticsBo;
import com.pwt.model.vo.CommentVo;
import com.pwt.model.vo.ContentVo;

import java.util.List;

/**
 * 站点服务
 *
 * Created by pwt on 2017/2/23.
 */
public interface ISiteService {


    /**
     * 最新收到的评论
     *
     * @param limit
     * @return
     */
    List<CommentVo> recentComments(int limit);

    /**
     * 最新发表的文章
     *
     * @param limit
     * @return
     */
    List<ContentVo> recentContents(int limit);

    /**
     * 查询一条评论
     * @param coid
     * @return
     */
    CommentVo getComment(Integer coid);

    /**
     * 系统备份
     * @param bkType
     * @param bkPath
     * @param fmt
     * @return
     */
    BackResponseBo backup(String bkType, String bkPath, String fmt,String classPath) throws Exception;


    /**
     * 获取后台统计数据
     *
     * @return
     */
    StatisticsBo getStatistics();

    /**
     * 查询文章归档
     *
     * @return
     */
    List<ArchiveBo> getArchives();

    /**
     * 获取分类/标签列表
     * @return
     */
    List<MetaDto> metas(String type, String orderBy, int limit);

}
