package com.pwt.utils;

import java.awt.*;
import java.util.Random;

public class CodeMakerUtil {

    private static final long serialVersionUID = 1L;

    /**
     * 生成随机类
     */
    static Random random = new Random();

    /**
     * 验证码字体
     */
    private static Font[] codeFont =
            {
                    new Font("Times New Roman", Font.PLAIN,35),
                    new Font("Times New Roman", Font.PLAIN, 35),
                    new Font("Times New Roman", Font.PLAIN,35),
                    new Font("Times New Roman", Font.PLAIN, 35)
            };

    /**
     * 验证码数字颜色
     */
    private static Color[] color = {
                        Color.BLACK, Color.RED, Color.DARK_GRAY, Color.BLUE
                    };

    public static String codeNumbers = "";

    private static int width = 100;

    private static int height = 42;

    /**
     * 绘制验证码
      */
    public static void drawCode(Graphics graphics, int i)
    {
        String number = String.valueOf(random.nextInt(10));
        graphics.setFont(codeFont[i]);
        graphics.setColor(color[i]);
        //绘制验证码到图片X、Y
        graphics.drawString(number, 30 + i * 13,32);

        codeNumbers += number;
    }

    /**
     * 绘制干扰线
     * @param graphics
     * @param lineNumber
     */
    public static void drawNoise(Graphics graphics, int lineNumber)
    {
        graphics.setColor(getRandColor(160,200));
        for (int i = 0; i < lineNumber; i++)
        {
            int pointX1 = 1 + (int)(Math.random() * width);
            int pointY1 = 1 + (int)(Math.random() * height);
            int pointX2 = 1 + (int)(Math.random() * width);
            int pointY2 = 1 + (int)(Math.random() * height);
            graphics.drawLine(pointX1, pointY1, pointX2, pointY2);
        }
    }

    public static Color getRandColor(int fc, int bc){//给定范围获得随机颜色
        Random random = new Random();
        if(fc>255) {
            fc=255;
        }
        if(bc>255) {
            bc=255;
        }
        int r=fc+random.nextInt(bc-fc);
        int g=fc+random.nextInt(bc-fc);
        int b=fc+random.nextInt(bc-fc);
        return new Color(r,g,b);
    }
}
