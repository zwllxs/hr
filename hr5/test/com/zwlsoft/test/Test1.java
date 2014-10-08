package com.zwlsoft.test;

import java.beans.IntrospectionException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.junit.Test;

import com.zwlsoft.po.Country;
import com.zwlsoft.po.PayPayment;
import com.zwlsoft.service.dao.exception.UnsupportDataTypeException;
import com.zwlsoft.utils.DaoUtil;

public class Test1
{

    @Test
    public void test()
    {
//        PayPayment payment = new PayPayment();
        // System.out.println("payment: "+payment.getAllMethodList());

        // Country country=new Country();
        // Field[] fieldArr=country.getFieldArr();
        // for (int i = 0; i < fieldArr.length; i++)
        // {
        // System.out.println("name2: "+fieldArr[i].getName());
        // }
        // System.out.println("\ncountry: "+country.getAllMethodList());
//        String[] strArr=new String[] {"23","4dfds","fghfd"};
//        List<String> strList=new ArrayList<>();
//        strList.add("ssd");
//        strList.add("ssd212");
//        strList.add("ssdfff");
//        
//        System.out.println("strArr: "+strArr);
//        System.out.println("strArr: "+StringUtils.join(strArr,","));
//        System.out.println("strList: "+StringUtils.join(strList,","));
        
//        String reg="^((?!hede).)*";
//        String reg="((?!hede).)*";
//        String reg="^(?!.*hello11)";
        String reg="^(?!.*?hello1).*$";
        System.out.println("是否匹配: "+"bhehello11eahedhe".matches(reg));
        
        String reg2="/admin/(^(?!.*?login).*$)";
        String str2="http://localhost:8080/hr5/admin/index.html";
        System.out.println("是否匹配2: "+str2.matches(reg2));
        
        String reg3="/(^(?!(.*admin.*)?login).*$)";
        String str3="http://localhost:8080/hr5/admin/login.html";
        System.out.println("是否匹配3: "+str3.matches(reg3));
        
        
    }

    @Test
    public void testDaoUtil() throws IllegalAccessException,
            InvocationTargetException, NoSuchMethodException
    {
        // DaoUtil.getAllFieldList(Road.class);
        System.out.println("testDaoUtil: ");
        // PayPayment payment=new PayPayment();
        Country country = new Country();
        country.setCountryCode("AI");
        // country.setCountryname("Anguilla");
        country.setId(6);
        Map<String, Object> map = BeanUtils.describe(country);
        System.out.println("map: " + map);

    }

    @Test
    public void testDaoUtil2()
    {
        Field[] fields = DaoUtil.getAllFieldList(Country.class);
        for (int i = 0; i < fields.length; i++)
        {
            System.out.println("field: " + fields[i].getName());
        }
        System.out.println("testDaoUtil: ");

    }
    
    @Test
    public void testDaoUtil3() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, IntrospectionException, NoSuchFieldException, SecurityException, UnsupportDataTypeException
    {
        Country country = new Country();
        country.setCountryCode("AI");
        country.setCountryName("Anguilla");
        country.setId(-2);
//        Map<String, Map<String, String>> map = DaoUtil.getKeyValuesMap(country);
         
//        System.out.println("map: "+map);
        
    }
    
    @Test
    public void testDaoUtil4() throws IllegalAccessException, InvocationTargetException, IntrospectionException
    {
        Country country = new Country();
        country.setCountryCode("AI");
        country.setCountryName("Anguilla");
        country.setId(-2);
//        Map<String, Object> map=BeanMapUtil.bean2Map(country);
//        System.out.println("map: "+map);
    }
    
    @Test
    public  void testStr()
    {
        String str="countryNameNameNameNameNameNameName".replaceAll("([a-z]+)?([A-Z][a-z]+)","$1_$2");
        System.out.println("str: "+str);
    }
    
    @Test
    public void testGetKeyValuesMap() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException, SecurityException, IntrospectionException, UnsupportDataTypeException
    {
        Country country=new Country();
        country.setCountryCode("AI");
//        country.setCountryname("Anguilla");
        country.setId(6);
        Map<String, Map<String, String>> map= DaoUtil.getStatementKeyValuesMap(country);
//        Map<String, String[]> map= DaoUtil.getKeyValuesMap(country);
        System.out.println("map: "+map);
    }

    @Test
    public void testType()
    {
         System.out.println("Integer.class.isPrimitive(): "+Integer.class.isPrimitive());
         System.out.println("int.class.isPrimitive(): "+int.class.isPrimitive());
         
         System.out.println("Integer.class: "+Integer.class);
         System.out.println("int.class: "+int.class);
         
         
         Country country=new Country();
         country.setCountryCode("AI");
//         country.setCountryname("Anguilla");
         country.setId(6);
         Field[] fields= DaoUtil.getAllFieldList(country);
         for (Field field : fields)
        {
             Class<?> clazz=field.getType();
             System.out.println("name: "+field.getName()+" type: "+clazz.getName()+",是否基础类型: "+clazz.isPrimitive());
        }
    }
}
