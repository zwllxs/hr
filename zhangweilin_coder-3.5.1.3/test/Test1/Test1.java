package Test1;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;

import cn.zwl.coder.generator.util.StringUtil;

public class Test1
{

    @Test
    public void testString()
    {
        StringBuffer sb=new StringBuffer();
        String str = "admin_role_t";
        Pattern p = Pattern.compile("[a-zA-Z0-9]+[^[a-zA-Z0-9]$]"); // 不使用new
        Matcher m = p.matcher(str);
        m.reset();
        while (m.find())
        {
            sb.append(StringUtil.changFirstWord(m.group(),StringUtil.toUpperCase));
        }
        System.out.println("sb: "+sb.toString());
        
        System.out.println("路径: "+File.separatorChar);
        System.out.println("路径: "+File.separator);
        System.out.println("路径: "+File.pathSeparator);
        System.out.println("路径: "+File.pathSeparatorChar);
        
        System.out.println(0.05+0.01);   
    }

    /**
     * 
     */
    public void testPrintWriter()
    {
        
    }
}
