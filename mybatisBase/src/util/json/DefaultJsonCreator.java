package util.json;

import java.io.IOException;
import java.io.Writer;
import java.sql.Date;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import java.sql.Timestamp;

import util.page.IGenericPage;
/**
 * json创造者工具类
 * @author 赵士杰
 *
 */
@SuppressWarnings("unchecked")
public class DefaultJsonCreator implements IJsonCreator{
	
	
	public String doOutPage(IGenericPage page){
		Map resultMap = new HashMap(2);
		resultMap.put("totalSize", Integer.valueOf(page.getTotalCount()));
        List list = page.getThisPageElements();
        resultMap.put("list", list == null ? ((Object) (Collections.EMPTY_LIST)) : ((Object) (list)));
        resultMap.put("page", Integer.valueOf(page.getPageNo()));
        resultMap.put("totalPage", Integer.valueOf(page.getLastPageNo()));
        resultMap.put("success", Boolean.valueOf(true));
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		String result  = jsonObject.toString();
		return result;
		
	}
	
	
	public String doOutList(List list){
		int count = 0;
		if(list != null){
			count = list.size();
		}
		return doOutList(list ,count);
	}
	
	public String doOutList(List list, int totalCount){
		Map resultMap = new HashMap(2);
        resultMap.put("totalSize", Integer.valueOf(totalCount));
        resultMap.put("list", list == null ? ((Object) (Collections.EMPTY_LIST)) : ((Object) (list)));
        resultMap.put("success", Boolean.valueOf(true));
        JsonConfig jsonConfig = createJsonConfig();
        JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
        String result  = jsonObject.toString();
		return result;
	}
	
	
	
	public String doOutRecordBean(Object bean) {
		Map resultMap = new HashMap(2);
		resultMap.put("data", bean == null ? "" : bean);
		resultMap.put("success", Boolean.valueOf(true));
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		return jsonObject.toString();
	}
	
	
	public String doOutErrorMsg(String msg) {
		return doOutMsg(msg, null, false);
	}
	
	public String doOutString(String msg) {
		return msg;
	}
	
	
	public String doOutTreeNodes(List nodeList) {
        JsonConfig jsonConfig = createJsonConfig();
        JSONArray jsonArray = JSONArray.fromObject(nodeList, jsonConfig);
        return jsonArray.toString();
    }
	
	
	public String doOutSuccessMsg(String msg) {
		return doOutMsg(msg, null, true);
	}
	
	public String doOutSuccessMsg(String msg ,Object databean) {
		return doOutMsg(msg, databean, true);
	}
	
	public String doOutMsg(String msg, Object databean, boolean isSuccess) {
		Map resultMap = new HashMap(2);
		resultMap.put("success", Boolean.valueOf(isSuccess));
		resultMap.put("message", msg);
		Object beans = databean == null ? "" : databean;
		resultMap.put("data", beans);
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		String result = jsonObject.toString();
		return result;
	}
	
	//-------------------------------下面开始的方法直接写到客户端------------------------------------------------------------
	
	public void doOutPage(Writer writer ,IGenericPage page){
		Map resultMap = new HashMap(2);
		resultMap.put("totalSize", Integer.valueOf(page.getTotalCount()));
        List list = page.getThisPageElements();
        resultMap.put("list", list == null ? ((Object) (Collections.EMPTY_LIST)) : ((Object) (list)));
        resultMap.put("page", Integer.valueOf(page.getPageNo()));
        resultMap.put("totalPage", Integer.valueOf(page.getLastPageNo()));
        resultMap.put("success", Boolean.valueOf(true));
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		jsonObject.write(writer);
		
	}
	
	
	public void doOutList(Writer writer ,List list){
		int count = 0;
		if(list != null){
			count = list.size();
		}
		doOutList(writer ,list ,count);
	}
	
	public void doOutList(Writer writer ,List list, int totalCount){
		Map resultMap = new HashMap(2);
        resultMap.put("totalSize", Integer.valueOf(totalCount));
        resultMap.put("list", list == null ? ((Object) (Collections.EMPTY_LIST)) : ((Object) (list)));
        resultMap.put("success", Boolean.valueOf(true));
        JsonConfig jsonConfig = createJsonConfig();
        JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
        jsonObject.write(writer);
	}
	
	
	
	public void doOutRecordBean(Writer writer ,Object bean) {
		Map resultMap = new HashMap(2);
		resultMap.put("data", bean == null ? "" : bean);
		resultMap.put("success", Boolean.valueOf(true));
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		jsonObject.write(writer);
	}
	
	
	public void doOutErrorMsg(Writer writer ,String msg) {
		doOutMsg(writer ,msg, null, false);
	}
	
	public void doOutString(Writer writer ,String msg) {
		try {
			writer.write(msg);
		} catch (IOException e) {
		}
	}
	
	
	public void doOutTreeNodes(Writer writer ,List nodeList) {
        JsonConfig jsonConfig = createJsonConfig();
        JSONArray jsonArray = JSONArray.fromObject(nodeList, jsonConfig);
        jsonArray.write(writer);
    }
	
	
	public void doOutSuccessMsg(Writer writer ,String msg) {
		doOutMsg(writer ,msg, null, true);
	}
	
	public void doOutSuccessMsg(Writer writer ,String msg ,Object databean) {
		doOutMsg(writer ,msg, databean, true);
	}
	
	public void doOutMsg(Writer writer ,String msg, Object databean, boolean isSuccess) {
		Map resultMap = new HashMap(2);
		resultMap.put("success", Boolean.valueOf(isSuccess));
		resultMap.put("message", msg);
		Object beans = databean == null ? "" : databean;
		resultMap.put("data", beans);
		JsonConfig jsonConfig = createJsonConfig();
		JSONObject jsonObject = JSONObject.fromObject(resultMap, jsonConfig);
		jsonObject.write(writer);
	}
	
	 protected static JsonConfig createJsonConfig(String excludes[], String datePattern)
	    {
	        JsonConfig config = new JsonConfig();
	        if(excludes != null)
	        {
	            config.setExcludes(excludes);
	            config.setIgnoreDefaultExcludes(false);
	        }
	        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
	        config.registerJsonValueProcessor(Date.class, new util.json.DateJsonValueProcessor(datePattern));
	        config.registerJsonValueProcessor(Timestamp.class, new util.json.DateJsonValueProcessor(datePattern));
	        return config;
	    }
	
	 protected static JsonConfig createJsonConfig()
	  {
	    return createJsonConfig(null, "yyyy-MM-dd HH:mm:ss");
	  }

	  protected static JsonConfig createJsonConfig(String[] excludes)
	  {
	    return createJsonConfig(excludes, "yyyy-MM-dd HH:mm:ss");
	  }

	  protected static JsonConfig createJsonConfig(String datePattern)
	  {
	    return createJsonConfig(null, datePattern);
	  }

}
