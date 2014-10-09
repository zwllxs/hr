package com.zwlsoft.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.zwlsoft.po.Country;
import com.zwlsoft.po.Country2;
import com.zwlsoft.po.RequireMent;
import com.zwlsoft.po.User;
import com.zwlsoft.service.CountryService;
import com.zwlsoft.service.RequireMentService;
import com.zwlsoft.service.UserService;
import com.zwlsoft.service.dao.MyIbatisBaseDao;

/**
 * DAO功能测试
 * 
 * @author zhangweilin
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:conf/spring/app*.xml" })
public class CrudTest
{
    @Autowired
    private ApplicationContext context;
    
    @Autowired
    private CountryService countryService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private RequireMentService requireMentService;
    
//    @Before
//    public void init()
//    {
//        context = new ClassPathXmlApplicationContext(
//                new String[] { "conf/spring/app*.xml" });
//
//        countryService = (CountryService) context.getBean("countryService");
//    }
    @Test
    public void testSave()
    {
        Country country = new Country();
        // country.setCountryCode("AI");
        country.setCountryName("Anguilla");
//        country.setId(33);
        country.putSignMap("id", "<");
        System.out.println("添加");
        countryService.save(country);
        
        if (true)
        {
            try
            {
                throw new Exception("test");
            }
            catch (Exception e)
            {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    @Test
    public void testInsert()
    {
        Country country = new Country();
        // country.setCountryCode("AI");
        country.setCountryName("BBBBB");
        countryService.insert("insert", country);
    }
    
    /**
     * 测试添加别的对象
     */
    @Test
    public void testInsert2()
    {
        Country2 country = new Country2();
        // country.setCountryCode("AI");
        country.setCountryName("DDD");
        country.setAutoSql(true);
        countryService.insert("insert2", country);
    }
    
    
    /**
     * 测试按id删除
     */
    @Test
    public void testDeleteById()
    {
        countryService.deleteById(12);
        
        Country country = new Country();
        country.setId(4);
        countryService.delete(MyIbatisBaseDao.CrudSqlId.deleteById.name(), country);
    }
    
    /**
     * 测试两种更新
     */
    @Test
    public void testUpdate()
    {
        //更新所有字段
        Country country = new Country();
        country.setId(5);
        country.setCountryName("张伟林");
        countryService.updateAllColumn(country);
        
        //更新选定的有值的字段
        Country country2 = new Country();
        country2.setId(6);
        country2.setCountryName("张伟林222");
        countryService.updateSelectedColumn(country2);
        
    }
    
    @Test
    public void testSelectOne()
    {
//        //暂时不支持只按id查,急待改进
        Country country0=countryService.selectById(6);
        System.out.println("country: "+country0);
//        
//        Country country=new Country();
//        country.setId(7);
//        Country country2=countryService.selectOne(MyIbatisBaseDao.CrudSqlId.selectById.name(), country);
//        System.out.println("country2: "+country2);
    }

    @Test
    public void testSelectList()
    {
        System.out.println("context: "+context);
        Country country=new Country();
        country.setId(7);
        country.setCountryName("A%");  //找A开头的
        country.putSignMap("id", ">");
        country.putSignMap("countryName", "like");
        
        PageHelper.startPage(2, 3);
        List<Country> countryList=countryService.selectListBySelected(country);
        System.out.println("countryList: "+countryList);
    }
    
    @Test
    public void testSelectByIds()
    {
        
        List<Country> countryList= countryService.selectByIds(1,3,4,6,7,8,9);
        System.out.println("countryList: "+countryList);
    }
    
    @Test
    public void testDeleteByIds()
    {
        
        int num=countryService.deleteByIds(1,3,4,6,7,8,9);
        System.out.println("num: "+num);
    }
    
    
    @Test
    public void testLogin()
    {
//        User users=new User("zhangweilin", "123456");
        User users=userService.login("zhangweilin", "123456");
        System.out.println("users "+users);
    }
    
    
    @Test
    public void testInsertRequirMent()
    {
        RequireMent requireMent=new RequireMent();
        requireMent.setProjectName("HR项目");
        requireMentService.save(requireMent);
    }
}
