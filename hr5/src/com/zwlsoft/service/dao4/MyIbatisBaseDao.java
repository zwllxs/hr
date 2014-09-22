package com.zwlsoft.service.dao4;

import java.beans.IntrospectionException;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.ibatis.session.RowBounds;

import com.zwlsoft.exception.UnsupportDataTypeException;
import com.zwlsoft.po.AbstractEntity;
import com.zwlsoft.po.Entity;
import com.zwlsoft.service.dao.SqlSessionTemplateDaoSupport;
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
//@Repository  //不能在此处创建实例，否则拿不到泛型class
//public class MyIbatisBaseDao<T>
//extends SqlSessionDaoSupport // implements IBaseGenericDAO<T>
//public class MyIbatisBaseDao<T> extends SqlSessionTemplateDaoSupport // implements IBaseGenericDAO<T>
public class MyIbatisBaseDao<T> extends SqlSessionTemplateDaoSupport implements IBaseGenericDAO<T>
{
    protected Class<T> clazz;  

    /**
     * SqlMapping命名空间
     */
    private String sqlNamespace;  
    
    public static final String SQLNAME_SEPARATOR = ".";

    public static final String SQL_SAVE = "save";
    public static final String SQL_UPDATE = "update";
    public static final String SQL_GETBYID = "getById";
    public static final String SQL_DELETEBYID = "deleteById";
    public static final String SQL_DELETEBYIDS = "deleteByIds";
//    public static final String SQL_FINDPAGEBY = "findPageBy";
//    public static final String SQL_FINDLISTBY = "findListBy";
//    public static final String SQL_GETCOUNTBY = "getCountBy";


    /** 不能用于SQL中的非法字符（主要用于排序字段名） */
    public static final String[] ILLEGAL_CHARS_FOR_SQL = { ",", ";", " ", "\"",
            "%" };
    
