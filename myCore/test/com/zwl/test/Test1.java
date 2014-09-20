package com.zwl.test;

import org.junit.Test;

import com.zwl.service.DestService;
import com.zwl.service.DestServiceImpl;
import com.zwlsoft.po.Country;

public class Test1
{
    @Test
    public void test1()
    {
//        Service<Country> service=new ServiceImpl<Country>();
        DestService service=new DestServiceImpl();
        System.out.println("service: "+service.getEntity(2));
    }
}
