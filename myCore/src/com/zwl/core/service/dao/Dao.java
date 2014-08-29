package com.zwl.core.service.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.LockMode;
import org.hibernate.Session;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.zwl.core.page.PageInfo;
import com.zwl.core.po.Entity2;
import com.zwl.core.service.dao.exception.DAOException;

/**
 * 通用的DAO接口，所有的Service都能拿到此接口的引用，整个系统中,DAO接口只有一个，不同的业务组件，都共用一个DAO
 * 注意，如果hql语句中有动态的参数，我们不要用变量的方式去拼装hql语句，不安全且效率慢，这里提供自定义的参数查询
 * (此接口省略了几个不大常用的方法)
 * @author zhangweilin
 *
 * @param <Entity>  实体基类
 */
public interface Dao<Entity1>
{
	
	 /**
     * 获取hibernate模板,一般很少直接在业务中使用HibernateTemplate
     * @return
     */
    public abstract HibernateTemplate getDaoHibernateTemplate();
    
    /**
     * 获取jdbc模板,一般很少直接在业务中使用JdbcTemplate
     * @return
     */
    public abstract JdbcTemplate getJdbcTemplate() ;

    /**
     * 获取session
     */
    public abstract Session getDaoSession();
    
    
    /**
     * 通过指定的实体的class,查询出其所有的记录
     * @param clazz
     * @return
     */
    public abstract <T extends Entity2> List<T> findAll(Class<T> clazz) throws DAOException;

    /**
     * 按id查询 返回其对象
     * @param class1:CLASS
     * @param serializable:识别符,一般即主键id
     * @return
     */
    public abstract <T extends Entity2> T get(Class<T> clazz, Serializable serializable) throws DAOException;

    /**
     * 保存对象
     * @param entity
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void save(T entity) throws DAOException;

    /**
     * 修改对象
     * @param entity
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void update(T entity) throws DAOException;

    /**
     * 新增或保存对象
     * @param entity
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void saveOrUpdate(T entity) throws DAOException;
    
    /**
     * 批量新增或保存对象，批量的数据以集合的形式组织
     * @param entityColl
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void saveOrUpdateAll(Collection<T> entityColl) throws DAOException;

    /**
     * 直接删除对象，如果按id删除，可以按如下方式:
     * User user=new User();
     * user.setId(45);
     * delete(user);
     * 这样可以不写hql语句
     * 
     * @param entity
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void delete(T entity) throws DAOException;

    /**
     * 直接删除一个集合
     * @param collection
     * @throws DataAccessException
     */
    public abstract <T extends Entity2> void delete(Collection<T> entityColl) throws DAOException;

    /**
     * 仅仅是一条hql语句的查询，没有查询参数，也不分页
     * @param hql  hql语句
     * @return
     * @throws DataAccessException
     */
    @SuppressWarnings("unchecked")
    public abstract List find(String hql) throws DAOException;

    /**
     * 带一个参数的查询,例如有如下查询:
     *   String hql="from Admin where  userName like ? "; 
     *   find(hql, "%zhang%");
     *   如果我参数有很多个，参见find(String hql, List paramList)
     *   
     *   同样类型的查询，后同
     *   
     * @param hql hql语句
     * @param param  hql中的参数
     * @return  
     * @throws DataAccessException
     */
    @SuppressWarnings("unchecked")
    public abstract List find(String hql, Object param) throws DAOException;

    /**
     * 查询，支持多个参数，以数组的形式传递
     * @param hql  hql语句
     * @param paramArr  参数数组
     * @return
     * @throws DataAccessException
     */
	@SuppressWarnings("unchecked")
    public abstract List find(String hql, Object[] paramArr) throws DAOException;
	
    /**
     *  带多个参数的查询,例如有如下查询:
     *   String hql="from Admin where  userName like ? and sex= ? "; 
     *   List list=new ArrayList();
     *   list.add("%zhang%");
     *   list.add("男");
     *   find(hql, list);
     *   
     *   同样类型的查询，后同
     *   
     * @param hql
     * @param paramList
     * @return
     * @throws DataAccessException
     */
    @SuppressWarnings("unchecked")
    public abstract List find(String hql, List paramList) throws DAOException;

