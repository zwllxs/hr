/*
	The MIT License (MIT)

	Copyright (c) 2014 abel533@gmail.com

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/

package com.github.pagehelper;

import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.List;

/**
 * Mybatis - 分页对象
 *
 * @author liuzh/abel533/isea533
 * @version 3.3.0
 *          项目地址 : http://git.oschina.net/free/Mybatis_PageHelper
 */
public class Page<E> extends ArrayList<E> {
    /**
     * 不进行count查询
     */
    private static final int NO_SQL_COUNT = -1;

    /**
     * 进行count查询
     */
    private static final int SQL_COUNT = 0;

    /**
     * 当前 分页 页码
     */
    private int pageNo;
    /**
     * 当前每页数量
     */
    private int pageSize;
    /**
     * 起始行
     */
    private int startRow;
    /**
     *  结束行
     */
    private int endRow;
    
    /**
     * 总记录数量
     */
    private long totalNum;
    /**
     * 总页数
     */
    private int pageNum;

    public Page(int pageNo, int pageSize) {
        this(pageNo, pageSize, SQL_COUNT);
    }

    public Page(int pageNo, int pageSize, boolean count) {
        this(pageNo, pageSize, count ? Page.SQL_COUNT : Page.NO_SQL_COUNT);
    }

    public Page(int pageNo, int pageSize, int totalNum) {
        super(pageSize > -1 ? pageSize : 0);
        //分页合理化，针对不合理的页码自动处理
        if (pageNo <= 0) {
            pageNo = 1;
        }
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.totalNum = totalNum;
        calculateStartAndEndRow();
    }

    public Page(RowBounds rowBounds, boolean count) {
        this(rowBounds, count ? Page.SQL_COUNT : Page.NO_SQL_COUNT);
    }


    public Page(RowBounds rowBounds, int totalNum) {
        super(rowBounds.getLimit() > -1 ? rowBounds.getLimit() : 0);
        this.pageSize = rowBounds.getLimit();
        this.startRow = rowBounds.getOffset();
        //RowBounds方式默认不求count总数，如果想求count,可以修改这里为SQL_COUNT
        this.totalNum = totalNum;
        this.endRow = this.startRow + this.pageSize;
    }

    public List<E> getResult() {
        return this;
    }

    public int getPageNum() {
        return pageNum;
    }

    public int getEndRow() {
        return endRow;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        //分页合理化，针对不合理的页码自动处理
        this.pageNo = pageNo <= 0 ? 1 : pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getStartRow() {
        return startRow;
    }

    public long getTotalNum() {
        return totalNum;
    }

    public void setTotalNum(long totalNum) {
        this.totalNum = totalNum;
        if (pageSize > 0) {
            pageNum = (int) (totalNum / pageSize + ((totalNum % pageSize == 0) ? 0 : 1));
        } else {
            pageNum = 0;
        }
        //分页合理化，针对不合理的页码自动处理
        if (pageNo > pageNum) {
            pageNo = pageNum;
            calculateStartAndEndRow();
        }
    }

    /**
     * 计算起止行号
     */
    private void calculateStartAndEndRow() {
        this.startRow = this.pageNo > 0 ? (this.pageNo - 1) * this.pageSize : 0;
        this.endRow = this.startRow + this.pageSize;
    }

    public boolean isCount() {
        return this.totalNum > NO_SQL_COUNT;
    }

    @Override
    public String toString()
    {
        return "Page [pageNo=" + pageNo + ", pageSize=" + pageSize
                + ", startRow=" + startRow + ", endRow=" + endRow
                + ", totalNum=" + totalNum + ", pageNum=" + pageNum + "]";
    }

}