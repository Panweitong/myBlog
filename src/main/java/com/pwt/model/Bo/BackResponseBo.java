package com.pwt.model.Bo;

import java.io.Serializable;

/**
 * Created by pwt on 2017/2/25.
 */
@SuppressWarnings({"ALL", "AlibabaClassMustHaveAuthor"})
public class BackResponseBo implements Serializable {

    private String attachPath;
    private String themePath;
    private String sqlPath;

    public String getAttachPath() {
        return attachPath;
    }

    public void setAttachPath(String attachPath) {
        this.attachPath = attachPath;
    }

    public String getThemePath() {
        return themePath;
    }

    public void setThemePath(String themePath) {
        this.themePath = themePath;
    }

    public String getSqlPath() {
        return sqlPath;
    }

    public void setSqlPath(String sqlPath) {
        this.sqlPath = sqlPath;
    }
}
