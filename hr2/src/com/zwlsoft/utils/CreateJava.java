//package com.zwlsoft.utils;
//
//import java.io.File;
//import java.util.HashMap;
//import java.util.Map;
//import java.util.ResourceBundle;
//
//
//
///**
// * <br>
// * <b>功能：</b>详细的功能描述<br>
// * <b>作者：</b>罗泽军<br>
// * <b>日期：</b> Dec 16, 2011 <br>
// * <b>更新者：</b><br>
// * <b>日期：</b> <br>
// * <b>更新内容：</b><br>
// */
//public class CreateJava {
//	private static ResourceBundle res = ResourceBundle.getBundle("DataSourceConfig");
//	private static String url= res.getString("gpt.url"); 
//	private static String username =  res.getString("gpt.username");
//	private static String passWord = res.getString("gpt.password");
//
//
//	public static void main(String[] args) {
//		 CreateBean createBean=new CreateBean();
//		 createBean.setMysqlInfo(url, username, passWord);
//		 /** 此处修改成你的 表名 和 中文注释***/
//		 String tableName="employe"; //表名
//		 String codeName ="员工";//中文注释  当然你用英文也是可以的 
//		 String className= createBean.getTablesNameToClassName(tableName);
//		 String lowerName =className.substring(0, 1).toLowerCase()+className.substring(1, className.length());
//		 
//		 //项目跟路径路径，此处修改为你的项目路径
//		 String rootPath = getRootPath();// "F:\\openwork\\open\\";
//
//		 //根路径
//		 String srcPath = rootPath + "src\\";
//		 //包路径
//		 String pckPath = rootPath + "src\\com\\wei\\ssi\\";
//		 //页面路径，放到WEB-INF下面是为了不让手动输入路径访问jsp页面，起到安全作用
//		 String webPath = rootPath + "WebRoot\\WEB-INF\\jsp\\"; 
//		 
//		 File file=new File(pckPath);
//		 //java,xml文件名称
//		 String modelPath = "model\\"+className+"Model.java";
//		 String beanPath =  "bean\\"+className+".java";
//		 String mapperPath = "mapper\\"+className+"Mapper.java";
//		 String servicePath = "service\\"+className+"Service.java";
//		 String controllerPath = "controller\\"+className+"Controller.java";
//		 String sqlMapperPath = "conf\\mybatis\\"+className+"Mapper.xml";
//		 String springPath="conf\\spring\\";
//		 String sqlMapPath="conf\\mybatis\\";
//		//jsp页面路径
//		 String pageEditPath = lowerName+"\\"+lowerName+"Edit.jsp";
//		 String pageListPath = lowerName+"\\"+lowerName+"List.jsp";
//		 
//		
//		VelocityContext context = new VelocityContext();
//		context.put("className", className); //
//		context.put("lowerName", lowerName);
//		context.put("codeName", codeName);
//		context.put("tableName", tableName);
//		
//		/******************************生成bean字段*********************************/
//		try{
//			context.put("feilds",createBean.getBeanFeilds(tableName)); //生成bean
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//
//		/*******************************生成sql语句**********************************/
//		try{
//			Map<String,Object> sqlMap=createBean.getAutoCreateSql(tableName);
//			context.put("columnDatas",createBean.getColumnDatas(tableName)); //生成bean
//			context.put("SQL",sqlMap);
//		}catch(Exception e){
//			e.printStackTrace();
//			return;
//		}
//		
//		//-------------------生成文件代码---------------------/
//		CommonPageParser.WriterPage(context, "TempBean.java",pckPath, beanPath);  //生成实体Bean
//		CommonPageParser.WriterPage(context, "TempModel.java",pckPath,modelPath); //生成Model
//		CommonPageParser.WriterPage(context, "TempMapper.java", pckPath,mapperPath); //生成MybatisMapper接口 相当于Dao
//		CommonPageParser.WriterPage(context, "TempService.java", pckPath,servicePath);//生成Service
//		CommonPageParser.WriterPage(context, "TempMapper.xml",pckPath,sqlMapperPath);//生成Mybatis xml配置文件
//		CommonPageParser.WriterPage(context, "TempController.java",pckPath, controllerPath);//生成Controller 相当于接口
////		生JSP页面，如果不需要可以注释掉
////		CommonPageParser.WriterPage(context, "TempList.jsp",webPath, pageListPath);//生成Controller 相当于接口
////		CommonPageParser.WriterPage(context, "TempEdit.jsp",webPath, pageEditPath);//生成Controller 相当于接口
//
//		
//		/*************************修改xml文件*****************************/
//		WolfXmlUtil xml=new WolfXmlUtil();
//		Map<String,String> attrMap=new HashMap<String, String>();
//		try{
////		   /**  引入到 struts.xml  配置文件*/
////		   attrMap.put("file","com/wei/ssi/conf/struts2/struts2-ssi-"+lowerName+".xml");
////		   xml.getAddNode(srcPath+"struts.xml", "/struts", "include", attrMap, ""); 
////		   attrMap.clear();
////		   /**   引入到sqlmap-conf.xml 配置文件  */
////		   attrMap.put("resource", "com/wei/ssi/conf/sqlmap/"+className+"SQL.xml");
////		   xml.getAddNode(pckPath+sqlMapPath+"sqlmap-config.xml", "/sqlMapConfig", "sqlMap", attrMap, "");
////		   /**   引入到spring-dao.xml 配置文件 */
////		   attrMap.clear();
////		   attrMap.put("id", lowerName+"Dao");
////		   attrMap.put("class","com.wei.ssi.dao."+className+"Dao");
////		   xml.getAddNode(pckPath+springPath+"spring-dao.xml", "beans", "bean", attrMap, "");
////		   /**   引入到spring-service.xml 配置文件 */
////		   attrMap.clear();
////		   attrMap.put("id", lowerName+"Service");
////		   attrMap.put("class","com.wei.ssi.service."+className+"Service");
////		   xml.getAddNode(pckPath+springPath+"spring-service.xml", "beans", "bean", attrMap, "");
//
//		   /**   引入到mybatis-config.xml 配置文件 */
//			attrMap.clear();
//			attrMap.put("resource","com/wei/ssi/conf/mybatis/"+className+"Mapper.xml");
//		    xml.getAddNode(pckPath+sqlMapPath+"mybatis-config.xml", "/configuration/mappers", "mapper", attrMap, "");
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//	}
//	
//	
//	/**
//	 * 获取项目的路径
//	 * @return
//	 */
//	public static String getRootPath(){
//		String rootPath ="";
//		try{
//			 File file = new File(CommonPageParser.class.getResource("/").getFile());
//			 rootPath = file.getParentFile().getParentFile().getParent()+"\\";
//			 rootPath = java.net.URLDecoder.decode(rootPath,"utf-8");
//			 return rootPath;
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return rootPath;
//	}
//}
