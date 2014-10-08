package com.github.pagehelper.test;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.mapper.CountryMapper;
import com.github.pagehelper.model.Country;
import com.github.pagehelper.util.MybatisPageSizeZeroHelper;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.assertEquals;

/**
 * @author liuzh
 */
public class PageSizeZeroTest {

    /**
     * 使用Mapper接口调用时，使用PageHelper.startPage效果更好，不需要添加Mapper接口参数
     */
    @Test
    public void testWithStartPage() {
        SqlSession sqlSession = MybatisPageSizeZeroHelper.getSqlSession();
        CountryMapper countryMapper = sqlSession.getMapper(CountryMapper.class);
        try {
            System.out.println("第一步");
            //pageSize=0的时候查询全部结果
            PageHelper.startPage(1, 0);
            List<Country> list = countryMapper.selectAll();
            PageInfo page = new PageInfo(list);
            assertEquals(183, list.size());
            assertEquals(183, page.getTotalNum());
            
            System.out.println("第二步,以下不再调用");
            //pageSize=0的时候查询全部结果
            PageHelper.startPage(10, 0);
            list = countryMapper.selectAll();
            page = new PageInfo(list);
            assertEquals(183, list.size());
            assertEquals(183, page.getTotalNum());
            
            System.out.println("第三步");
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 使用Mapper接口调用时，使用PageHelper.startPage效果更好，不需要添加Mapper接口参数
     */
    @Test
    public void testWithRowbounds() {
        SqlSession sqlSession = MybatisPageSizeZeroHelper.getSqlSession();
        CountryMapper countryMapper = sqlSession.getMapper(CountryMapper.class);
        try {
            //pageSize=0的时候查询全部结果
            List<Country> list = countryMapper.selectAll(new RowBounds(1, 0));
            PageInfo page = new PageInfo(list);
            assertEquals(183, list.size());
            assertEquals(183, page.getTotalNum());

            //pageSize=0的时候查询全部结果
            PageHelper.startPage(10, 0);
            list = countryMapper.selectAll(new RowBounds(1000, 0));
            page = new PageInfo(list);
            assertEquals(183, list.size());
            assertEquals(183, page.getTotalNum());
        } finally {
            sqlSession.close();
        }
    }
}
