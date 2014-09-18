package com.zwlsoft.service.dao4;



import java.util.Collections;
import java.util.List;

/**
 * 支持泛型的分页数据对象的默认实现类
 * @author 赵士杰
 */
@SuppressWarnings("unchecked")
public class GenericDefaultPage<T> implements IGenericPage<T> {

	/** 当前页数据列表 */
	private List<T> elements;

	/** 页大小（每页数据个数） */
	private int pageSize;

	/** 当前页号 */
	private int pageNo;

	/** 数据总个数 */
	private int totalCount = 0;
	
	/**
	 * 根据当前页号、页大小（每页数据个数）、当前页数据列表、数据总个数构造分页数据对象的实例。
	 * @param pageNo 当前页号
	 * @param pageSize 页大小（每页数据个数）
	 * @param elements 当前页数据列表
	 * @param totalCount 数据总个数
	 */
	public GenericDefaultPage(
			int pageNo, int pageSize, List<T> elements, int totalCount) {
		this.pageNo = pageNo;
		this.pageSize = pageSize;
		this.elements = elements;
		this.totalCount = totalCount;
	}
	
    /**
     * 定义一空页
     *
     * @see #emptyPage()
     */
	public static final GenericDefaultPage EMPTY_PAGE = new GenericDefaultPage(
			0, 0, Collections.emptyList(), 0);

    /**
     * 获取一空页
     */
	public static <E> GenericDefaultPage<E> emptyPage() {
		return (GenericDefaultPage<E>) EMPTY_PAGE;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#isFirstPage()
	 */
	public boolean isFirstPage() {
		return getPageNo() == 0;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#isLastPage()
	 */
	public boolean isLastPage() {
		return getPageNo() >= getLastPageNo();
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#hasNextPage()
	 */
	public boolean hasNextPage() {
		return elements == null ? false : elements.size() > getPageSize();
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#hasPreviousPage()
	 */
	public boolean hasPreviousPage() {
		return getPageNo() > 0;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getLastPageNo()
	 */
	public int getLastPageNo() {
		double totalResults = new Integer(getTotalCount())
				.doubleValue();
		return (totalResults % getPageSize()==0)?new Double(Math.floor(totalResults / getPageSize())).intValue():(new Double(Math.floor(totalResults / getPageSize())).intValue()+1);
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getThisPageElements()
	 */
	public List<T> getThisPageElements() {
		return hasNextPage() ? elements.subList(0, getPageSize()) : elements;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getTotalCount()
	 */
	public int getTotalCount() {
		return totalCount;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getThisPageFirstElementNumber()
	 */
	public int getThisPageFirstElementNumber() {
		return getPageNo() * getPageSize() + 1;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getThisPageLastElementNumber()
	 */
	public int getThisPageLastElementNumber() {
		int fullPage = getThisPageFirstElementNumber() + getPageSize() - 1;
		return getTotalCount() < fullPage
				? getTotalCount() : fullPage;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getNextPageNo()
	 */
	public int getNextPageNo() {
		return getPageNo() + 1;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getPreviousPageNo()
	 */
	public int getPreviousPageNo() {
		return getPageNo() - 1;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getPageSize()
	 */
	public int getPageSize() {
		return pageSize;
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.query.generic.IGenericPage#getPageNo()
	 */
	public int getPageNo() {
		return pageNo;
	}
	
    /**
     * 根据页大小（每页数据个数）获取给定页号的第一条数据在总数据中的位置（从1开始）
     * @param pageNo 给定的页号
     * @param pageSize 页大小（每页数据个数）
     * @return 给定页号的第一条数据在总数据中的位置（从1开始）
     */
    public static int getStartOfPage(int pageNo, int pageSize) {
        int startIndex = (pageNo - 1) * pageSize + 1;
        if (startIndex < 1) startIndex = 1;
        return startIndex;
    }
    

}
