package com.pwt.dto;


/**
 * 用户注册表单
 *
 * @author panweitong
 */

public class UserRegisterForm {

  /**
   * 用户名
   */
  private String username;

  /**
   * 密码
   */
  private String password;

  /**
   * 确认密码
   */
  private String confirmpassword;

  /**
   * 电子邮箱
   */
  private String email;

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getConfirmpassword() {
        return confirmpassword;
    }

  public void setConfirmpassword(String confirmpassword) {
        this.confirmpassword = confirmpassword;
    }
}
