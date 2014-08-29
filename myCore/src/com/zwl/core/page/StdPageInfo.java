package com.zwl.core.page;

import java.io.Serializable;

import com.zwl.core.tag.page.constants.PageConstants;

/**
 * 标准的默认分页实现
 * @author zhangweilin
 *
 */
@SuppressWarnings("serial")
public class StdPageInfo implements PageInfo, Serializable, Cloneable
{

    /**
     * 当前页
     */
    private int page;

    /**
     * 每页数目
     */
    private int perPageSize;

    /**
     * 总条数
     */
    private int totalSize;
    
    public StdPageInfo(int perPageSize)
    {
        this.perPageSize = perPageSize;
    }

    public int getPageNo()
    {
        return page;
    }

    public void setPageNo(int page)
    {
        this.page = page;
    }

    public int getPerPageSize()
    {
        return perPageSize;
    }

    public void setPerPageSize(int perPageSize)
    {
        this.perPageSize = perPageSize;
    }

    public int getTotalSize()
    {
        return totalSize;
    }

    public void setTotalSize(int totalSize)
    {
        this.totalSize = totalSize;
    }

    public int getTotalPageNum()
    {
        perPageSize=perPageSize==0?PageConstants.perPageSize:perPageSize;
        if (totalSize % perPageSize == 0)
        {
            return totalSize / perPageSize;
        }
        else
        {
            return totalSize / perPageSize + 1;
        }
    }
    
    @Override
    public int getStartLine()
    {
        return (getPageNo()-1)*getPerPageSize();
    }
    
    @Override
    public int getEndLine()
    {
        return getPageNo()*getPerPageSize()-1;
    }
    
    
    /* (non-Javadoc)
     * @see java.lang.Object#clone()
     */
    @Override
    public Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }

    @Override
    public int getNextPageNo()
    {
        return getPageNo()+1;
    }

    @Override
    public int getPrePageNo()
    {
        return getPageNo()-1;
    }
}
