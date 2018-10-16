package com.pwt.utils;

import com.pwt.dto.MailSenderInfo;

public class MailUtil {

    /**
     * 邮箱发送前的配置
     * @param serverHost
     * @param serverPort
     * @param isValidate
     * @param userName
     * @param password
     * @param toMailAddress
     * @param subtitle
     * @param contents
     */
    public static void setMail(String serverHost, String serverPort,
                               Boolean isValidate, String userName, String password,
                               String toMailAddress, String subtitle, String contents) {
        // 这个类主要是设置邮件
        MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setMailServerHost(serverHost);
        mailInfo.setMailServerPort(serverPort);
        mailInfo.setValidate(isValidate);
        mailInfo.setUserName(userName);
        // 您的邮箱密码
        mailInfo.setPassword(password);
        mailInfo.setFromAddress(userName);
        mailInfo.setToAddress(toMailAddress);
        mailInfo.setSubject(subtitle);
        mailInfo.setContent(contents);
        // 这个类主要来发送邮件
        SimpleMailSender sms = new SimpleMailSender();
        //  sms.sendTextMail(mailInfo);// 发送文体格式
        // 发送html格式
        SimpleMailSender.sendHtmlMail(mailInfo);
    }
}