    /**
     * 带分页的查询
     * @param hql  hql语句
     * @param pageInfo  分页组件
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByPage(String hql, PageInfo pageInfo) throws DAOException;

    /**
     * 带分页的查询,可以接收一个参数
     * @param hql  hql语句
     * @param param  要传递的参数
     * @param pageInfo  分页组件
     * 参数的传递方式，见上
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByPage(String hql, Object param, PageInfo pageInfo) throws DAOException;

    /**
     * 带分页的查询。多个参数以数组的形式
     * @param hql  hql语句
     * @param paramArr  参数数组
     * @param pageInfo  分页组件
     * @param isNativeSql  是否是本地sql,true为本地sql,false为hql
     * @return
     */
	@SuppressWarnings("unchecked")
	public abstract List findByPageHqlOrSql(String hqlOrSql, Object[] paramArr, PageInfo pageInfo,boolean isNativeSql) throws DAOException;
	
	/**
	 * 带分页的查询。多个参数以数组的形式
	 * @param hql  hql语句
	 * @param paramArr  参数数组
	 * @param pageInfo  分页组件
	 * @param isNativeSql  是否是本地sql,true为本地sql,false为hql
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public abstract List findByPageNamedParamHqlOrSql(String hqlOrSql, String[] paramNameArr, Object[] paramValueArr, PageInfo pageInfo,boolean isNativeSql) throws DAOException;
	
    /**
     * 带分页的查询,可以接收多个参数
     * @param hql  hql语句
     * @param paramList  要传递的参数列表
     * @param pageInfo  分页组件
     * 参数的传递方式，见上
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByPage(String hql, List paramList, PageInfo pageInfo) throws DAOException;

	/**
	 * 查找唯一对象
	 * @param hql:hql语句
	 * @param paramArr:参数数组
	 * @return
	 */
	public abstract Object findUnique(String hql, Object[] paramArr) throws DAOException;
	
	
    /**
     * 查找唯一对象
     * @param :hql语句
     * @return
     */
    public abstract Object findUnique(String hql) throws DAOException;

    /**
     * 查找唯一对象,可以接收一个参数
     * @param :hql语句
     * @param param:要传递的参数
     * @return
     */
    public abstract Object findUnique(String hql, Object param) throws DAOException;


    /**
     * 查找唯一对象,可以接收一个参数
     * @param :hql语句
     * @param paramList:要传递的参数列表
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract Object findUnique(String hql, List paramList) throws DAOException;
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramName
     * @param paramValue
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParam(String hql,String paramName,Object paramValue) throws DAOException;
    
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramName
     * @param paramValue
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParam(String hql,String[] paramNameArr,Object[] paramValueArr) throws DAOException;
    
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramNameList
     * @param paramValueList
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParam(String hql, List<String> paramNameList ,List<Object> paramValueList) throws DAOException;
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramName
     * @param paramValue
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParamPage(String hql,String paramName,Object paramValue,PageInfo pageInfo) throws DAOException;
    
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramName
     * @param paramValue
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParamPage(String hql,String[] paramNameArr,Object[] paramValueArr,PageInfo pageInfo) throws DAOException;
    
    
    /**
     * 命名参数
     * @param <T>
     * @param hql
     * @param paramNameList
     * @param paramValueList
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNamedParamPage(String hql, List<String> paramNameList ,List<Object> paramValueList,PageInfo pageInfo) throws DAOException;
    
    

    /**
     * 直接执行HQL语句
     * @param :hql语句
     */
    public abstract int bulkUpdate(String hql) throws DAOException;

    /**
     * 直接执行HQL语句,可以接收一个参数
     * @param:hql hql语句
     * @param:param 要传递的参数
     */
    public abstract int bulkUpdate(String hql, Object param) throws DAOException;


