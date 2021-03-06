package util.dialect.limit;

import java.util.Properties;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.mapping.MappedStatement.Builder;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import util.dialect.IDialect;
import util.dialect.IDialectManager;


@Intercepts( { @Signature(type = Executor.class, method = "query", args = {
		MappedStatement.class, Object.class, RowBounds.class,
		ResultHandler.class }) })
@Component("offsetLimitInterceptor")
public class OffsetLimitInterceptor implements Interceptor {
	static int MAPPED_STATEMENT_INDEX = 0;
	static int PARAMETER_INDEX = 1;
	static int ROWBOUNDS_INDEX = 2;
	static int RESULT_HANDLER_INDEX = 3;

	private IDialectManager dialectManager;

	/**
	 * set the dialectManager
	 * @param dialectManager the dialectManager to set
	 */
	@Autowired(required=true)
	public void setDialectManager(IDialectManager dialectManager) {
		this.dialectManager = dialectManager;
	}

	private String dialectName;

	/**
	 * set the dialectName
	 * @param dialectName the dialectName to set
	 */
	public void setDialectName(String dialectName) {
		this.dialectName = dialectName;
	}

	public Object intercept(Invocation invocation) throws Throwable {
		processIntercept(invocation.getArgs());
		return invocation.proceed();

	}

	void processIntercept(final Object[] queryArgs) {
		// queryArgs = query(MappedStatement ms, Object parameter, RowBounds
		// rowBounds, ResultHandler resultHandler)
		MappedStatement ms = (MappedStatement) queryArgs[MAPPED_STATEMENT_INDEX];
		Object parameter = queryArgs[PARAMETER_INDEX];
		final RowBounds rowBounds = (RowBounds) queryArgs[ROWBOUNDS_INDEX];
		int offset = rowBounds.getOffset();
		int limit = rowBounds.getLimit();
		// 获取方言
		IDialect dialect = dialectManager.getDialect(dialectName);
		// 支持limit及offset.则完全使用数据库分页
		if (dialect.supportsLimit()
				&& (offset != RowBounds.NO_ROW_OFFSET || limit != RowBounds.NO_ROW_LIMIT)) {
			BoundSql boundSql = ms.getBoundSql(parameter);
			String sql = boundSql.getSql().trim();
			if (dialect.supportsLimitOffset()) {
//				sql = dialect.getLimitString(sql, offset,Integer.toString(offset), limit,Integer.toString(limit));
				sql = dialect.getLimitString(sql, offset, limit);
				offset = RowBounds.NO_ROW_OFFSET;
			} else {
				sql = dialect.getLimitString(sql, 0, limit);
			}
			
			limit = RowBounds.NO_ROW_LIMIT;

			queryArgs[ROWBOUNDS_INDEX] = new RowBounds(offset, limit);
			Configuration con = new Configuration();
			BoundSql newBoundSql = new BoundSql(con, sql, boundSql
					.getParameterMappings(), boundSql.getParameterObject());
			MappedStatement newMs = copyFromMappedStatement(ms,
					new BoundSqlSqlSource(newBoundSql));
			queryArgs[MAPPED_STATEMENT_INDEX] = newMs;
			System.out.println(this.getClass()+"----------------分页sql---- "+sql);
		}
	}

	private MappedStatement copyFromMappedStatement(MappedStatement ms,
			SqlSource newSqlSource) {
		Builder builder = new MappedStatement.Builder(ms.getConfiguration(), ms
				.getId(), newSqlSource, ms.getSqlCommandType());
		builder.resource(ms.getResource());
		builder.fetchSize(ms.getFetchSize());
		builder.statementType(ms.getStatementType());
		builder.keyGenerator(ms.getKeyGenerator());
		builder.keyProperty(ms.getKeyProperty());
		builder.timeout(ms.getTimeout());
		builder.parameterMap(ms.getParameterMap());
		builder.resultMaps(ms.getResultMaps());
		builder.cache(ms.getCache());
		MappedStatement newMs = builder.build();
		return newMs;
	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

//	public Dialect getDialect() {
//		return dialect;
//	}
//
//	public void setDialect(Dialect dialect) {
//		this.dialect = dialect;
//	}

	public static class BoundSqlSqlSource implements SqlSource {
		BoundSql boundSql;

		public BoundSql getBoundSql(Object arg0) {
			return boundSql;
		}

		public BoundSqlSqlSource(BoundSql boundSql) {
			this.boundSql = boundSql;
		}
	}

	public void setProperties(Properties properties) {
//		String dialectClass =   properties.getProperty("dialect");   
//		
//		try {
//			dialect = (Dialect) Class.forName(dialectClass).newInstance();
//		} catch (Exception e) {
//			throw new RuntimeException(
//					"cannot create dialect instance by dialectClass:"
//							+ dialectClass, e);
//		}
	}

}
