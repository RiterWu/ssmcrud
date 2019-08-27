package com.xwh.entity;

import java.util.HashMap;
import java.util.Map;

/**
 * 封装一些通用信息（json格式）
 * 返回的结果状态和信息
 */
public class ResultData {
    //状态码  100 --成功；   404 --失败
    private int code;
    //提示信息
    private String msg;
    //返回给浏览器的数据
    private Map<String, Object> data = new HashMap<>();

    /**
     * 成功
     *
     * @return
     */
    public static ResultData success() {
        ResultData rd = new ResultData();
        rd.setCode(100);
        rd.setMsg("处理成功！");
        return rd;
    }

    /**
     * 失败
     *
     * @return
     */
    public static ResultData fail() {
        ResultData rd = new ResultData();
        rd.setCode(404);
        rd.setMsg("处理失败！");
        return rd;
    }

    /**
     * 添加返回的数据信息
     *
     * @param key
     * @param value
     * @return
     */
    public ResultData add(String key, Object value) {
        this.getData().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ResultData{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", data=" + data +
                '}';
    }
}
