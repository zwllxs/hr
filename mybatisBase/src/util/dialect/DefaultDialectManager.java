package util.dialect;

import java.util.HashMap;
import java.util.Map;

/**
 * 默认的数据库方言管理器实现类，对数据库方言对象进行管理。
 * 目前已经实现的数据库方言包括：
 * <pre>
   方言名称                      方言类
    db2            com.harmony.framework.dao.mybatis.dialect.DB2Dialect
    mysql          com.harmony.framework.dao.mybatis.dialect.MySQLDialect
    oracle         com.harmony.framework.dao.mybatis.dialect.OracleDialect
    sqlServer2005  com.harmony.framework.dao.mybatis.dialect.SQLServer2005Dialect
    sqlServer      com.harmony.framework.dao.mybatis.dialect.SQLServerDialect
 * </pre>
 * 如果没有指定有效的方言名称，将使用默认的方言类com.harmony.framework.dao.mybatis.dialect.Dialect。
 * @author hewei
 *
 */
public class DefaultDialectManager implements IDialectManager {

	private Map<String, IDialect> dialects;

	/**
	 * set the dialects
	 * @param dialects the dialects to set
	 */
	public void setDialects(Map<String, IDialect> dialects) {
		this.dialects = dialects;
		initDialects();
	}

	private IDialect defaultDialect = new Dialect();

	protected void initDialects() {
		if (dialects == null) {
			dialects = new HashMap<String, IDialect>();
			dialects.put("db2", new DB2Dialect());
			dialects.put("mysql", new MySQLDialect());
			dialects.put("oracle", new OracleDialect());
			dialects.put("sqlServer2005", new SQLServer2005Dialect());
			dialects.put("sqlServer", new SQLServerDialect());
		}
	}

	/* (non-Javadoc)
	 * @see com.harmony.framework.dao.mybatis.dialect.IDialectManager#getDialect(java.lang.String)
	 */
	public IDialect getDialect(String dialectName) {
		IDialect dialect = dialects.get(dialectName);
		if (dialect == null) {
			dialect = defaultDialect;
		}
		return dialect;
	}

}
