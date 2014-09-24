package com.zwlsoft.service.dao;

import java.beans.IntrospectionException;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.lang.StringUtils;

import com.zwlsoft.po.AbstractEntity;
import com.zwlsoft.service.dao.exception.DAOException;
import com.zwlsoft.service.dao.exception.UnsupportDataTypeException;
import com.zwlsoft.utils.DaoUtil;

/**
 * 基于Mybatis的基础泛型DAO实现类。
 * 
 * @author 张伟林
 * @param <T>
 *            业务实体类型
 * @param <Serializable>
 *            ID类型 ，如：String、Long、Integer 等
 */
// @Repository //不能在此处创建实例，否则拿不到泛型class
// public class MyIbatisBaseDao<T>
// extends SqlSessionDaoSupport // implements IBaseGenericDAO<T>
// public class MyIbatisBaseDao<T> extends SqlSessionTemplateDaoSupport //
// implements IBaseGenericDAO<T>
@SuppressWarnings("rawtypes")
public class MyIbatisBaseDao<T> extends SqlSessionTemplateDaoSupport implements
        IBaseGenericDAO<T>
{
    protected Class<T> clazz;

    /**
     * SqlMapping命名空间
     */
    private String sqlNamespace;

    private static final String SQLNAME_SEPARATOR = ".";

    // ===以下要定义成枚举====
    public static enum CrudSqlId
    {
        insert("增加"), 
        deleteById("按id删除"), 
        deleteByIds("按id批量删除"), 
        updateSelectedColumnById("按id更新指定字段"), 
        updateAllColumnById("按id更新所有字段"), 
        selectListBySelected("按对象条件查列表"), 
        selectById("按id查单个"), 
        selectByIds("按多个id查");
        private String cnName;

        CrudSqlId(String name)
        {
            this.cnName = name;
        }

        public String getCode()
        {
            return this.name();
        }

        public String getCnName()
        {
            return this.cnName;
        }

        public static String getCnName(String code)
        {
            for (CrudSqlId item : CrudSqlId.values())
            {
                if (item.getCode().equals(code))
                {
                    return item.getCnName();
                }
            }
            return code;
        }

        @Override
        public String toString()
        {
            return "code:" + this.name() + ",cnName:" + this.cnName;
        }
    }
//    private static final String insert = "insert"; // 增加
//    private static final String deleteById = "deleteById"; // 按id删除
//    private static final String deleteByIds = "deleteByIds"; // 按id批量删除
//    private static final String updateSelectedColumnById = "updateSelectedColumnById"; // 按id更新指定字段
//    private static final String updateAllColumnById = "updateAllColumnById"; // 按id更新所有字段
//    private static final String selectListBySelected = "selectListBySelected"; // 按对象条件查列表
//    private static final String selectById = "selectById"; // 按id查单个
//    private static final String selectByIds = "selectByIds"; // 按多个id查

    /** 不能用于SQL中的非法字符（主要用于排序字段名） */
    public static final String[] ILLEGAL_CHARS_FOR_SQL = { ",", ";", " ", "\"",
            "%" };

    @SuppressWarnings("unchecked")
    public MyIbatisBaseDao()
    {
        clazz = (Class) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
        sqlNamespace = clazz.getName();
        System.out.println("sqlNamespace: " + sqlNamespace);
    }

    /**
     * 将SqlMapping命名空间与给定的SqlMapping名组合在一起。
     * 
     * @param sqlId
     *            SqlMapping名
     * @return 组合了SqlMapping命名空间后的完整SqlMapping名
     * @throws UnsupportDataTypeException 
     * @throws IntrospectionException 
     * @throws NoSuchMethodException 
     * @throws InvocationTargetException 
     * @throws IllegalArgumentException 
     * @throws IllegalAccessException 
     */
    public String getSqlId(Object obj,String sqlId) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, IntrospectionException, UnsupportDataTypeException
    {
        setMyBatisType(obj, sqlId);
        String sqlId2 = sqlNamespace + SQLNAME_SEPARATOR + sqlId;
        loger.info("执行sqlId: " + sqlId2);
        return sqlId2;
    }

    /**
     * 获取SqlMapping命名空间
     * 
     * @return SqlMapping命名空间
     */
    public String getSqlNamespace()
    {
        return sqlNamespace;
    }

    /**
     * 设置SqlMapping命名空间。 此方法只用于注入SqlMapping命名空间，以改变默认的SqlMapping命名空间，
     * 不能滥用此方法随意改变SqlMapping命名空间。
     * 
     * @param sqlNamespace
     *            SqlMapping命名空间
     */
    public void setSqlNamespace(String sqlNamespace)
    {
        this.sqlNamespace = sqlNamespace;
    }

    // /**
    // * 生成主键值。 默认情况下什么也不做； 如果需要生成主键，需要由子类重写此方法根据需要的方式生成主键值。
    // *
    // * @param ob
    // * 要持久化的对象
    // */
    // public void generateId(T ob)
    // {
    //
    // }

    /**
     * 
     * @param obj  如果该对象被设置过自动sql,即isAutoSql,则生成上下文环境
     * @param sqlId   如果sqlId是内置的几个，则生成上下文环境
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     * @throws NoSuchMethodException
     * @throws IntrospectionException
     * @throws UnsupportDataTypeException
     */
    private void setMyBatisType(Object obj,String sqlId) throws IllegalAccessException,
            IllegalArgumentException, InvocationTargetException,
            NoSuchMethodException, IntrospectionException,
            UnsupportDataTypeException
    {
        if (null==obj)
        {
            return ;
        }
        //如果是内置的sqlId,那么则设置上下文，即jdbcType等
        CrudSqlId[] crudSqlId=CrudSqlId.values();
        for (CrudSqlId crudType : crudSqlId)
        {
            if (sqlId.equals(crudType.name()))
            {
                // 拿到所有的
                DaoUtil.setMyBatisType(obj);
                break;
            }
        }
        //是否自动sql
        boolean isAutoSql = (boolean) MethodUtils.invokeMethod(obj, "isAutoSql", null);
        if (isAutoSql)
        {
         // 拿到所有的
            DaoUtil.setMyBatisType(obj);
        }
        
    }

    @Override
    public Integer save(T t)
    {
        // generateId(ob);
        try
        {

            return this.getSqlSession().insert(getSqlId(t,CrudSqlId.insert.name()), t);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("添加失败:t: " + t, e);
        }
    }

    @Override
    public Integer updateSelectedColumn(T t)
    {
        try
        {
//            DaoUtil.setMyBatisType(t);
            return this.getSqlSession().update(
                    getSqlId(t,CrudSqlId.updateSelectedColumnById.name()), t);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("更新失败:t: " + t, e);
        }
    }

    @Override
    public Integer updateAllColumn(T t)
    {
        try
        {
//            DaoUtil.setMyBatisType(t);
            return this.getSqlSession()
                    .update(getSqlId(t,CrudSqlId.updateAllColumnById.name()), t);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("更新失败:t: " + t, e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public T selectById(Serializable id)
    {
        try
        {
            T t=clazz.newInstance();
            MethodUtils.invokeMethod(t, "setId", id);
//            System.out.println("t: "+t);
            return (T) this.getSqlSession().selectOne(getSqlId(t,CrudSqlId.selectById.name()), t);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:id: " + id, e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> selectByIds(Serializable... ids)
    {
        try
        {
            //这种方式 不行，求解
//            T entity=clazz.newInstance();
//            MethodUtils.invokeMethod(entity, "setIds", ids);
            AbstractEntity entity=(AbstractEntity) clazz.newInstance(); 
            entity.setIds(ids);
            return (List<T>) this.getSqlSession().selectList(
                    getSqlId(entity,CrudSqlId.selectByIds.name()), entity);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:id: " + StringUtils.join(ids, ","), e);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> selectListBySelected(T t)
    {
        try
        {
            return (List<T>) this.getSqlSession().selectList(
                    getSqlId(t,CrudSqlId.selectListBySelected.name()), t);
        }
        catch (IllegalAccessException | IllegalArgumentException
                | InvocationTargetException | NoSuchMethodException
                | IntrospectionException | UnsupportDataTypeException e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:id: t" + t, e);
        }
    }

    /*
     * (non-Javadoc)
     * @see
     * com.harmony.framework.dao.mybatis.IBaseGenericDAO#deleteByIds(Serializable
     * [])
     */
    @Override
    public Integer deleteByIds(Serializable... ids)
    {
        try
        {
            return this.getSqlSession().delete(getSqlId(null,CrudSqlId.deleteByIds.name()), ids);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:id: " + StringUtils.join(ids, ","), e);
        }
    }

    @Override
    public Integer deleteById(Serializable id)
    {
        try
        {
            return this.getSqlSession().delete(getSqlId(null,CrudSqlId.deleteById.name()), id);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:id: " + id, e);
        }
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#insert(java.lang.String, java.lang.Object)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param paramObj
     *            参数
     * @return 执行结果——插入成功的记录数
     * @see org.apache.ibatis.session.SqlSession#insert(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public int insert(String sqlId, Object paramObj)
    {
        try
        {
            return this.getSqlSession().insert(getSqlId(paramObj,sqlId), paramObj);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("添加失败:sqlId: " + sqlId + " , paramObj: "
                    + paramObj, e);
        }
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#insert(java.lang.String)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @return 执行结果——插入成功的记录数
     * @see org.apache.ibatis.session.SqlSession#insert(java.lang.String)
     */
    @Override
    public int insert(String sqlId)
    {
        try
        {
            return this.getSqlSession().insert(getSqlId(null,sqlId));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("添加失败:sqlId: " + sqlId, e);
        }
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#update(java.lang.String, java.lang.Object)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param paramObj
     *            参数
     * @return 执行结果——更新成功的记录数
     * @see org.apache.ibatis.session.SqlSession#update(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public int update(String sqlId, Object paramObj)
    {
        try
        {
            return this.getSqlSession().update(getSqlId(paramObj,sqlId), paramObj);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("更新失败:sqlId: " + sqlId + " , paramObj: "
                    + paramObj, e);
        }
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#update(java.lang.String)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param paramObj
     *            参数
     * @return 执行结果——更新成功的记录数
     * @see org.apache.ibatis.session.SqlSession#update(java.lang.String)
     */
    @Override
    public int update(String sqlId)
    {
        try
        {
            return this.getSqlSession().update(getSqlId(null,sqlId));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("添加失败:sqlId: " + sqlId, e);
        }
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#delete(java.lang.String, java.lang.Object)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param paramObj
     *            参数
     * @return 执行结果——删除成功的记录数
     * @see org.apache.ibatis.session.SqlSession#delete(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public int delete(String sqlId, Object paramObj)
    {
        try
        {
            return this.getSqlSession().delete(getSqlId(paramObj,sqlId), paramObj);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("删除失败:sqlId: " + sqlId + " , paramObj: "
                    + paramObj, e);
        }
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#delete(java.lang.String)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @return 执行结果——删除成功的记录数
     * @see org.apache.ibatis.session.SqlSession#delete(java.lang.String)
     */
    @Override
    public int delete(String sqlId)
    {
        try
        {
            return this.getSqlSession().delete(getSqlId(null,sqlId));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("删除失败:sqlId: " + sqlId, e);
        }
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectList(java.lang.String, java.lang.Object)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param objParam
     *            参数
     * @return 查询结果列表
     * @see org.apache.ibatis.session.SqlSession#selectList(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public List<T> selectList(String sqlId, Object paramObj)
    {
        try
        {
            return this.getSqlSession().selectList(getSqlId(paramObj,sqlId), paramObj);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:sqlId: " + sqlId + " , paramObj: "
                    + paramObj, e);
        }
    }

    // @Override
    @Deprecated
    public List<T> selectListByExample(String sqlId,
            AbstractEntity abstractEntity)
    {
        try
        {
            // 以下为map方式 生成动态语句
            // Map<String, Object> map2=DaoUtil.getKeyValuesMap(abstractEntity);
            // map2.put(DaoConstant.keyValuesMapKey,
            // DaoUtil.getsqlIdKeyValuesMap(abstractEntity));
            // return this.getSqlSession()
            // .selectList(getSqlName(sqlId), map2);
            // 以下为以list方式 生成动态语句的
            DaoUtil.setMyBatisType(abstractEntity);
            return this.getSqlSession().selectList(getSqlId(abstractEntity,sqlId),
                    abstractEntity);
        }
        catch (IllegalAccessException | IllegalArgumentException
                | InvocationTargetException | SecurityException
                | IntrospectionException | NoSuchMethodException
                | UnsupportDataTypeException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectList(java.lang.String)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @return 查询结果列表
     * @see org.apache.ibatis.session.SqlSession#selectList(java.lang.String)
     */
    @Override
    public List<T> selectList(String sqlId)
    {
        try
        {
            return this.getSqlSession().selectList(getSqlId(null,sqlId));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:sqlId: " + sqlId, e);
        }
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectOne(java.lang.String, java.lang.Object)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @param paramObj
     *            参数
     * @return 查询结果对象
     * @see org.apache.ibatis.session.SqlSession#selectOne(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public T selectOne(String sqlId, Object paramObj)
    {
        try
        {
            return this.getSqlSession().selectOne(getSqlId(paramObj,sqlId), paramObj);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:sqlId: " + sqlId + " , paramObj: "
                    + paramObj, e);
        }
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#selectOne(java.lang.String)}
     * 的代理。 将sqlId包装了命名空间，方便DAO子类调用。
     * 
     * @param sqlId
     *            映射的语句ID
     * @return 查询结果对象
     * @see org.apache.ibatis.session.SqlSession#selectOne(java.lang.String)
     */
    @Override
    public T selectOne(String sqlId)
    {
        try
        {
            return this.getSqlSession().selectOne(getSqlId(null,sqlId));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new DAOException("查询失败:sqlId: " + sqlId, e);
        }
    }
}
