package util.json;

import java.io.Writer;
import java.util.List;

import util.page.IGenericPage;


/**
 * json创造者工具类
 * @author 赵士杰
 *
 */
@SuppressWarnings("unchecked")
public abstract interface IJsonCreator {
	
	
	/**
	 * 向客户端传输分页数据
	 * @param page
	 * @return
	 */
	public abstract String doOutPage(IGenericPage<Object> page);
	
	
	public abstract String doOutString(String msg);
	
	/**
	 * 向客户端传输单个数据
	 * @param bean
	 * @return
	 */
	public String doOutRecordBean(Object bean);
	
	
	/**
	 * 向客户端传输失败消息
	 * @param msg
	 * @return
	 */
	public String doOutErrorMsg(String msg);
	
	/**
	 * 向客户端传输成功消息
	 * @param msg
	 * @return
	 */
	public String doOutSuccessMsg(String msg);
	
	/**
	 * 向客户端传输成功消息（保存数据时使用）
	 * @param msg
	 * @param databean
	 * @return
	 */
	public String doOutSuccessMsg(String msg ,Object databean);
	
	/**
	 * 向客户端传输成功或失败消息  和 单个数据
	 * @param msg
	 * @param databean
	 * @param isSuccess
	 * @return
	 */
	public String doOutMsg(String msg, Object databean, boolean isSuccess);
	
	
	/**
	 * 向客户端传输多条数据
	 * @param list
	 * @param totalCount
	 * @return
	 */
	public String doOutList(List list, int totalCount);
	
	
	/**
	 * 向客户端传输多条数据
	 * @param list
	 * @return
	 */
	public String doOutList(List list);
	
	
	/**
	 * 向客户端传输TreeNodes数据
	 * @param nodeList
	 * @return
	 */
	public String doOutTreeNodes(List nodeList);
	
	
	//------------------下面开始的方法直接写到客户端---------------------------------------
	
	/**
	 * 向客户端传输分页数据
	 * @param page
	 * @return
	 */
	public abstract void doOutPage(Writer writer ,IGenericPage<Object> page);
	
	
	public abstract void doOutString(Writer writer ,String msg);
	
	/**
	 * 向客户端传输单个数据
	 * @param bean
	 * @return
	 */
	public void doOutRecordBean(Writer writer ,Object bean);
	
	
	/**
	 * 向客户端传输失败消息
	 * @param msg
	 * @return
	 */
	public void doOutErrorMsg(Writer writer ,String msg);
	
	/**
	 * 向客户端传输成功消息
	 * @param msg
	 * @return
	 */
	public void doOutSuccessMsg(Writer writer ,String msg);
	
	/**
	 * 向客户端传输成功消息（保存数据时使用）
	 * @param msg
	 * @param databean
	 * @return
	 */
	public void doOutSuccessMsg(Writer writer ,String msg ,Object databean);
	
	/**
	 * 向客户端传输成功或失败消息  和 单个数据
	 * @param msg
	 * @param databean
	 * @param isSuccess
	 * @return
	 */
	public void doOutMsg(Writer writer ,String msg, Object databean, boolean isSuccess);
	
	
	/**
	 * 向客户端传输多条数据
	 * @param list
	 * @param totalCount
	 * @return
	 */
	public void doOutList(Writer writer ,List list, int totalCount);
	
	
	/**
	 * 向客户端传输多条数据
	 * @param list
	 * @return
	 */
	public void doOutList(Writer writer ,List list);
	
	
	/**
	 * 向客户端传输TreeNodes数据
	 * @param nodeList
	 * @return
	 */
	public void doOutTreeNodes(Writer writer ,List nodeList);

}
