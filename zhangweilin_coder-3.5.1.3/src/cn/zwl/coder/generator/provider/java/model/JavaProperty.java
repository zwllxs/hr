package cn.zwl.coder.generator.provider.java.model;

import java.beans.PropertyDescriptor;

import cn.zwl.coder.generator.util.ActionScriptDataTypesUtils;

public class JavaProperty {
	PropertyDescriptor propertyDescriptor;
	JavaClass clazz;
	public JavaProperty(PropertyDescriptor pd, JavaClass javaClass) {
		this.propertyDescriptor = pd;
		this.clazz = javaClass;
	}
	
	public String getName() {
		return propertyDescriptor.getName();
	}
	
	public String getJavaType() {
		return propertyDescriptor.getPropertyType().getName();
	}
	
	public String getAsType() {
		return ActionScriptDataTypesUtils.getPreferredAsType(propertyDescriptor.getPropertyType().getName());
	}

	public String toString() {
		return "JavaClass:"+clazz+" JavaProperty:"+getName();
	}
}