package com.zwl.core.service.hqlbuilder;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zwl.core.service.builder.exception.BuildHqlException;
import com.zwl.core.service.vo.QueryVo;
import com.zwl.core.util.ServletUtil;
import com.zwl.core.util.StringUtil;


/**
 * 多条件复合查询工具类(此与request耦合了，暂时不管了)
 * @author zhangweilin
 *
 */
public class QueryBuilder
{
    protected final static transient Logger logger = LoggerFactory.getLogger(QueryBuilder.class);
    /**
     * 从request里提取数据，并将提取的数据构建成指定的数据格式，如一个QueryVo列表
     * @param request
     * @return
     * @throws BuildHqlException 
     */
    public static List<QueryVo> buildQueryVo(String desc)
    {
        HttpServletRequest request=ServletUtil.getRequest();
        logger.debug("特征串: "+desc);
        if (StringUtil.isInvalid(desc))
        {
            return null;
        }
        String voName=null;
        //解析出vo名
        int count=desc.indexOf(":");
        if (count!=-1)
        {
            voName=desc.substring(0,count);
            desc=desc.substring(count+1, desc.length());
        }
        else
        {
            throw new BuildHqlException("未知的协议");
        }

//        System.out.println("voName: "+voName);
//        System.out.println("desc: "+desc);
        
        String propertyName=null;
        int queryType=0;
        String tmp=null;
        List<QueryVo> queryVoList=new ArrayList<QueryVo>();
        
        //组织数据结构
        
//        String desc="userName-0,name-0,description-0,addTime1-3,lastLoginTime1-6-4-5,lastLoginTime2-6-4-5,status-1,addTime2-8-1,lastLoginTime-8-0";
        String[] descArr=desc.split(",");
        for (int i = 0; i < descArr.length; i++)
        {
            List<Integer> intList=null;
            QueryVo queryVo=new QueryVo();
            Pattern p=Pattern.compile("[\\w*\\.]*\\w*");
            Matcher matcher=p.matcher(descArr[i]);
            int index=0;
            while(matcher.find())
            {
//                index++;
                tmp=matcher.group().trim();
//                System.out.println("tmp:"+tmp); 
                if (!StringUtil.isInvalid(tmp))
                {
                    //解析第一段
                    if (index == 0)
                    {
                        propertyName = tmp;
                        if (StringUtil.illegalString(propertyName))
                        {
                            throw new BuildHqlException("严重警告：请不要非法操作！请去掉串："+descArr[i]);
                        }
                        logger.debug("提取到属性: "+propertyName);
                        queryVo.setPropertyName(propertyName);
                        index++;
                    }
                    //解析第二段
                    else if(1==index)
                    {   
                         try
                        {
                            queryType=Integer.valueOf(tmp);
                        }
                        catch (NumberFormatException e)
                        {
                            throw new BuildHqlException("非法查询类型: "+descArr[i],e);
                        }
//                         System.out.println("queryType: "+queryType+" tmp: "+tmp);
                         if (queryType>=QueryConstants.queryTypeList.size())
                        {
                             throw new BuildHqlException("查询类型不存在: 错误的串:"+descArr[i]);
                        }
                         queryVo.setQueryType(queryType);
                         index++;
                    }
                    
                    //解析第二段后面所有的，此段是做为参数列表,所以要验证此处的
                    else
                    {
                        if (null==intList)
                        {
                            intList=new ArrayList<Integer>();
                        }
                        intList.add(Integer.valueOf(tmp));
                        index++;
                    }
                }
            }
            
            String value=request.getParameter(voName+"."+queryVo.getPropertyName());
            Object value2=value;
            if (!StringUtil.isInvalid(value))
            {
                //如果是数字，则转换成整数
                if (value.matches("\\d+"))
                {
                    value2=Integer.parseInt(value);
                }
            }
            queryVo.setPropertyValue(value2);
            queryVo.setParamList(intList);
            
            //验证数据格式
            /*
             * 如果是between:
             *      后面只能是两个数字,并且检测到一个使用between的，就一定会后面紧跟一个，采用堆栈的方式验证
             * 如果是in:暂不验证
             * 如果是order:后面只能跟一个数字。并且值只能是1或者0,或者没有,1为desc,0或没设置则为asc
             *          (在生成order语句时，在生成第一个时，设置一个标记：标记为已有order字段，如果后面再有order时，读取此标记，就知道是否要加逗号)
             * 
             */
            
          //用来验证between是否前后匹配
            QueryVo betweenQueryVo=null;
            //验证
            switch (queryVo.getQueryType())
            {
                //between查询
                case QueryConstants.between:
                        if(null==queryVo.getParamList())
                        {
                             throw new BuildHqlException("between查询不能没有参数: 错误的串:"+descArr[i]);
                        }
                        else if (queryVo.getParamList().size()!=2)
                        {
                             throw new BuildHqlException("between查询参数个数不对: 错误的串:"+descArr[i]);
                        }
                        
                        if (null==betweenQueryVo)
                        {
                            betweenQueryVo=queryVo;
                        }
                        else
                        {
                            //此时比较betweenQueryVo和queryVo的paramList内容是否相等
                            if (!betweenQueryVo.getParamList().equals(queryVo.getParamList()))
                            {
                                throw new BuildHqlException("between查询前后不匹配: 错误的串:"+descArr[i]);
                            }
                            else
                            {
                                //此时between查询验证通过
                                betweenQueryVo=null;
                            }
                        }
                    break;
                    
                    //order查询
                case QueryConstants.order:
                    List<Integer> orderParamList=queryVo.getParamList();
                    if(null==orderParamList)
                    {
//                        throw new BuildHqlException("order查询不能没有参数: 错误的串:"+descArr[i]);
                        logger.warn(queryVo.getPropertyName()+"的order查询没有指定参数，系统自动使用正序查找");
                    }
                    //如果不为空,并且长度大于1
                    else if (orderParamList.size()!=1)
                    {
                        throw new BuildHqlException("order查询参数个数不对: 错误的串: "+descArr[i]);
                    }
                    else
                    {
                        Integer num=orderParamList.get(0);
                        if (!(num==0||num==1))
                        {
                           throw new BuildHqlException("order查询参数只能是0或者1,其中0代表asc,1代表desc: 错误的串:"+descArr[i]);
                        }
                    }
                    
                    break;

                default:
                    break;
            }
            queryVoList.add(queryVo);
        }
        return queryVoList;
    }
    
    
    /**
     * 将构建好的数据格式构建成hql语句
     * @param queryVoList
     */
    public static Object[] buildHql(List<QueryVo> queryVoList)
    {
        boolean isHaveOrder=false;//是否有order排序
        if (null==queryVoList)
        {
            return new Object[]{" 1 = 1 ",new ArrayList<Object>()};
        }
        QueryVo betweenQueryVo=null;
        boolean isOrdered=false;
        StringBuffer sb=new StringBuffer();
        List<Object> l=new ArrayList<Object>();
        for (int i = 0; i < queryVoList.size(); i++)  
        {
            QueryVo queryVo=queryVoList.get(i);  
            if(null==queryVo.getPropertyValue()&&queryVo.getQueryType()!=QueryConstants.order)
            {
                continue;
            }
            switch (queryVo.getQueryType())
            { 
                case QueryConstants.like:
                case QueryConstants.equals:
                case QueryConstants.lessThen:
                case QueryConstants.greaterThen:
                case QueryConstants.lessThenEquals:
                case QueryConstants.greaterThenEquals:
                    sb.append(" "+queryVo.getPropertyName()+" "+QueryConstants.queryTypeList.get(queryVo.getQueryType())+" ? and ");
                    if (queryVo.getQueryType()!=QueryConstants.like)
                    {
                        l.add(queryVo.getPropertyValue());
                    }
                    else
                    {
                        l.add("%" + queryVo.getPropertyValue() + "%");
                    }
                    
                    break;

                    //貌似此种情况，后两个参数可以省略掉
                case QueryConstants.between:
                    if(null==betweenQueryVo)
                    {
                        betweenQueryVo=queryVo;
                        sb.append(" "+queryVo.getPropertyName()+" "+QueryConstants.queryTypeList.get(queryVo.getQueryType())+" ? and ? and ");
                    }
                    else
                    {
                        l.add(betweenQueryVo.getPropertyValue());
                        l.add(queryVo.getPropertyValue());
                        betweenQueryVo=null;
                    }
                    break;
                    
                case QueryConstants.order:
                    isHaveOrder=true;
                    String orderType=null;
                    List<Integer> paramList=queryVo.getParamList();
                    //如果没有设置此参数，或者其参数为0，则表示是默认的排序方式，即asc
                    if (null==paramList||0==paramList.get(0))
                    {
                        orderType=" asc ";
                    }
                    //排序方式为desc
                    else if(1==paramList.get(0))
                    {
                        orderType=" desc ";
                    }
                    else
                    {
                        throw new BuildHqlException("排序查询参数错误:错误的串: "+queryVo.getPropertyName());
                    }
                    
                    //碰到第一个要order的
                    if (!isOrdered)
                    {
                        sb.append(" 1=1 "+QueryConstants.queryTypeList.get(queryVo.getQueryType())+" by "+queryVo.getPropertyName()+" "+orderType+" ");
                        isOrdered=true;
                    }
                    else
                    {
                        sb.append(", "+queryVo.getPropertyName()+" "+orderType+" ");
                    }
                    
                    break;
                default:
                    break;
            }
        }
        String hql=sb.toString().trim();
        if (!isHaveOrder&&!hql.endsWith("1=1"))
        {
            sb.append(" 1 = 1 ");
        }
        return new Object[] {sb.toString(),l};
    }
}
