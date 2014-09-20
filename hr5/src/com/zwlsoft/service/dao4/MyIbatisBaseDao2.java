package com.zwlsoft.service.dao4;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.zwlsoft.service.dao.SqlSessionTemplateDaoSupport;


/**
 * 基于Mybatis的基础泛型DAO实现类。
 * 
 * @author 张伟林
 * @param <T>
 *            业务实体类型
 * @param <Serializable>
 *            ID类型 ，如：String、Long、Integer 等
 */
public abstract class MyIbatisBaseDao2<T>
        extends SqlSessionTemplateDaoSupport // implements IBaseGenericDAO<T>
{
    /**
     * 获取默认SqlMapping命名空间。 使用泛型参数中业务实体类型的全限定名作为默认的命名空间。
     * 如果实际应用中需要特殊的命名空间，可由子类重写该方法实现自己的命名空间规则。
     * 
     * @return 返回命名空间字符串
     */
    @SuppressWarnings("unchecked")
    public String getDefaultSqlNamespace()
    {
        Class<T> clazz = ReflectGeneric.getClassGenricType(this.getClass());
//        Class<T> clazz = ReflectGeneric.getClassGenricType(this.getClass());
        String nameSpace = clazz.getName();
        
//        Type sType = getClass().getGenericSuperclass();
////        Type[] generics = ((ParameterizedType) sType).getActualTypeArguments();
//        Type[] generics = ((ParameterizedType) sType).getActualTypeArguments();
//        Class<T> mTClass = (Class<T>) (generics[0]);
//        String nameSpace="";
//        System.out.println("mTClass: "+mTClass);
        return nameSpace;
    }

 
}