    /**
     * 直接执行HQL语句,可以接收多个参数
     * @param:hql hql语句
     * @param:paramList 要传递的参数
     */
    @SuppressWarnings("unchecked")
    public abstract int bulkUpdate(String hql, List paramList) throws DAOException;
    
	/**
	 * 执行SQL语句
	 * @param hql:hql语句
	 * @param paramArr :参数数组
	 */
	public abstract int bulkUpdate(String hql, Object[] paramArr) throws DAOException;

	/**
	 * 初始化
	 * @param obj
	 * @throws DAOException
	 */
	public abstract <T extends Entity2> void initialize(T entity) throws DAOException;

	   /**
     * 执行原生SQL查询,不分页，不带查询参数
     * @param sql:原生SQL语句
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSql(String sql) throws DAOException;
    
    /**
     * 执行原生SQL查询,带一个查询参数
     * @param sql 语句
     * @param param  参数
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSql(String sql,Object param) throws DAOException;
    
    /**
     * 执行原生SQL查询,可带多个参数
     * @param sql 语句
     * @param paramList 参数列表
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSql(String sql,List paramList) throws DAOException;
    
    /**
     * 执行原生SQL查询,带分页
     * @param sql
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSqlPage(String sql,PageInfo pageInfo) throws DAOException;
    
    /**
     * 执行原生SQL查询，带一个参数，带分页
     * @param sql
     * @param param
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSqlPage(String sql,Object param, PageInfo pageInfo) throws DAOException;
    
    /**
     * 执行原生SQL查询，可带多个参数，带分页
     * @param sql
     * @param paramList
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public abstract List findByNativeSqlPage(String sql,List paramList, PageInfo pageInfo) throws DAOException;

    
    /**
     * 执行原生SQL查询,带分页
     * @param queryStr
     * @param getCountSql
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,PageInfo pageInfo,String getCountSql) throws DAOException;
    
    
    /**
     * 执行原生SQL查询，带一个参数，带分页
     * @param queryStr
     * @param getCountSql
     * @param param
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,Object param, PageInfo pageInfo,Object getCountParam,String getCountSql) throws DAOException;
    
    
    /**
     * 执行原生SQL查询，可带多个参数，带分页
     * @param queryStr
     * @param getCountSql
     * @param paramList
     * @param pageInfo
     * @return
     * @throws DAOException
     */
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,List paramList, PageInfo pageInfo,List getCountParamList,String getCountSql) throws DAOException;
    
    
	 //===截取前面的指定数量的记录
    
  //===截取前面的指定数量的记录
    @SuppressWarnings("unchecked")
    public List findByCount(String hql,int count) throws DAOException;
    
    /**
     * 查询指定数量前面的
     * @param hql  hql语句
     * @param param  参数
     * @param num  要查询的数量
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByCount(String hql,Object param,int num) throws DAOException;
    
    /**
     * 查询指定数量前面的
     * @param hql hql语句
     * @param paramArr  参数数组
     * @param num  要查询的数量
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByCount(String hql,Object[] paramArr,int num) throws DAOException;
    
    /**
     *  查询指定数量前面的
     * @param hql  hql语句
     * @param paramList  参数列表
     * @param num    要查询的数量
     * @return
     */
    @SuppressWarnings("unchecked")
    public abstract List findByCount(String hql,List paramList,int num) throws DAOException;
    
    /**
     * 锁对象
     * @param <T>
     * @param entity 要锁定的对象
     * @param lockMode
     * @throws DAOException
     */
    public abstract <T extends Entity2> void lock(T entity,LockMode lockMode) throws DAOException;
    
    /**
     * 锁对象
     * @param <T>
     * @param entityName 要锁定的对象名
     * @param entity 要锁定的对象
     * @param lockMode
     * @throws DAOException
     */
    public abstract <T extends Entity2> void lock(String entityName, T entity,LockMode lockMode) throws DAOException;

}
