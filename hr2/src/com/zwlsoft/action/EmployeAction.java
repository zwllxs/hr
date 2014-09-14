package com.zwlsoft.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.zwlsoft.bean.Employe;
import com.zwlsoft.bean.User;
import com.zwlsoft.model.EmployeModel;
import com.zwlsoft.service.EmployeService;
import com.zwlsoft.utils.MethodUtil;
 
@Controller
public class EmployeAction extends MultiActionController{
	
	private final static Logger log= Logger.getLogger(EmployeAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private EmployeService<Employe> employeService; 
	
	// Feild start
	private List<Employe> employeList = null;
	private Employe employe = new Employe();

	
	/**
	 * 
	 * <br>
	 * <b>功能：</b>员工列表页面<br>
	 * <b>作者：</b>罗泽军<br>
	 * <b>日期：</b> Dec 8, 2011 <br>
	 * @return
	 */
	@RequestMapping("/employe/list") 
	public ModelAndView list(EmployeModel model){
		Map<String,Object> map =new HashMap<String,Object>();
		try{
			employeList = employeService.selectByModel(model);
			map.put("model",model);
			map.put("resultList",employeList);
		}catch(Exception e){
			log.error(e);
			e.printStackTrace();
			return new ModelAndView("error"); //访问WEB-INF/jsp/error.jsp
		}
		return new ModelAndView("employe/employeList",map); //访问WEB-INF/jsp/employe/employeList.jsp
	}

    
	/**
	 * 
	 * <br>
	 * <b>功能：</b>员工到添加员工信息页面<br>
	 * <b>作者：</b>罗泽军<br>
	 * <b>日期：</b> Dec 8, 2011 <br>
	 * @return
	 */
	@RequestMapping("/employe/toadd") 
	public ModelAndView toadd(Employe bean){
	    System.out.println("跳转");
		return new ModelAndView("employe/employeEdit"); //访问WEB-INF/jsp/employe/employeEdit.jsp
	}
	
	
	/**
	 * 
	 * <br>
	 * <b>功能：</b>员工到编辑员工信息页面<br>
	 * <b>作者：</b>罗泽军<br>
	 * <b>日期：</b> Dec 8, 2011 <br>
	 * @param ids 确保前提只能转成一个主键编号过来
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/employe/toedit") 
	public ModelAndView toedit(Long ids) throws Exception{
		Map<String,Object> map =new HashMap<String,Object>();
//		try{
			employe = employeService.selectById(ids);	
			System.out.println("employe: "+employe.getName());
			//如果记录为空则跳转到错误页面
//			if(employe == null){
//				return new ModelAndView("error"); //访问WEB-INF/jsp/error.jsp
//			}
			map.put("bean", employe);
//		}catch(Exception e){
//			log.error(e);
//			return new ModelAndView("error"); //访问WEB-INF/jsp/error.jsp
//		}
		return new ModelAndView("employe/employeEdit",map); //访问WEB-INF/jsp/employe/employeEdit.jsp
	}
	
	
	

	/**
	 *  如果是单个变量，可用值绑定方式
	 * <br>
	 * <b>功能：</b>保存员工页面<br>
	 * <b>作者：</b>罗泽军<br>
	 * <b>日期：</b> Dec 8, 2011 <br>
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/employe/save2") 
	public ModelAndView save(Employe bean,User user) throws Exception{
	    System.out.println("添加..");
	    System.out.println("bean.getName(): "+bean.getName());  //当多个实体有同名属性时，值容易冲突,咋办 
	    System.out.println("user.getName(): "+user.getName());
	    System.out.println("name2: "+bean.getName2());
	    System.out.println("getUserName: "+user.getUserName());
	    System.out.println("getRealName: "+user.getRealName());
	    System.out.println("getDesc: "+user.getDesc());
	    
	    
//		try{
			//判断Id主键是否为空，如果主键不叫Id，请改成你的主键属性名称
			if(bean.getId() != null && bean.getId()> 0){
				//id不为空修改
				employeService.updateBySelective(bean);
			}else{
				//设置主键
			    long id=MethodUtil.getInit().getLongId();
			    System.out.println("id: "+id);
				bean.setId(id);
				//id为空新增
				employeService.insert(bean);
			}
//		}catch(Exception e){
//			log.error(e);
//			return new ModelAndView("error"); //访问WEB-INF/jsp/error.jsp
//		}
		return  list(new EmployeModel());//调整到list页面
	}
	
	
	@RequestMapping("/employe/deletes") 
	public ModelAndView deletes(Long[] ids){
		try{
			employeService.delete(ids);
		}catch(Exception e){
			log.error(e);
			return new ModelAndView("error"); //访问WEB-INF/jsp/error.jsp
		}
		return  list(new EmployeModel());//调整到list页面
	}
	
	/**
	 * 
	 *<p>演示请求路径匹配
	 *description: 如果是返回字符串方式，则返回的直接的jsp名称,
	 *可以接受如 employe/111/addUser.do这样的地址
	 *
	 *</p>
	 *@param request
	 *@return
	 * @author ex_zhangwl
	 * @see
	 */
	@RequestMapping("/employe/*/addUser")
	public String test1(HttpServletRequest request)
	{
	    System.out.println("request: "+request);
	    System.out.println("id: "+request.getParameter("id"));
	    System.out.println("test1调用了");
	    return "ok";
	}
	
//善于匹配
//    @RequestMapping不但支持标准的URL，还支持Ant风格（即?、*和**的字符，参见3.3.2节的内容）的和带{xxx}占位符的URL。以下URL都是合法的：
//            /user/*/createUser
//                匹配/user/aaa/createUser、/user/bbb/createUser等URL。
//
//            /user/**/createUser
//                匹配/user/createUser、/user/aaa/bbb/createUser等URL。
//
//            /user/createUser??
//                匹配/user/createUseraa、/user/createUserbb等URL。
//
//            /user/{userId}
//                匹配user/123、user/abc等URL。
//
//            /user/**/{userId}
//                匹配user/aaa/bbb/123、user/aaa/456等URL。
//
//            company/{companyId}/user/{userId}/detail
//                匹配company/123/user/456/detail等的URL。
	
	//访问不到,({userId}不能有$,)
	@RequestMapping("/employe/${userId}")
	public String test2(@PathVariable("userId") String userId)
	{
	    System.out.println("userId: "+userId);
	    return "ok";
	}
	
	//访问得到,没加$,能访问到,open/test/222.do能访问到
	@RequestMapping("/test/{userId}")
	public String test3(@PathVariable("userId") String userId)
	{
	    System.out.println("userId1111: "+userId);
	    return "ok";
	}
//	
//	//访问不到,没加$,能访问到(注，请求地址不能有重复的规则的，否则干脆直接请求不到),变量名与@PathVariable中的参数也不一定要相同
//	@RequestMapping("/test4/{userId}")
//	public String test4(@PathVariable("userId") String name)
//	{
//	    System.out.println("name: "+name);
//	    return "ok";
//	}
	
	//没加$,能访问到(注，请求地址不能有重复的规则的，否则干脆直接请求不到),变量名与@PathVariable中的参数也不一定要相同
	@RequestMapping("/test4/{userId}")
	public ModelAndView test4(@PathVariable("userId") String name)
	{
	    System.out.println("name3333: "+name);
	    return new ModelAndView();
	}
	
	/**
	 * 如果路径中的表达式与@PathVariable中的参数不一致，则浏览器访问不到
	 * 如此处userId与userId2222不一致
	 *<p>
	 *description:
	 *</p>
	 *@param name
	 *@return
	 * @author ex_zhangwl
	 * @see
	 */
	@RequestMapping("/test5/{userId}")
	public String test5(@PathVariable("userId2222") String name)
	{ 
	    System.out.println("name: "+name); 
	    return "ok";
	}
	
	/**
	 * 
	 *<p>
	 *description:如果用了key=value这种方式，就没法再用@PathVariable方式了,否则访问不到,(此需要验证)
	 *如果指定了method为post,则只能接收post请求，如果用get方式请求，窗口报“HTTP Status 405 - Request method 'GET' not supported”
	 *</p>
	 *@param name
	 *@return
	 * @author ex_zhangwl
	 * @see
	 */
	@RequestMapping(value="/delete.do",method=RequestMethod.POST)
    public String test6(String name)
    {  
        System.out.println("name6: "+name); 
        return "ok";
    }
	
	//通过请求参数限定,（如果地址中不带name参数，则直接无法访问到）
	@RequestMapping(value="/add.do",params="name")
	public String test7(String name)
	{
	    System.out.println("name: "+name );
	    return "ok";
	}
	
//	关于参数限定
//    params和headers分别通过请求参数及报文头属性进行映射，它们支持简单的表达式，下面以params表达式为例说明，headers可以参照params进行理解之。
//    "param1"：表示请求必须包含名为param1的请求参数。
//    "!param1"：表示请求不能包含名为param1的请求参数。
//    "param1!=value1"：表示请求包含名为param1的请求参数，但其值不能为value1。
//    {"param1=value1","param2"}：请求必须包含名为param1和param2的两个请求参数，且param1参数的值必须为value1。

}
