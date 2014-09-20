package com.zwlsoft.test;

import java.lang.reflect.Field;

import org.junit.Test;

import com.zwlsoft.po.Country;
import com.zwlsoft.po.PayPayment;

public class Test1
{

    @Test
    public void test()
    {
        PayPayment payment=new PayPayment();
//        System.out.println("payment: "+payment.getAllMethodList());
        
        Country country=new Country();
        Field[] fieldArr=country.getFieldArr();
        for (int i = 0; i < fieldArr.length; i++)
        {
            System.out.println("name2: "+fieldArr[i].getName());
        }
//        System.out.println("\ncountry: "+country.getAllMethodList());
        
    }

}
