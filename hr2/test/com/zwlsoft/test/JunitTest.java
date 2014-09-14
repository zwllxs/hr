package com.zwlsoft.test;

import org.apache.log4j.Logger;
import org.apache.xmlbeans.impl.tool.XSTCTester.TestCase;
import org.hibernate.validator.HibernateValidator;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zwlsoft.bean.Employe;
import com.zwlsoft.service.EmployeService;
import com.zwlsoft.utils.MethodUtil;
import com.zwlsoft.utils.SpringContextUtil;

/**
 * junit测试工具类， 咿呀网提供 www.yy606.com
 * @author Administrator
 *
 */
public class JunitTest extends TestCase {
    
	ApplicationContext context = new ClassPathXmlApplicationContext(
			new String[]{"conf/spring/*.xml"}); 
	
	public static Logger log = Logger.getLogger(JunitTest.class);
	EmployeService<Employe> employeService =  (EmployeService)SpringContextUtil.getBean("employeService") ;
	
	
	
	public void testInsert(){
		Employe employe = new Employe();
		employe.setId(MethodUtil.getInit().getLongId());//设置Id
		employe.setName("张三");
		employe.setSex(1);
		employe.setAge(10);
		employe.setRemark("www.yy606.com");
		try {
			employeService.insert(employe);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
//	
//	public void testUpdate(){
//		Employe employe = new Employe();
//		employe.setId(2012042909340978494L);//设置Id
//		employe.setName("张三-1");
//		employe.setSex(1);
//		employe.setAge(12);
//		employe.setRemark("www.yy606.com");
//		try {
//			//此方法会修改所有字段，如果bean的属性为null，也会将对应表字段改为null
//			employeService.update(employe);
//			//此方法，只修改bean不为空的属性
//			//employeService.updateBySelective(employe);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	/**
	 * 根据主键id查询
	 */
//	public void testSelectById() throws Exception{
//		Long id = 2012042909340978494L;
//		Employe employe = employeService.selectById(id);
//		System.out.println(employe.getId());
//		System.out.println(employe.getName());
//		System.out.println(employe.getAge());
//	}
//	
	/**
	 * 根据Map编号查询,跟下面Model查询效果一样，自己决定用什么方式
	 */
//	public void testSelectMap(){
//		Map map = new HashMap();
//		List<Employe> results= new ArrayList<Employe>();
//		Integer rowcount=0;//总记录数
//		try {
//			//设置查询条件
//			map.put("name", "张三-1");
//			map.put("age", 12);
//			//设置排序规则
//			map.put("orderCondition", "age asc,id desc");//排序多个字段，按,隔开
//			//设置分页
//			map.put("queryCondition", "limit 0,10"); //0,10条,mysql 语法 
//			results = employeService.selectByMap(map);
//			rowcount = employeService.selectByMapCount(map);
//			System.out.println("list总数："+results.size());
//			System.out.println("总记录："+rowcount);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

	
	
	/**
	 * 跟model查询,跟上面map查询效果一样的
	 */
//	public void testSelectModel(){
//		EmployeModel model = new EmployeModel();
//		List<Employe> results= new ArrayList<Employe>();
//		try {
//			//设置查询条件
//			model.setName("张三-1");
//		 	model.setAge(12);
//			//设置排序规则
//			model.getNavigate().setOrderField("age asc,id desc");//排序多个字段，按,隔开
//			//设置分页
//		//	model.getNavigate().setPageSize(5);//设置每页5条，默认10条数据
//		//	model.getNavigate().setPageId(1); //设置分页编号 ，第一页
//			results = employeService.selectByModel(model);
//			System.out.println("list总数:"+results.size());
//			System.out.println("总记录："+model.getNavigate().getRowCount()); //获取总条数
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

	/**
	 * 根据id删除
	 */
//	public void testDelete(){
//		try {
//			//删除记录两种方式，效果是一样的，
//			
////			Long ids[] = {1L,2L};
////			employeService.delete(ids); 
//			
//			employeService.delete(1L,2L);//根据id删除记录，多个id按,分割
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
}
