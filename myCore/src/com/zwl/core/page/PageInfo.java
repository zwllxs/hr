package com.zwl.core.page;

import java.io.Serializable;

/**
 * 命名规范:
 * 一个集合里的记录数，用size
 * 集合本身的数量用num
 * 通用的分页接口，不同的分页逻辑，可有不同的实现子类
 * @author zhangweilin
 *
 */
public interface PageInfo extends Serializable
{
 
    /**
     * 获取分页查询时的起始页
     * @return
     */
    public abstract int getStartLine();
    
    
    /**
     * 获取分页查询时的结束行
     * @return
     */
    public abstract int getEndLine();
    

    /**
     * 获取页码
     * @return
     */
    public abstract int getPageNo();

    /**
     * 设置页码
     * @param pageNo
     */
    public abstract void setPageNo(int pageNo);

    /**
     * 获取每页数量
     * @return
     */
    public abstract int getPerPageSize();
    
    
    /**
     * 获取上一页
     * @return
     */
    public abstract int getPrePageNo();
    
    
    /**
     * 获取下一页
     * @return
     */
    public abstract int getNextPageNo();
    
    /**
     * 设置每页数量
     * @param perPageSize
     */
    public abstract void setPerPageSize(int perPageSize);

    /**
     * 获取总数量
     * @return
     */
    public abstract int getTotalSize();

    /**
     * 设置总数量
     * @param totalSize
     */
    public abstract void setTotalSize(int totalSize);

    /**
     * 获取总页数
     * @return
     */
    public abstract int getTotalPageNum();
    
    public Object clone() throws CloneNotSupportedException;

}
