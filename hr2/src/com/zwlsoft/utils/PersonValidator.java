package com.zwlsoft.utils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.zwlsoft.bean.Person;
   
/**
 * 表单验证方式1
 * @author zhangweilin
 *
 */
public class PersonValidator implements Validator {  
   
    @Override  
    public boolean supports(Class<?> clazz) {  
       // TODO Auto-generated method stub  
       return Person.class.equals(clazz);  
    }  
   
    @Override  
    public void validate(Object target, Errors errors) {  
       // TODO Auto-generated method stub  
       ValidationUtils.rejectIfEmpty(errors, "name", null, "Name Is Empty名字不能为空");  
       ValidationUtils.rejectIfEmpty(errors, "age", null, "age Is Empty. 年龄不能为空");  
       ValidationUtils.rejectIfEmpty(errors, "introduction", null, "introduction Is Empty. 自我介绍不能为空");  
    }  
   
} 