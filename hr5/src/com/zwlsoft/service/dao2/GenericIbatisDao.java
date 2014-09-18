//package com.zwlsoft.service.dao2;
//import java.io.Serializable;
//import java.sql.SQLException;
//import java.util.List;
//
//import org.springframework.dao.DataAccessException;
//  
///** 
// * iBatis DAO层泛型基类，实现了基本的DAO功能 利用了Spring的DaoSupport功能 
// *  
// * @author wl 
// * @since 0.1 
// * @param <T> 
// *            实体类 
// * @param <PK> 
// *            主键类，必须实现Serializable接口 
// *  
// * @see com.thinkon.commons.dao.GenericDao 
// * @see org.springframework.orm.ibatis.support.SqlMapClientDaoSupport 
// */  
//public abstract class GenericIbatisDao<T, PK extends Serializable> extends  
//        SqlMapClientDaoSupport implements GenericDao<T, PK> {  
//  
//    // sqlmap.xml定义文件中对应的sqlid  
//    public static final String SQLID_INSERT = "insert";  
//    public static final String SQLID_UPDATE = "update";  
//    public static final String SQLID_UPDATE_PARAM = "updateParam";  
//    public static final String SQLID_DELETE = "delete";  
//    public static final String SQLID_DELETE_PARAM = "deleteParam";  
//    public static final String SQLID_TRUNCATE = "truncate";  
//    public static final String SQLID_SELECT = "select";  
//    public static final String SQLID_SELECT_PK = "selectPk";  
//    public static final String SQLID_SELECT_PARAM = "selectParam";  
//    public static final String SQLID_SELECT_FK = "selectFk";  
//    public static final String SQLID_COUNT = "count";  
//    public static final String SQLID_COUNT_PARAM = "countParam";  
//  
//    private String sqlmapNamespace = "";  
//  
//    /** 
//     * sqlmapNamespace，对应sqlmap.xml中的命名空间 
//     *  
//     * @return 
//     */  
//    public String getSqlmapNamespace() {  
//        return sqlmapNamespace;  
//    }  
//  
//    /** 
//     * sqlmapNamespace的设置方法，可以用于spring注入 
//     *  
//     * @param sqlmapNamespace 
//     */  
//    public void setSqlmapNamespace(String sqlmapNamespace) {  
//        this.sqlmapNamespace = sqlmapNamespace;  
//    }  
//  
//    /** 
//     * 数据库方言，缺省为MYSQL 
//     */  
//    private String dbDialect = "MYSQL";  
//  
//    /** 
//     * 数据库方言dbDialect的get方法 
//     *  
//     * @return 
//     */  
//    public String getDbDialect() {  
//        return dbDialect;  
//    }  
//  
//    /** 
//     * 数据库方言dbDialect的set方法 
//     *  
//     * @return 
//     */  
//    public void setDbDialect(String dbDialect) {  
//        if (dbDialect == null  
//                || (!dbDialect.equals("MYSQL") && !dbDialect.equals("ORACLE")))  
//            throw new DaoException("错误的数据库方言设置：本系统只支持MYSQL和ORACLE");  
//        this.dbDialect = dbDialect;  
//    }  
//  
//    public int count() {  
//        Integer count = (Integer) getSqlMapClientTemplate().queryForObject(  
//                sqlmapNamespace + "." + SQLID_COUNT);  
//        return count.intValue();  
//    }  
//  
//    public int count(DynamicSqlParameter param) {  
//        Integer count = (Integer) getSqlMapClientTemplate().queryForObject(  
//                sqlmapNamespace + "." + SQLID_COUNT_PARAM, param);  
//        return count.intValue();  
//    }  
//  
//    public int delete(PK primaryKey) {  
//        int rows = getSqlMapClientTemplate().delete(  
//                sqlmapNamespace + "." + SQLID_DELETE, primaryKey);  
//        try {  
//            getSqlMapClientTemplate().getSqlMapClient().startBatch();  
//        } catch (SQLException e) {  
//            // TODO Auto-generated catch block  
//            e.printStackTrace();  
//        }  
//        return rows;  
//    }  
//  
//    public int delete(DynamicSqlParameter param) {  
//        int rows = getSqlMapClientTemplate().delete(  
//                sqlmapNamespace + "." + SQLID_DELETE_PARAM, param);  
//        return rows;  
//    }  
//  
//    public int truncate() {  
//        int rows = getSqlMapClientTemplate().delete(  
//                sqlmapNamespace + "." + SQLID_TRUNCATE);  
//        return rows;  
//    }  
//  
//    public T get(PK primaryKey) {  
//        return (T) getSqlMapClientTemplate().queryForObject(  
//                sqlmapNamespace + "." + SQLID_SELECT_PK, primaryKey);  
//    }  
//  
//    public void insert(T entity) {  
//        getSqlMapClientTemplate().insert(sqlmapNamespace + "." + SQLID_INSERT,  
//                entity);  
//    }  
//  
//    public T load(PK primaryKey) throws DaoException {  
//        Object o = getSqlMapClientTemplate().queryForObject(  
//                sqlmapNamespace + "." + SQLID_SELECT_PK, primaryKey);  
//        if (o == null)  
//            throw new DataAccessException("数据查询异常：无法查询出主键数据");  
//        return (T) o;  
//    }  
//  
//    public List<T> select() {  
//        return getSqlMapClientTemplate().queryForList(  
//                sqlmapNamespace + "." + SQLID_SELECT);  
//    }  
//  
//    public List<T> select(DynamicSqlParameter param) {  
//        return getSqlMapClientTemplate().queryForList(  
//                sqlmapNamespace + "." + SQLID_SELECT_PARAM, param);  
//    }  
//  
//    public PaginationResult<T> selectPagination(DynamicSqlParameter param) {  
//        if (param != null)  
//            param.setDbDialect(this.dbDialect);  
//  
//        PaginationResult<T> result = new PaginationResult<T>();  
//        int count = count(param);  
//        result.setTotalSize(count);  
//        if (count > 0) {  
//            List<T> data = getSqlMapClientTemplate().queryForList(  
//                    sqlmapNamespace + "." + SQLID_SELECT_PARAM, param);  
//            result.setData(data);  
//        }  
//  
//        return result;  
//    }  
//  
//    public List<T> selectFk(DynamicSqlParameter param) {  
//        return getSqlMapClientTemplate().queryForList(  
//                sqlmapNamespace + "." + SQLID_SELECT_FK, param);  
//    }  
//  
//    public PaginationResult<T> selectFkPagination(DynamicSqlParameter param) {  
//        if (param != null)  
//            param.setDbDialect(this.dbDialect);  
//        PaginationResult<T> result = new PaginationResult<T>();  
//        int count = count(param);  
//        result.setTotalSize(count);  
//        if (count > 0) {  
//            List<T> data = getSqlMapClientTemplate().queryForList(  
//                    sqlmapNamespace + "." + SQLID_SELECT_FK, param);  
//            result.setData(data);  
//        }  
//  
//        return result;  
//    }  
//  
//    public int update(T entity) {  
//        return getSqlMapClientTemplate().update(  
//                sqlmapNamespace + "." + SQLID_UPDATE, entity);  
//    }  
//  
//    public int update(DynamicSqlParameter param) {  
//        if (param == null || param.getUpdateValueList() == null)  
//            throw new ParameterException(  
//                    "参数设置错误:使用带参数的update必须设定update的column！");  
//  
//        return getSqlMapClientTemplate().update(  
//                sqlmapNamespace + "." + SQLID_UPDATE_PARAM, param);  
//    }  
//  
//    public void batchInsert(final List<T> list){  
//        SqlMapClientCallback callback = new SqlMapClientCallback() {          
//            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {              
//                executor.startBatch();              
//                for (T member : list) {                  
//                    executor.insert(sqlmapNamespace + "." + SQLID_INSERT, member);              
//                }              
//                executor.executeBatch();              
//                return null;          
//            }      
//        };      
//        this.getSqlMapClientTemplate().execute(callback);      
//    }  
//  
//    public void batchUpdate(final List<T> list){  
//        SqlMapClientCallback callback = new SqlMapClientCallback() {          
//            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {              
//                executor.startBatch();              
//                for (T member : list) {                  
//                    executor.update(sqlmapNamespace + "." + SQLID_UPDATE, member);              
//                }              
//                executor.executeBatch();              
//                return null;          
//            }      
//        };      
//        this.getSqlMapClientTemplate().execute(callback);      
//    }  
//  
//    public void batchDelete(final List<PK> list){  
//        SqlMapClientCallback callback = new SqlMapClientCallback() {          
//            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {              
//                executor.startBatch();              
//                for (PK member : list) {                  
//                    executor.delete(sqlmapNamespace + "." + SQLID_DELETE, member);              
//                }              
//                executor.executeBatch();              
//                return null;          
//            }      
//        };      
//        this.getSqlMapClientTemplate().execute(callback);      
//    }  
//}  