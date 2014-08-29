package com.zwl.core.service;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.Collection;
import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.zwl.core.page.PageInfo;
import com.zwl.core.po.Entity;
import com.zwl.core.po.Entity2;
import com.zwl.core.service.dao.Dao;
import com.zwl.core.service.dao.exception.DAOException;
import com.zwl.core.service.hqlbuilder.QueryBuilder;
import com.zwl.core.service.reflect.ServiceUtil;
import com.zwl.core.service.vo.QueryVo;
import com.zwl.core.util.StringUtil;


/**
 * service顶层实现
* ServiceImpl.java Create on 2011-5-8     
*      
* Copyright (c) 2011-5-8 by 天一     
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
* @param <Entity1>
*
 */
public class ServiceImpl<Entity1> implements Service<Entity1>
{
    protected final transient Logger logger = LoggerFactory.getLogger(getClass());

    protected Dao<Entity1> dao;

    @SuppressWarnings("unchecked")
    protected Class entityClass;
    
    @SuppressWarnings("unchecked")
    public ServiceImpl()
    {
        entityClass =(Class)((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]; 
    }
    
    
    @SuppressWarnings("unchecked")
    public <T extends Entity2> List<T> loadList(String desc,PageInfo pageInfo) throws DAOException
    {
//        desc="userName-0,name-0,description-0,addTime1-3,lastLoginTime1-6-4-5,lastLoginTime2-6-4-5,status-1,lastLoginTime1-6-4-5,lastLoginTime2-6-4-5,addTime2-8-1,lastLoginTime-8-0";
        /*
         * 步骤:
         * 1：验证个数与查询的个数
         * 2：将数据组织成一定的数据结构(属性名称,属性值,查询类型,查询参数(数组))
         * 4: 为每一种类型的查询建立一个匹配规则,
         * 5：每一个查询类型都有不同的规则，此时再逐个验证其规则,如验证-1-2-4-1是否合法
         * 6: 不同的查询类型，有不同的语句，如like和between，根据属性名称，查询类型和查询参数，构建查询语句
         * 7: 将语句汇总，返回完整语句
         */
        
//        String hql="from "+entityClass.getName()+" where ";
        StringBuffer sb=new StringBuffer();
        sb.append("from ").append(entityClass.getName()).append("  where  ");
        List<QueryVo> queryVoList =QueryBuilder.buildQueryVo(desc);
        //生成hql语句
        Object[] obj=QueryBuilder.buildHql(queryVoList);
        sb.append(obj[0]);
        
        logger.debug("查询: "+entityClass.getName()+" 生成hql: "+sb.toString());
        logger.debug("参数列表: "+obj[1]);
        return findByPage(sb.toString(), (List)obj[1], pageInfo);
    }

    @SuppressWarnings("unchecked")
    public <T extends Entity2> List<T> findAll() throws DAOException
    {
        if (isEntityClassNull())
        {
            return null;
        }
        else
        {
            return findAll(entityClass);
        }
    }

    
    /**
     * pageInfo 此参数用来分页,如果此为null,则表示不分页,直接和findAll()等到效
     */
    public <T extends Entity2> List<T> findByPage(PageInfo pageInfo) throws DAOException
    {
        if (isEntityClassNull())
        {
            return null;
        }
        else
        {
            return findByPage((new StringBuilder("from ")).append(
                        entityClass.getName()).toString(), pageInfo);
        }
    }

    public <T extends Entity2> List<T> findByPage(PageInfo pageInfo, String order) throws DAOException
    {
        if (isEntityClassNull())
        {
            return null;
        }
        else
        {
            return findByPage((new StringBuilder("from ")).append(
                    entityClass.getName()).append(" order by ").append(order)
                    .toString(), pageInfo);
        }
    }

    @SuppressWarnings("unchecked")
    public <T extends Entity2> T getEntity(Serializable id) throws DAOException
    {
        if (isEntityClassNull())
        {
            return null;
        }
        else
        {
            return (T) dao.get(entityClass,id);
        }
    }
    

    public <T extends Entity2> T getEntity(Class<T> clazz, Serializable id) throws DAOException
    {
        return dao.get(clazz,id);
    }

    
    private boolean isEntityClassNull()
    {
        if (entityClass == null)
        {
            logger.warn((new StringBuilder()).append(getClass()).append(
                    " entityClass is null...").toString());
            return true;
        }
        else
            return false;
    }

    public void setDao(Dao<Entity1> dao)
    {
        this.dao = dao;
    }

    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> void deleteByBat(String[] toDelBat, boolean isOneByOne) throws DAOException
    {
        if (isOneByOne)
        {
           List<Entity> l = null; 
           try
           {
               l = (List<Entity>) ServiceUtil.createList(toDelBat, entityClass);
           } 
           catch (Exception e)
           {
               throw new DAOException("批量删除参数不对 "+e);
           }
           delete(l);
        }
        else
        {
            String hql="delete from "+entityClass.getName()+" where id in ";
            bulkUpdate(hql+StringUtil.getSqlInSeq(toDelBat));
        }
   }


    //=======新加的==========
    
    @Override
    public int bulkUpdate(String hql) throws DAOException
    {
        return dao.bulkUpdate(hql);
    }


    @Override
    public int bulkUpdate(String hql, Object param) throws DAOException
    {
        return dao.bulkUpdate(hql, param);
    }


    @SuppressWarnings("unchecked")
    @Override
    public int bulkUpdate(String hql, List paramList) throws DAOException
    {
        return dao.bulkUpdate(hql, paramList);
    }


    @Override
    public int bulkUpdate(String hql, Object[] paramArr) throws DAOException
    {
        return dao.bulkUpdate(hql, paramArr);
    }


    @Override
    public <T extends Entity2> void delete(T entity) throws DAOException
    {
        dao.delete(entity);
    }


    @Override
    public <T extends Entity2> void delete(Collection<T> entityColl) throws DAOException
    {
        dao.delete(entityColl);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> find(String hql) throws DAOException
    {
        return (List<T>) dao.find(hql);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> find(String hql, Object param) throws DAOException
    {
        return (List<T>) dao.find(hql, param);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> find(String hql, Object[] paramArr) throws DAOException
    {
        return (List<T>) dao.find(hql, paramArr);
    }


    @SuppressWarnings("unchecked")
    @Override
    public  <T extends Entity2> List<T>  find(String hql, List paramList) throws DAOException
    {
//        System.out.println("Object转Entity");
        return (List<T>) dao.find(hql, paramList);
    }


    @Override
    public <T extends Entity2> List<T> findAll(Class<T> clazz) throws DAOException
    {
        return dao.findAll(clazz);
    }

    
    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByCount(String hql,int num) throws DAOException
    {
        return (List<T>) dao.findByCount(hql,num);
    }

    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByCount(String hql, Object param, int num) throws DAOException
    {
        return (List<T>) dao.findByCount(hql, param, num);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByCount(String hql, Object[] paramArr, int num) throws DAOException
    {
        return (List<T>) dao.findByCount(hql, paramArr, num);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByCount(String hql, List paramList, int num) throws DAOException
    {
        return (List<T>) dao.findByCount(hql, paramList, num);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSql(String sql) throws DAOException
    {
        return dao.findByNativeSql(sql);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSql(String sql, Object param) throws DAOException
    {
        return dao.findByNativeSql(sql, param);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSql(String sql, List paramList) throws DAOException
    {
        return dao.findByNativeSql(sql, paramList);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String sql, PageInfo pageInfo) throws DAOException
    {
        return dao.findByNativeSqlPage(sql, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String sql, Object param, PageInfo pageInfo) throws DAOException
    {
        return dao.findByNativeSqlPage(sql, param, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String sql, List paramList,PageInfo pageInfo) throws DAOException
    {
        return dao.findByNativeSqlPage(sql, paramList, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String queryStr, PageInfo pageInfo, String getCountSql) throws DAOException
    {
        return dao.findByNativeSqlPage(queryStr, pageInfo,getCountSql);
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String queryStr, Object param, PageInfo pageInfo,Object getCountParam,String getCountSql) throws DAOException
    {
        return dao.findByNativeSqlPage(queryStr, param, pageInfo,getCountParam, getCountSql);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByNativeSqlPage(String queryStr, List paramList, PageInfo pageInfo,List getCountParamList,  String getCountSql) throws DAOException
    {
        return dao.findByNativeSqlPage(queryStr, paramList, pageInfo,getCountParamList, getCountSql);
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByPage(String hql, PageInfo pageInfo) throws DAOException
    {
        return (List<T>) dao.findByPage(hql, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByPage(String hql, Object param, PageInfo pageInfo) throws DAOException
    {
        return (List<T>) dao.findByPage(hql, param, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByPage(String hql, List paramList, PageInfo pageInfo) throws DAOException
    {
        return (List<T>) dao.findByPage(hql, paramList, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List findByPageHqlOrSql(String hqlOrSql, Object[] paramArr, PageInfo pageInfo, boolean isNativeSql) throws DAOException
    {
        return dao.findByPageHqlOrSql(hqlOrSql, paramArr, pageInfo, isNativeSql);
    }


    @Override
    public Object findUnique(String hql, Object[] paramArr) throws DAOException
    {
        return dao.findUnique(hql, paramArr);
    }


    @Override
    public Object findUnique(String hql) throws DAOException
    {
        return dao.findUnique(hql);
    }


    @Override
    public Object findUnique(String hql, Object param) throws DAOException
    {
        return dao.findUnique(hql, param);
    }


    @SuppressWarnings("unchecked")
    @Override
    public Object findUnique(String hql, List paramList) throws DAOException
    {
        return dao.findUnique(hql, paramList);
    }

//
//    @SuppressWarnings("unchecked")
//    @Override
//    public <T extends Entity2> T get(Serializable serializable) throws DAOException
//    {
//        return dao.get(serializable);
//    }


    @Override
    public HibernateTemplate getDaoHibernateTemplate()
    {
        return dao.getDaoHibernateTemplate();
    }


    @Override
    public JdbcTemplate getJdbcTemplate()
    {
        return dao.getJdbcTemplate();
    }


    @Override
    public <T extends Entity2> void initialize(T entity) throws DAOException
    {
        dao.initialize(entity);
    }


    @Override
    public <T extends Entity2> void save(T entity) throws DAOException
    {
        dao.save(entity);
    }


    @Override
    public <T extends Entity2> void saveOrUpdate(T entity) throws DAOException
    {
        dao.saveOrUpdate(entity);
    }


    @Override
    public <T extends Entity2> void saveOrUpdateAll(Collection<T> entityColl) throws DAOException
    {
        dao.saveOrUpdateAll(entityColl);
    }


    @Override
    public <T extends Entity2> void update(T entity) throws DAOException
    {
        dao.update(entity);
    }
    

    @Override
    public <T extends Entity2> void lock(T entity, LockMode lockMode) throws DAOException
    {
        dao.lock(entity, lockMode);
    }

    @Override
    public <T extends Entity2> void lock(String entityName, T entity, LockMode lockMode) throws DAOException
    {
        dao.lock(entityName, entity, lockMode);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParam(String hql,String paramName, Object paramValue) throws DAOException
    {
        return (List<T>) dao.findByNamedParam(hql, paramName, paramValue);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParam(String hql,String[] paramNameArr, Object[] paramValueArr) throws DAOException
    {
        return (List<T>) dao.findByNamedParam(hql, paramNameArr, paramValueArr);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParam(String hql,List<String> paramNameList, List<Object> paramValueList)throws DAOException
    {
        return (List<T>) dao.findByNamedParam(hql, paramNameList, paramValueList);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParamPage(String hql, String paramName,Object paramValue, PageInfo pageInfo) throws DAOException
    {
        return (List<T>)dao.findByNamedParamPage(hql, paramName, paramValue, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParamPage(String hql, String[] paramNameArr,Object[] paramValueArr, PageInfo pageInfo) throws DAOException
    {
        return (List<T>)dao.findByNamedParamPage(hql, paramNameArr, paramValueArr, pageInfo);
    }


    @SuppressWarnings("unchecked")
    @Override
    public <T extends Entity2> List<T> findByNamedParamPage(String hql, List<String> paramNameList,List<Object> paramValueList, PageInfo pageInfo) throws DAOException
    {
        return (List<T>)dao.findByNamedParamPage(hql, paramNameList, paramValueList, pageInfo);
    }
}
