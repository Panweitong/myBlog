package com.pwt.model.bo;

/**
 * @author pwt
 */
public class VisitTotalBo {
    private int accessToday;
    private int accessTotal;
    private int onlineCurrent;

    public int getAccessToday() {
        return accessToday;
    }

    public void setAccessToday(int accessToday) {
        this.accessToday = accessToday;
    }

    public int getAccessTotal() {
        return accessTotal;
    }

    public void setAccessTotal(int accessTotal) {
        this.accessTotal = accessTotal;
    }

    public int getOnlineCurrent() {
        return onlineCurrent;
    }

    public void setOnlineCurrent(int onlineCurrent) {
        this.onlineCurrent = onlineCurrent;
    }
}
