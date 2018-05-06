package com.pwt.utils;

import com.google.gson.Gson;

/**
 * json转换工具
 * Created by pwt on 2017/3/13 013.
 */
public class GsonUtils {

    private static final Gson gson = new Gson();

    public static String toJsonString(Object object){
      return object==null?null:gson.toJson(object);
    }
}
