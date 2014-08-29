package com.zwl.core.service.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.zwl.core.page.PageInfo;
import com.zwl.core.po.Entity2;
import com.zwl.core.service.dao.constants.DaoErrorConstants;
import com.zwl.core.service.dao.exception.DAOException;


public class DaoImpl<Entity1> extends HibernateDaoSupport implements Dao<Entity1>
{
    protected final Logger logger = LoggerFactory.getLogger(getClass());
    private JdbcTemplate jdbcTemplate;
    
    public DaoImpl()
    {
    }
    
    /**
     * 获取hibernatetemplate
     * @return
     */
    @Override
    public HibernateTemplate getDaoHibernateTemplate()
    {
        return getHibernateTemplate();
    }
    
    /**
     * 获取session
     */
    public Session getDaoSession()
    {
        return getSession();
    }
    
    public JdbcTemplate getJdbcTemplate() 
    {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) 
    {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    @SuppressWarnings("unchecked")
    public <T extends Entity2> List<T> findAll(Class<T> clazz) throws DAOException
    {
        if(clazz == null)
        {
            throw new DAOException("查询参数 clazz 不能为 null ！");
        }
        try
        {
            logger.info("  clazz ========== " + clazz);
            return getHibernateTemplate().loadAll(clazz);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.getAllFailed, e);
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.getAllFailed,e);
        } 
    }

    @SuppressWarnings("unchecked")
    public <T extends Entity2> T get(Class<T> clazz, Serializable id) throws DAOException
    {
        if(clazz == null)
        {
            throw new DAOException("查询 参数 clazz 不能为 null ！");
        }
        try
        {
            return (T) getHibernateTemplate().get(clazz, id);
        }
        catch (DataAccessException e)
        {
//           logger.error(ErrorConstants.getFailed, e); 
            e.printStackTrace();
           throw new DAOException(DaoErrorConstants.getFailed,e);
        }
    }

    public <T extends Entity2> void save(T entity) throws DAOException
    {
        try
        {
            getHibernateTemplate().save(entity);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.saveFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.saveFailed,e);
        }
    }

    public <T extends Entity2> void update(T entity) throws DAOException
    {
        try
        {
            getHibernateTemplate().update(entity);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.updateFailed, e); 
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.updateFailed,e);
        }
    }

    public <T extends Entity2> void saveOrUpdate(T entity) throws DAOException
    {
        try
        {
            getHibernateTemplate().saveOrUpdate(entity);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.saveOrUpdateFailed, e); 
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.saveOrUpdateFailed,e);
        }
    }

    public <T extends Entity2> void delete(T entity) throws DAOException
    {
        try
        {
            getHibernateTemplate().delete(entity);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.delFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.delFailed,e);
        }
    }

    public <T extends Entity2> void delete(Collection<T> entitieColl) throws DAOException
    {
        try
        {
            getHibernateTemplate().deleteAll(entitieColl);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.delBatFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.delBatFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    public List find(String hql) throws DAOException
    {
        try
        {
            return getHibernateTemplate().find(hql);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.queryFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.queryFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    public List find(String hql, Object param) throws DAOException
    {
        try
        {
            return getHibernateTemplate().find(hql, param);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.queryByConditionFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.queryByConditionFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    public List find(String hql, Object[] paramArr) throws DAOException
    {
        try
        {
            return getHibernateTemplate().find(hql, paramArr);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.queryByComplexConditionFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.queryByComplexConditionFailed,e);
        }
    }
    
    @SuppressWarnings("unchecked")
    public List find(String hql, List paramList) throws DAOException
    {
//        System.out.println("find调用find2");
        return find(hql, paramList.toArray());
    }

    @SuppressWarnings("unchecked")
    public List findByPage(String hql, PageInfo pageInfo)
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(hql, ((Object[]) (null)), pageInfo,false);
        }
        else
        {
            return find(hql, ((Object[]) (null)));
        }
    }

    @SuppressWarnings("unchecked")
    public List findByPage(String hql, Object value, PageInfo pageInfo)
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(hql, new Object[] { value }, pageInfo,false);
        }
        else
        {
            return find(hql, new Object[] { value });
        }
    }

    @SuppressWarnings("unchecked")
    public List findByPageHqlOrSql(String hqlOrSql, Object[] values, PageInfo pageInfo,boolean isNativeSql)
    {
        Session session = getSession();
        String getCountSql=hqlOrSql;
        if (isNativeSql)
        {
//            getCountSql=hqlOrSql.replace("*", "count(*)");
            getCountSql=getCountSql.replaceAll("select.*from", "select count(*) from ");
        }
        else
        {
//            System.out.println("getCountSql: "+getCountSql);
            if (getCountSql.trim().startsWith("from"))
            {
                getCountSql = (new StringBuilder("select count(*) ")).append(getCountSql).toString();
            }
            else
            {
                getCountSql=getCountSql.replaceAll("select.*from", "select count(*) from ");
            }
        }
        Query query =null;
        query = getQuery(session, getCountSql,isNativeSql);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        /*
         * 流程：
         *  1:客户端传递每页最大值，得到perPageResult
         *  2:设置totalResult,
         *  3:通过perPageResult和totalResult,这样能直接计算出totalPage
         */
        pageInfo.setTotalSize(((Number) query.uniqueResult()).intValue());
        int page = pageInfo.getPageNo();
        if (page > pageInfo.getTotalPageNum())
        {
            page = pageInfo.getTotalPageNum();
        }
        if (page < 1)
        {
            page = 1;
        }
        pageInfo.setPageNo(page);
        query = getQuery(session, hqlOrSql,isNativeSql);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }
        return query.setFirstResult((page - 1) * pageInfo.getPerPageSize())
                .setMaxResults(pageInfo.getPerPageSize()).list();
    }
    
    private Query getQuery(Session session, String sql)
    {
        return session.createQuery(sql);
    }
    
    //可以创建原生sql和hql的查询Query对象
    private Query getQuery(Session session, String hql,boolean isNativeSql)
    {
        //创建原生sql
        if (isNativeSql)
        {
           return session.createSQLQuery(hql);
        }
        //创建hql
        else
        {
           return getQuery(session, hql);
        }
    }

    @SuppressWarnings("unchecked")
    public List findByPage(String hql, List paramList, PageInfo pageInfo)
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(hql, paramList.toArray(), pageInfo,false);
        }
        else
        {
            return find(hql, paramList.toArray());
        }
    }
    
    
    @SuppressWarnings("unchecked")
    private List findByPage(String queryStr, Object values[], PageInfo pageInfo,boolean isNativeSql,Object getCountValues[],String getCountSql)
    {
        return page(queryStr, values, pageInfo, isNativeSql ,getCountValues,getCountSql,2);
    }

    /**
     * 最底层分页查询
     * @param queryStr
     * @param values
     * @param pageInfo
     * @param isNativeSql  是否为本地sql查询
     * @param getCountSql  获取count的语句
     * @param getCountConditionIndex  使用哪个参数列表
     * @return
     */
    @SuppressWarnings("unchecked")
    private List page(String queryStr, Object[] values, PageInfo pageInfo, boolean isNativeSql,Object getCountValues[],String getCountSql,int getCountConditionIndex) throws DAOException
    {
        if (null==getCountSql)
        {
            throw new DAOException("getCountSql不能为空!");
        }
        
        Session session = getSession();
        Query query =null;
        query = getQuery(session, getCountSql,isNativeSql);
        Object[] valuesTmp=getCountConditionIndex==1?values:getCountValues;
        if (valuesTmp != null)
        {
            for (int i = 0; i < valuesTmp.length; i++)
            {
                query.setParameter(i, valuesTmp[i]);
            }
        }

        /*
         * 流程：
         *  1:客户端传递每页最大值，得到perPageResult
         *  2:设置totalResult,
         *  3:通过perPageResult和totalResult,这样能直接计算出totalPage
         */
        pageInfo.setTotalSize(((Number) query.uniqueResult()).intValue());
        int page = pageInfo.getPageNo();
//        if (page > pageInfo.getTotalPageNum())
//        {
//            page = pageInfo.getTotalPageNum();
//        }
//        if (page < 1)
//        {
//            page = 1;
//        }
//        pageInfo.setPageNo(page);
        query = getQuery(session, queryStr,isNativeSql);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }
        return query.setFirstResult((page - 1) * pageInfo.getPerPageSize())
                .setMaxResults(pageInfo.getPerPageSize()).list();
    }

    
    public Object findUnique(String hql)
    {
        return findUnique(hql, ((Object[]) (null)));
    }

    public Object findUnique(String hql, Object param)
    {
        return findUnique(hql, new Object[] { param });
    }

    public Object findUnique(String hql, Object[] paramArr)
    {
        Query query = getSession().createQuery(hql);
        if (paramArr != null)
        {
            for (int i = 0; i < paramArr.length; i++)
            {
                query.setParameter(i, paramArr[i]);
            }
        }
        return query.uniqueResult();
    }

    @SuppressWarnings("unchecked")
    public Object findUnique(String hql, List paramList)
    {
        return findUnique(hql, paramList.toArray());
    }

    public int bulkUpdate(String hql) throws DAOException
    {
        try
        {
            return getHibernateTemplate().bulkUpdate(hql);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.dbOperatorFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.dbOperatorFailed,e);
        }
    }

    public int bulkUpdate(String hql, Object param) throws DAOException
    {
        try
        {
            return getHibernateTemplate().bulkUpdate(hql, param);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.dbOperatorConditionFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.dbOperatorConditionFailed,e);
        }
    }

    public int bulkUpdate(String hql, Object[] paramArr) throws DAOException
    {
        try
        {
            return getHibernateTemplate().bulkUpdate(hql, paramArr);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.dbOperatorComplexConditionFailed, e); //$NON-NLS-1$
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.dbOperatorComplexConditionFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    public int bulkUpdate(String hql, List paramList)  throws DAOException
    {
        return bulkUpdate(hql, paramList.toArray());
    }

    public <T extends Entity2> void initialize(T entity)  throws DAOException
    {
        try
        {
            getHibernateTemplate().initialize(entity);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.initFailed, e);
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.initFailed, e);
        }
    }

    @SuppressWarnings("unchecked")
    public List findByNativeSql(String sql) throws DAOException
    {
        try
        {
            List list = getSession().createSQLQuery(sql).list();
            return list;
        }
        catch (HibernateException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByNativeSqlFailed,e);
        }
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSql(String sql,Object param) throws DAOException
    {
        try
        {
            List list = getSession().createSQLQuery(sql).setParameter(0, param).list();
            return list;
        }
        catch (HibernateException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByNativeSqlConditionFailed,e);
        }
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSql(String sql,Object[] paramArr) throws DAOException
    {
        try
        {
            Query query = getSession().createSQLQuery(sql);
            for (int i = 0; i < paramArr.length; i++)
            {
                query.setParameter(i, paramArr[i]);
            }
            
            return query.list();
        }
        catch (HibernateException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByNativeSqlComplexConditionFailed,e);
        }
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSql(String sql,List paramList) throws DAOException
    {
        return findByNativeSql(sql, paramList.toArray());
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String sql,PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(sql, ((Object[]) (null)), pageInfo,true);
        }
        else
        {
            return findByNativeSql(sql, ((Object[]) (null)));
        }
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String sql,Object param, PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(sql, new Object[] {param}, pageInfo,true);
        }
        else
        {
            return findByNativeSql(sql, new Object[] {param});
        }
    }
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String sql,List paramList, PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageHqlOrSql(sql, paramList.toArray(), pageInfo,true);
        }
        else
        {
            return findByNativeSql(sql, paramList);
        }
    }
    
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,PageInfo pageInfo,String getCountSql) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPage(queryStr,((Object[]) (null)), pageInfo,true,((Object[]) (null)),getCountSql);
        }
        else
        {
            return findByNativeSql(queryStr, ((Object[]) (null)));
        }
    }
    
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,Object param, PageInfo pageInfo,Object getCountParam,String getCountSql) throws DAOException
    {
        if (null==getCountParam)
        {
            throw new DAOException("单个参数不能为null");
        }
        
        if (null!=pageInfo)
        {
            return findByPage(queryStr, new Object[] {param}, pageInfo,true,new Object[] {getCountParam},getCountSql);
        }
        else
        {
            return findByNativeSql(queryStr, new Object[] {param});
        }
    }
    
    
    @SuppressWarnings("unchecked")
    public List findByNativeSqlPage(String queryStr,List paramList, PageInfo pageInfo,List getCountParamList,String getCountSql) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPage(queryStr, paramList.toArray(), pageInfo,true,getCountParamList==null?null:getCountParamList.toArray(),getCountSql);
        }
        else
        {
            return findByNativeSql(queryStr, paramList);
        }
    }
    //===截取前面的指定数量的记录
    @SuppressWarnings("unchecked")
    @Override
    public List findByCount(String hql,int count) throws DAOException
    {
        List list=null;
        try
        {
            int maxResults=this.getHibernateTemplate().getMaxResults();
            this.getHibernateTemplate().setMaxResults(count);
            list = this.getHibernateTemplate().find(hql);
            this.getHibernateTemplate().setMaxResults(maxResults);
        }
        catch (DataAccessException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByCountFailed,e);
        }
        return list;
    }
    
    
    @SuppressWarnings("unchecked")
    public List findByCount(String hql, Object param, int count) throws DAOException
    {
        return findByCount(hql,new Object[] {param},count);
    }

    @SuppressWarnings("unchecked")
    public List findByCount(String hql, Object[] paramArr, int count) throws DAOException
    {
        List list=null;
        try
        {
            list = null;
            Session session = getSession();
            Query query = session.createQuery(hql);
            if(paramArr != null)
            {
                for(int i = 0; i < paramArr.length; i++)
                {
                    query.setParameter(i, paramArr[i]);
                }
            }
            list=query.setFirstResult(0).setMaxResults(count).list();
        }
        catch (DataAccessResourceFailureException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByCountComplexConditionFailed,e);
        }
        catch (HibernateException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByCountComplexConditionFailed,e);
        }
        catch (IllegalStateException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByCountComplexConditionFailed,e);
        }
        return list;
    }

    @SuppressWarnings("unchecked")
    public List findByCount(String hql, List paramList, int count) throws DAOException
    {
        return findByCount(hql,paramList.toArray(),count);
    }

    /**
     * 批量新增或保对象
     * @param entityColl
     * @throws DataAccessException
     */
    @Override
    public <T extends Entity2> void saveOrUpdateAll(Collection<T> entityColl) throws DAOException
    {
        try
        {
            getHibernateTemplate().saveOrUpdateAll(entityColl);
        }
        catch (DataAccessException e)
        {
//            logger.error(ErrorConstants.saveOrUpdateBatFailed, e);
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.saveOrUpdateBatFailed,e);
        }  
    }

    @Override
    public <T extends Entity2> void lock(T entity, LockMode lockMode) throws DAOException
    {
        getHibernateTemplate().lock(entity, lockMode);
    }

    @Override
    public <T extends Entity2> void lock(String entityName, T entity, LockMode lockMode) throws DAOException
    {
        getHibernateTemplate().lock(entityName, entity, lockMode);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParam(String hql,String paramName, Object paramValue) throws DAOException
    {
        try
        {
            return getHibernateTemplate().findByNamedParam(hql, paramName, paramValue);
        }
        catch (DataAccessException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByNamedParamFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParam(String hql,String[] paramNameArr, Object[] paramValueArr) throws DAOException
    {
        try
        {
            return getHibernateTemplate().findByNamedParam(hql, paramNameArr, paramValueArr);
        }
        catch (DataAccessException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByComplexConditionNamedParamFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParam(String hql,List<String> paramNameList, List<Object> paramValueList) throws DAOException
    {
         
        try
        {
            return getHibernateTemplate().findByNamedParam(hql, paramNameList.toArray(new String[] {}), paramValueList.toArray());
        }
        catch (DataAccessException e)
        {
            e.printStackTrace();
            throw new DAOException(DaoErrorConstants.findByComplexConditionNamedParamFailed,e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParamPage(String hql, String paramName, Object paramValue, PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageNamedParamHqlOrSql(hql, new String[] { paramName }, new Object[] { paramValue }, pageInfo,false);
        }
        else
        {
            return findByNamedParam(hql, paramName, paramValue);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParamPage(String hql, String[] paramNameArr, Object[] paramValueArr, PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageNamedParamHqlOrSql(hql, paramNameArr,paramValueArr, pageInfo,false);
        }
        else
        {
            return findByNamedParam(hql, paramNameArr, paramValueArr);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByNamedParamPage(String hql, List<String> paramNameList, List<Object> paramValueList, PageInfo pageInfo) throws DAOException
    {
        if (null!=pageInfo)
        {
            return findByPageNamedParamHqlOrSql(hql, paramNameList.toArray(new String[] {}),paramValueList.toArray(), pageInfo,false);
        }
        else
        {
            return findByNamedParam(hql, paramNameList.toArray(new String[] {}),paramValueList.toArray());
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List findByPageNamedParamHqlOrSql(String hqlOrSql, String[] paramNameArr, Object[] paramValueArr, PageInfo pageInfo, boolean isNativeSql) throws DAOException
    {
        if (null==paramNameArr||null==paramValueArr)
        {
            throw new DAOException("命名分页查询，参数名与参数值不能为空");
        }
        else if(paramNameArr.length!=paramValueArr.length)
        {
            throw new DAOException("命名分页查询，参数名长度与参数值长度要相等");
        }
        
        Session session = getSession();
        String getCountSql=hqlOrSql;
        if (isNativeSql)
        {
//            getCountSql=hqlOrSql.replace("*", "count(*)");
            getCountSql=getCountSql.replaceAll("select.*from", "select count(*) from ");
        }
        else
        {
//            System.out.println("getCountSql: "+getCountSql);
            if (getCountSql.trim().startsWith("from"))
            {
                getCountSql = (new StringBuilder("select count(*) ")).append(getCountSql).toString();
            }
            else
            {
                getCountSql=getCountSql.replaceAll("select.*from", "select count(*) from ");
            }
        }
        
        Query query =null;
        query = getQuery(session, getCountSql,isNativeSql);
        if (paramNameArr != null)
        {
            for (int i = 0; i < paramNameArr.length; i++)
            {
                if (paramValueArr[i] instanceof Collection)
                {
                    query.setParameterList(paramNameArr[i], (Collection) paramValueArr[i]);
                }
                else if (paramValueArr[i] instanceof Object[])
                {
                    query.setParameterList(paramNameArr[i], (Collection) paramValueArr[i]);
                }
                else
                {
                    query.setParameter(paramNameArr[i], paramValueArr[i]);
                }
            }
        }

        /*
         * 流程：
         *  1:客户端传递每页最大值，得到perPageResult
         *  2:设置totalResult,
         *  3:通过perPageResult和totalResult,这样能直接计算出totalPage
         */
        
        pageInfo.setTotalSize(((Number) query.uniqueResult()).intValue());
        int page = pageInfo.getPageNo();
        if (page > pageInfo.getTotalPageNum())
        {
            page = pageInfo.getTotalPageNum();
        }
        if (page < 1)
        {
            page = 1;
        }
        pageInfo.setPageNo(page);
        query = getQuery(session, hqlOrSql,isNativeSql);
        if (paramNameArr != null)
        {
            for (int i = 0; i < paramNameArr.length; i++)
            {
                if (paramValueArr[i] instanceof Collection)
                {
                    query.setParameterList(paramNameArr[i], (Collection) paramValueArr[i]);
                }
                else if (paramValueArr[i] instanceof Object[])
                {
                    query.setParameterList(paramNameArr[i], (Collection) paramValueArr[i]);
                }
                else
                {
                    query.setParameter(paramNameArr[i], paramValueArr[i]);
                }
            }
        }
        return query.setFirstResult((page - 1) * pageInfo.getPerPageSize())
                .setMaxResults(pageInfo.getPerPageSize()).list();
    }
}
