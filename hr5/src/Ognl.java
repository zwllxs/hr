import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.zwlsoft.service.dao4.DaoConstant;

public class Ognl
{
    public static boolean isNotBlank(Object o)
    {
        System.out.println("o: "+o);
        return true;
    }
    
    
    /**
     * 获取mybatis对应的type组成sql语句
     * @param keyValuesMap
     * @param key
     * @return
     */
    public static String getMybatisSqlValueType(Map<String, Map<String, String>> keyValuesMap,String key)
    {
//        System.out.println("keyValuesMap: "+keyValuesMap);
        Map<String, String> mybatisSqlValueType=(Map<String, String>) keyValuesMap.get(key);
//        String columnName=mybatisSqlValueType.get("name");
        String jdbcTypeValue=mybatisSqlValueType.get(DaoConstant.typeKey);
//        System.out.println("key: "+key+",columnName: "+columnName+" , jdbcTypeValue: "+jdbcTypeValue);
        return jdbcTypeValue;
    }
    
    /**
     * 获取操作符号，比如= < >
     * @param signMap
     * @param key
     * @return
     */
    public static String getSignMap(Map<String, String> signMap,String key)
    {
        String signValue=signMap.get(key);
//        System.out.println("signValue: "+signValue);
        return StringUtils.isEmpty(signValue)?"=":signValue;
    }
}
