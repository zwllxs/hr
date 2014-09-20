package com.zwlsoft.test;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.github.pagehelper.PageHelper;
import com.zwlsoft.po.Country;
import com.zwlsoft.service.CountryService;
import com.zwlsoft.service.dao4.MyIbatisBaseDao;
import com.zwlsoft.service.impl.CountryServiceImpl;

public class DaoTest
{
    private ApplicationContext context;
    private CountryService countryService;

    @Before
    public void init()
    {
        context = new ClassPathXmlApplicationContext(
                new String[] { "conf/spring/app*.xml" });

        countryService = (CountryService) context.getBean("countryService");
    }

    @Test
    public void test()
    {

        // MyIbatisBaseDao dao =
        // (MyIbatisBaseDao)context.getBean("myIbatisBaseDao") ;
        // System.out.println("dao: "+dao);
        // IBaseGenericDAO<Country> dao=new IBaseGenericDAO<Country>();
        // MyIbatisBaseDao<Country> dao=new MyIbatisBaseDao<Country>();
        // List<Country> list= dao.selectList("selectAll");
        // System.out.println("list: "+list);

        PageHelper.startPage(1, 10);
        List<Country> countryList = countryService.selectList("selectAll");
        System.out.println("countryList: " + countryList.size());

        countryList = countryService.selectList("selectAll");
        System.out.println("countryList2: " + countryList.size());

    }

    @Test
    public void test2()
    {
        Country country = new Country();
        country.setCountryname("Co");
//        List<Country> countryList = countryService.selectList("selectByLike",
//                country);
//        System.out.println("countryList: "+countryList);
        
        
        List<Country> countryList2 = countryService.selectList("selectGreterThanId",
                2);
        System.out.println("countryList2: "+countryList2);
        
    }
    
    @Test
    public void test3()
    {
//        Country country = new Country();
//        country.setCountryname("Co");
//        List<Country> countryList = countryService.selectList("selectByLike",
//                country);
//        System.out.println("countryList: "+countryList);
        
        Map<String, Object> map=new HashMap<>();
        map.put("countryname", "Andorra");
        map.put("countrycode", "AD");
        map.put("id", 5);
        
        System.out.println("test3");
        Map<String, Object> map2=new HashMap<>();
        map2.put("params", map);
        List<Country> countryList2 = countryService.selectList("selectByMap",
                map2);
        System.out.println("countryList2: "+countryList2);
        
    }
    
    @Test
    public void testSelectDemo() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, IntrospectionException
    {
        Country country=new Country();
        country.setCountrycode("AI");
        country.setCountryname("Anguilla");
        country.setId(6);
        country.buildKeyValues();
        List<Country> countryList2 = countryService.selectList("selectByDemo",
                country);
        System.out.println("countryList2: "+countryList2);
    }
    
    @Test
    public void testBuildKeyValues() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, IntrospectionException
    {
        
        Country country=new Country();
        country.setCountrycode("AI");
//        country.setCountryname("Anguilla");
        country.setId(6);
        
        System.out.println("keyValuesMap: "+country.getKeyValuesMap());
        
        List<Country> countryList2 = countryService.selectList("selectByMap2",
                country);
        System.out.println("countryList2: "+countryList2);
    }

}
