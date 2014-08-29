package com.zwl.core.service.dao.constants;

/**
 * 错误信息常量,这里一般用于错误提示，因为很多错误提示类型都会比较固定，特定义此常量，根据需要，也可以做成数据字典或错误代码， 
 * @author zhangweilin
 *
 */
public class DaoErrorConstants
{
    /**
     * 保存失败
     */
    public static final String saveFailed="保存失败";
    
    /**
     * 保存或更新失败
     */
    public static final String saveOrUpdateFailed="保存或更新失败";
    
    /**
     * 批量保存或更新失败
     */
    public static final String saveOrUpdateBatFailed="批量保存或更新失败";
    
    /**
     * 更新失败
     */
    public static final String updateFailed="更新失败";
    
    /**
     * 删除失败
     */
    public static final String delFailed="删除失败";
    
    /**
     * 批量删除失败
     */
    public static final String delBatFailed="批量删除失败";
    
    /**
     * 登陆失败,请重试
     */
    public static final String loginFailed="登陆失败,请重试";
    
    /**
     * 非法操作
     */
    public static final String illegalOperation="非法操作";
    
    
//    =============
    
    /**
     * 获取所有失败
     */
    public static final String getAllFailed="获取所有失败";
    
    /**
     * 获取失败
     */
    public static final String getFailed="获取失败";
    
    /**
     * 查询失败
     */
    public static final String queryFailed="查询失败";
    
    /**
     * 按条件查询失败
     */
    public static final String queryByConditionFailed="按条件查询失败";
    
    
    /**
     * 按多条件查询失败
     */
    public static final String queryByComplexConditionFailed="按多条件查询失败";
    
    /** 
     * 数据库操作失败
     */
    public static final String dbOperatorFailed="数据库操作失败";
    
    /** 
     * 按条件操作数据库失败
     */
    public static final String dbOperatorConditionFailed="按条件操作数据库失败";
    
    /** 
     * 按多条件操作数据库失败
     */
    public static final String dbOperatorComplexConditionFailed="按多条件操作数据库失败";
    
    
    /** 
     * 初始化数据失败
     */
    public static final String initFailed="初始化数据失败";
    
    /** 
     * 通过本地sql查询失败
     */
    public static final String findByNativeSqlFailed="通过本地sql查询失败";
    
    /** 
     * 通过本地sql按条件查询失败
     */
    public static final String findByNativeSqlConditionFailed="通过本地sql按条件查询失败";
    
    /** 
     * 通过本地sql按复杂条件查询失败
     */
    public static final String findByNativeSqlComplexConditionFailed="通过本地sql按复杂条件查询失败";
    
    /** 
     * 按数量查询失败
     */
    public static final String findByCountFailed="按数量查询失败";
    
    /** 
     * 按条件和数量查询失败
     */
//    public static final String findByCountConditionFailed="按条件和数量查询失败";
    
    /** 
     * 按复杂条件和数量查询失败
     */
    public static final String findByCountComplexConditionFailed="按复杂条件和数量查询失败";
    
    /** 
     * 按复杂条件和数量查询失败
     */
    public static final String findByNamedParamFailed="按命名参数查询失败";
    
    /** 
     * 按复杂条件和数量查询失败
     */
    public static final String findByComplexConditionNamedParamFailed="按命名参数复杂条件查询失败";
    
}
