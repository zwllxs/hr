package com.zwlsoft.service.dao4;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented  
@Retention(RetentionPolicy.RUNTIME)  
@Target(ElementType.FIELD)  
public @interface NotCloumn {
    /**
     * 默认为true,即为非字段
     * @return
     */
    boolean value() default true;
}
