package util.dialect;

/**
 * 数据库方言基础实现类，此类不支持分页处理。
 * @author hewei
 *
 */
public class Dialect implements IDialect {

	/* (non-Javadoc)
	 * @see com.harmony.framework.dao.mybatis.dialect.IDialect#supportsLimit()
	 */
	public boolean supportsLimit(){
    	return false;
    }

    /* (non-Javadoc)
     * @see com.harmony.framework.dao.mybatis.dialect.IDialect#supportsLimitOffset()
     */
    public boolean supportsLimitOffset() {
    	return supportsLimit();
    }
    
    /* (non-Javadoc)
     * @see com.harmony.framework.dao.mybatis.dialect.IDialect#getLimitString(java.lang.String, int, int)
     */
    public String getLimitString(String sql, int offset, int limit) {
    	return getLimitString(sql,offset,Integer.toString(offset),limit,Integer.toString(limit));
    }
    
    /**
     * 将sql变成分页sql语句,提供将offset及limit使用占位符(placeholder)替换。
     * 需要由子类重写此方法实现sql语句分页处理拼装以及占位符替换
     * <pre>
     * 如mysql
     * dialect.getLimitString("select * from user", 12, ":offset",0,":limit") 将返回
     * select * from user limit :offset,:limit
     * </pre>
     * @return 包含占位符的分页sql
     */
    protected String getLimitString(String sql, int offset,String offsetPlaceholder, int limit,String limitPlaceholder) {
    	throw new UnsupportedOperationException("paged queries not supported");
    } 

}
