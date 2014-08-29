package com.zwl.core.util;

import java.util.HashMap;
import java.util.Map;

public class JsonUtil
{

    /**
     * 从json字符串中, 取得健值对Map,注意,此只适用于只有一级的json字符串
     * @param json
     * @return
     */
    public static Map<String, String> getKeyValueMap(String json)
    {
        String[] jsonArr = removeJsonTag(json);
        Map<String, String> map=new HashMap<String, String>();
        String[] bStringArr=null;
        
        for (int i = 0; i < jsonArr.length; i++)
        {
            bStringArr=jsonArr[i].split(":");
            if (bStringArr.length<2)
            {
                continue;
            }
            map.put(bStringArr[0], bStringArr[1]);
        }
        return map;
    }
    
    //剥掉引号和{}
    private static final String[] removeJsonTag(String json)
    {
        json=json.replace("'", "");
        json=json.replace("{", "");
        json=json.replace("}", "");
        
        String[] jsonArr=json.split(",");
        return jsonArr;
    }
}