    public MyIbatisBaseDao()
    {
        Class entityClass =(Class)((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]; 
        sqlNamespace=entityClass.getName();
        System.out.println("sqlNamespace: "+sqlNamespace);
    }

    /**
     * 将SqlMapping命名空间与给定的SqlMapping名组合在一起。
     * 
     * @param sqlName
     *            SqlMapping名
     * @return 组合了SqlMapping命名空间后的完整SqlMapping名
     */
    public String getSqlName(String sqlName)
    {
        return sqlNamespace + SQLNAME_SEPARATOR + sqlName;
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

    /**
     * 生成主键值。 默认情况下什么也不做； 如果需要生成主键，需要由子类重写此方法根据需要的方式生成主键值。
     * 
     * @param ob
     *            要持久化的对象
     */
    public void generateId(T ob)
    {

    }

    /*
     * (non-Javadoc)
     * @see
     * com.harmony.framework.dao.mybatis.IBaseGenericDAO#save(java.lang.Object)
     */
    @Override
    public Integer save(T ob)
    {
        generateId(ob);
        return this.getSqlSession().insert(getSqlName(SQL_SAVE), ob);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.harmony.framework.dao.mybatis.IBaseGenericDAO#update(java.lang.Object
     * )
     */
    @Override
    public Integer update(T ob)
    {
        return this.getSqlSession().update(getSqlName(SQL_UPDATE), ob);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.harmony.framework.dao.mybatis.IBaseGenericDAO#getById(java.lang.String
     * )
     */
    @Override
    @SuppressWarnings("unchecked")
    public T getById(Serializable id)
    {
        return (T) this.getSqlSession().selectOne(getSqlName(SQL_GETBYID), id);
    }

    /*
     * (non-Javadoc)
     * @see com.harmony.framework.dao.mybatis.IBaseGenericDAO#deleteByIds(Serializable[])
     */
    @Override
    public Integer deleteByIds(Serializable[] ids)
    {
        return this.getSqlSession().delete(getSqlName(SQL_DELETEBYIDS), ids);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.harmony.framework.dao.mybatis.IBaseGenericDAO#deleteById(java.io.
     * Serializable)
     */
    @Override
    public Integer deleteById(Serializable id)
    {
        return this.getSqlSession().delete(getSqlName(SQL_DELETEBYID), id);
    }


    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#insert(java.lang.String, java.lang.Object)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @return 执行结果——插入成功的记录数
     * @see org.apache.ibatis.session.SqlSession#insert(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public int insert(String statement, Object parameter)
    {
        return this.getSqlSession().insert(getSqlName(statement), parameter);
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#insert(java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @return 执行结果——插入成功的记录数
     * @see org.apache.ibatis.session.SqlSession#insert(java.lang.String)
     */
    @Override
    public int insert(String statement)
    {
        return this.getSqlSession().insert(getSqlName(statement));
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#update(java.lang.String, java.lang.Object)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @return 执行结果——更新成功的记录数
     * @see org.apache.ibatis.session.SqlSession#update(java.lang.String,
     *      java.lang.Object)
     */
    @Override 
    public int update(String statement, Object parameter)
    {
        return this.getSqlSession().update(getSqlName(statement), parameter);
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#update(java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @return 执行结果——更新成功的记录数
     * @see org.apache.ibatis.session.SqlSession#update(java.lang.String)
     */
    @Override
    public int update(String statement)
    {
        return this.getSqlSession().update(getSqlName(statement));
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#delete(java.lang.String, java.lang.Object)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @return 执行结果——删除成功的记录数
     * @see org.apache.ibatis.session.SqlSession#delete(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public int delete(String statement, Object parameter)
    {
        return this.getSqlSession().delete(getSqlName(statement), parameter);
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#delete(java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @return 执行结果——删除成功的记录数
     * @see org.apache.ibatis.session.SqlSession#delete(java.lang.String)
     */
    @Override
    public int delete(String statement)
    {
        return this.getSqlSession().delete(getSqlName(statement));
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectList(java.lang.String, java.lang.Object)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param objParam
     *            参数
     * @return 查询结果列表
     * @see org.apache.ibatis.session.SqlSession#selectList(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public List<T> selectList(String statement, Object objParam)
    {
            return this.getSqlSession()
                    .selectList(getSqlName(statement), objParam);
    }
    
    @Override
    public List<T> selectListByExample(String statement, AbstractEntity abstractEntity)
    {
        try
        {
            //以下为map方式 生成动态语句 
//            Map<String, Object> map2=DaoUtil.getKeyValuesMap(abstractEntity);
//            map2.put(DaoConstant.keyValuesMapKey, DaoUtil.getStatementKeyValuesMap(abstractEntity));
//            return this.getSqlSession()
//                    .selectList(getSqlName(statement), map2);
            //以下为以list方式 生成动态语句的
            DaoUtil.setMyBatisType(abstractEntity);
            return this.getSqlSession()
                    .selectList(getSqlName(statement), abstractEntity);
        }
        catch (IllegalAccessException | IllegalArgumentException
                | InvocationTargetException | SecurityException | IntrospectionException
                | NoSuchMethodException | UnsupportDataTypeException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectList(java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @return 查询结果列表
     * @see org.apache.ibatis.session.SqlSession#selectList(java.lang.String)
     */
    @Override 
    public List<T> selectList(String statement)
    {
        return this.getSqlSession().selectList(getSqlName(statement));
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectOne(java.lang.String, java.lang.Object)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @return 查询结果对象
     * @see org.apache.ibatis.session.SqlSession#selectOne(java.lang.String,
     *      java.lang.Object)
     */
    @Override
    public Object selectOne(String statement, Object parameter)
    {
        return this.getSqlSession().selectOne(getSqlName(statement), parameter);
    }

    /**
     * 对{@link org.apache.ibatis.session.SqlSession#selectOne(java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @return 查询结果对象
     * @see org.apache.ibatis.session.SqlSession#selectOne(java.lang.String)
     */
    @Override
    public Object selectOne(String statement)
    {
        return this.getSqlSession().selectOne(getSqlName(statement));
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectMap(java.lang.String, java.lang.Object, java.lang.String, org.apache.ibatis.session.RowBounds)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @param mapKey
     *            数据mapKey
     * @param rowBounds
     *            用于分页查询的记录范围
     * @return 查询结果Map
     * @see org.apache.ibatis.session.SqlSession#selectMap(java.lang.String,
     *      java.lang.Object, java.lang.String,
     *      org.apache.ibatis.session.RowBounds)
     */
    @Override
    public Map selectMap(String statement, Object parameter, String mapKey,
            RowBounds rowBounds)
    {
        return this.getSqlSession().selectMap(getSqlName(statement), parameter,
                mapKey, rowBounds);
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectMap(java.lang.String, java.lang.Object, java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param parameter
     *            参数
     * @param mapKey
     *            数据mapKey
     * @return 查询结果Map
     * @see org.apache.ibatis.session.SqlSession#selectMap(java.lang.String,
     *      java.lang.Object, java.lang.String)
     */
    @Override
    public Map selectMap(String statement, Object parameter, String mapKey)
    {
        return this.getSqlSession().selectMap(getSqlName(statement), parameter,
                mapKey);
    }

    /**
     * 对
     * {@link org.apache.ibatis.session.SqlSession#selectMap(java.lang.String, java.lang.String)}
     * 的代理。 将statement包装了命名空间，方便DAO子类调用。
     * 
     * @param statement
     *            映射的语句ID
     * @param mapKey
     *            数据mapKey
     * @return 查询结果Map
     * @see org.apache.ibatis.session.SqlSession#selectMap(java.lang.String,
     *      java.lang.String)
     */
    @Override
    public Map selectMap(String statement, String mapKey)
    {
        return this.getSqlSession().selectMap(getSqlName(statement), mapKey);
    }
}
