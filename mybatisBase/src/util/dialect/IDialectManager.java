package util.dialect;

/**
 * 数据库方言管理器接口
 * @author hewei
 *
 */
public interface IDialectManager {

	/**
	 * 根据方言名称获取方言对象
	 * @param dialectName 方言名称
	 * @return 方言对象
	 */
	IDialect getDialect(String dialectName);

}
