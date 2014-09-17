package ${basepackage}.action;

import ${basepackage}.constants.ErrorConstants;

import ${basepackage}.action.base.${table.className}ActionBase;
import com.zwl.core.service.dao.exception.DAOException;

/**
 * ${table.remarks}Action
 * @author zhangweilin
 *
 */
public class ${table.className}Action extends ${table.className}ActionBase
{

    /**
     * 
     */
    private static final long serialVersionUID = 8543699062997892248L;

    
    /**
     * 添加或更新${table.remarks}
     */
    public String addOrUpdate${table.className}()
    {
        //有id值即更新.否则为添加
        addOrUpdatePath=getAddOrUpdateView(${table.className?uncap_first}.get${table.pkName?cap_first}());
        try
        {
            ${table.className?uncap_first}Service.saveOrUpdate(${table.className?uncap_first});
        }
        catch (DAOException e)
        {
           addActionError(ErrorConstants.saveOrUpdateFailed);
           addOrUpdatePath=failed;
        }
        return addOrUpdatePath;
    }
    
    /**
     * 加载${table.remarks}列表
     */
    public String load${table.className}List()
    {
//        loginLogList=loginLogService.loadLoginLogList(loginLogVo,pageInfo);
        ${table.className?uncap_first}List=${table.className?uncap_first}Service.loadList(desc, pageInfo);
        return SUCCESS;
    }
    

    /**
     * 编辑${table.remarks} 
     */
    public String edit${table.className}()
    {
        
        
        return SUCCESS;
    }
    

    /**
     * 加载单个${table.remarks}
     */
    public String load${table.className}()
    {   
//        lastRealPath=getLastPath();
        //看看此种重复验证是否能放到拦截器里
        if (!isValidId(${table.pkName}))
        {
            addActionError(ErrorConstants.illegalOperation);
            return error;
        }
        ${table.className?uncap_first}=${table.className?uncap_first}Service.getEntity(${table.pkName});
        return returnView(${table.className?uncap_first}, "找不到该对象");
    }
    
    /**
     * 删除单个${table.remarks}
     * @return
     */
    public String delete${table.className}()
    {
        try
        {
            ${table.className?uncap_first}Service.delete(${table.className?uncap_first});
        }
        catch (DAOException e)
        {
            //服务器错误
            addActionError(ErrorConstants.delFailed);
            return failed;
        }
        return SUCCESS;
    }
    
    /**
     * 批量删除${table.remarks}
     */
    public String delete${table.className}ByBat()
    {
        try
        { 
            ${table.className?uncap_first}Service.deleteByBat(toDelBat,false);
        }
        catch (DAOException e)
        {
             addActionError(ErrorConstants.delBatFailed);
             return failed;
        }
        return SUCCESS;
    }
}
