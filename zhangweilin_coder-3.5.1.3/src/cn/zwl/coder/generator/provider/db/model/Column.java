package cn.zwl.coder.generator.provider.db.model;



import cn.zwl.coder.generator.GeneratorProperties;
import cn.zwl.coder.generator.util.ActionScriptDataTypesUtils;
import cn.zwl.coder.generator.util.DatabaseDataTypesUtils;
import cn.zwl.coder.generator.util.GLogger;
import cn.zwl.coder.generator.util.JdbcType;
import cn.zwl.coder.generator.util.StringUtil;
import cn.zwl.coder.generator.util.TestDataGenerator;

/**
 * 列
 * @author zhangweilin
 *
 */
public class Column {
	/**
	 * Reference to the containing table
	 */
	private final Table _table;

	/**
	 * The java.sql.Types type
	 */
	private final int _sqlType;

	/**
	 * The sql typename. provided by JDBC driver
	 */
	private final String _sqlTypeName;

	/**
	 * The name of the column
	 */
	private final String _sqlName;

	/**
	 * True if the column is a primary key
	 */
	private boolean _isPk;

	/**
	 * True if the column is a foreign key
	 */
	private boolean _isFk;

	/**
	 * @todo-javadoc Describe the column
	 */
	private final int _size;

	/**
	 * @todo-javadoc Describe the column
	 */
	private final int _decimalDigits;

	/**
	 * True if the column is nullable
	 */
	private final boolean _isNullable;

	/**
	 * True if the column is indexed
	 */
	private final boolean _isIndexed;

	/**
	 * True if the column is unique
	 */
	private final boolean _isUnique;

	/**
	 * Null if the DB reports no default value
	 */
	private final String _defaultValue;
	
	/**
	 * The comments of column
	 */
	private final String _remarks;
	
	/**
	 * Get static reference to Log4J Logger
	 */

//	String description;
//
//	String humanName;
//
//	int order;
//
//	boolean isHtmlHidden;
//
//	String validateString;

	/**
	 * Describe what the DbColumn constructor does
	 * 
	 * @param table
	 *            Describe what the parameter does
	 * @param sqlType
	 *            Describe what the parameter does
	 * @param sqlTypeName
	 *            Describe what the parameter does
	 * @param sqlName
	 *            Describe what the parameter does
	 * @param size
	 *            Describe what the parameter does
	 * @param decimalDigits
	 *            Describe what the parameter does
	 * @param isPk
	 *            Describe what the parameter does
	 * @param isNullable
	 *            Describe what the parameter does
	 * @param isIndexed
	 *            Describe what the parameter does
	 * @param defaultValue
	 *            Describe what the parameter does
	 * @param isUnique
	 *            Describe what the parameter does
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for constructor
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for method parameter
	 */
	public Column(Table table, int sqlType, String sqlTypeName,
			String sqlName, int size, int decimalDigits, boolean isPk,
			boolean isNullable, boolean isIndexed, boolean isUnique,
			String defaultValue,String remarks) {
		_table = table;
		_sqlType = sqlType;
		_sqlName = sqlName;
		_sqlTypeName = sqlTypeName;
		_size = size;
		_decimalDigits = decimalDigits;
		_isPk = isPk;
		_isNullable = isNullable;
		_isIndexed = isIndexed;
		_isUnique = isUnique;
		_defaultValue = defaultValue;
		_remarks = remarks;
		
		GLogger.debug(sqlName + " isPk -> " + _isPk);

	}

	/**
	 * Gets the SqlType attribute of the Column object
	 * 
	 * @return The SqlType value
	 */
	public int getSqlType() {
		return _sqlType;
	}

	/**
	 * Gets the Table attribute of the DbColumn object
	 * 
	 * @return The Table value
	 */
	public Table getTable() {
//	    System.out.println("_table: "+_table);
		return _table;
	}

	/**
	 * Gets the Size attribute of the DbColumn object
	 * 
	 * @return The Size value
	 */
	public int getSize() {
		return _size;
	}

	/**
	 * Gets the DecimalDigits attribute of the DbColumn object
	 * 
	 * @return The DecimalDigits value
	 */
	public int getDecimalDigits() {
		return _decimalDigits;
	}

	/**
	 * Gets the SqlTypeName attribute of the Column object
	 * 
	 * @return The SqlTypeName value
	 */
	public String getSqlTypeName() {
		return _sqlTypeName;
	}

	/**
	 * Gets the SqlName attribute of the Column object
	 * 
	 * @return The SqlName value
	 */
	public String getSqlName() {
		return _sqlName;
	}

	public String getUnderscoreName() {
		return getSqlName().toLowerCase();
	}
	
	/**
	 * Gets the Pk attribute of the Column object
	 * 
	 * @return The Pk value
	 */
	public boolean isPk() {
	    return _isPk;
	}
	public Boolean getIsPK() {
	    //System.out.println("_isPk: "+_isPk);
		return _isPk;
	}   

	/**
	 * Gets the Fk attribute of the Column object
	 * 
	 * @return The Fk value
	 */
	public Boolean getIsFK() {
		return _isFk;
	}
//	public boolean isFk() {
//	    return _isFk;
//	}

	/**
	 * Gets the Nullable attribute of the Column object
	 * 
	 * @return The Nullable value
	 */
	public final boolean isNullable() {
		return _isNullable;
	}

	/**
	 * Gets the Indexed attribute of the DbColumn object
	 * 
	 * @return The Indexed value
	 */
	public final boolean isIndexed() {
		return _isIndexed;
	}

	/**
	 * Gets the Unique attribute of the DbColumn object
	 * 
	 * @return The Unique value
	 */
	public boolean isUnique() {
		return _isUnique;
	}

	/**
	 * Gets the DefaultValue attribute of the DbColumn object
	 * 
	 * @return The DefaultValue value
	 */
	public final String getDefaultValue() {
		return _defaultValue;
	}
	
	public final String getRemarks() {
		return _remarks;
	}
	
	/**
	 * 有些注释为"状态 0：停用 1：正常，"之类的，那么调用此方法即只返回"状态"两字
	 * @return
	 */
	public final String getRemarksFirst() 
	{
	    return getRemarks().replaceAll("\\s.*", "");
	}

	/**
	 * Describe what the method does
	 * 
	 * @return Describe the return value
	 * @todo-javadoc Write javadocs for method
	 * @todo-javadoc Write javadocs for return value
	 */
	public int hashCode() {
		return (getTable().getSqlName() + "#" + getSqlName()).hashCode();
	}

	/**
	 * Describe what the method does
	 * 
	 * @param o
	 *            Describe what the parameter does
	 * @return Describe the return value
	 * @todo-javadoc Write javadocs for method
	 * @todo-javadoc Write javadocs for method parameter
	 * @todo-javadoc Write javadocs for return value
	 */
	public boolean equals(Object o) {
		if(this == o) return true;
		if(o instanceof Column) {
			Column other = (Column)o;
			if(getSqlName().equals(other.getSqlName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Describe what the method does
	 * 
	 * @return Describe the return value
	 * @todo-javadoc Write javadocs for method
	 * @todo-javadoc Write javadocs for return value
	 */
	public String toString() {
		return getSqlName();
	}

	/**
	 * Describe what the method does
	 * 
	 * @return Describe the return value
	 * @todo-javadoc Write javadocs for method
	 * @todo-javadoc Write javadocs for return value
	 */
	protected final String prefsPrefix() {
		return "tables/" + getTable().getSqlName() + "/columns/" + getSqlName();
	}

	/**
	 * Sets the Pk attribute of the DbColumn object
	 * 
	 * @param flag
	 *            The new Pk value
	 */
	void setFk(boolean flag) {
		_isFk = flag;
	}
	
	public String getColumnName() {
		return StringUtil.makeAllWordFirstLetterUpperCase(StringUtil.toUnderscoreName(getSqlName()));
	}
	
	public String getColumnNameFirstLower() {
		return StringUtil.uncapitalize(getColumnName());
	}
	
	public String getColumnNameLowerCase() {
		return getColumnName().toLowerCase();
	}
	/**
	 * @deprecated use getColumnNameFirstLower() instead
	 */
	public String getColumnNameLower() {
		return getColumnNameFirstLower();
	}
	
	public String getJdbcSqlTypeName() {
		String result = JdbcType.getJdbcSqlTypeName(getSqlType());
		//if(result == null) throw new RuntimeException("jdbcSqlTypeName is null column:"+getSqlName()+" sqlType:"+getSqlType());
		return result;
	}
	
	public String getColumnAlias() {
		return StringUtil.emptyIf(getRemarks(), getColumnNameFirstLower());
	}
	
	public String getConstantName() {
		return StringUtil.toUnderscoreName(getSqlName()).toUpperCase();
	}
	
	public boolean getIsNotIdOrVersionField() {
		return !isPk();
	}
	
	public String getValidateString() {
		String result = getNoRequiredValidateString();
		if(!isNullable()) {
			result = "required " + result;
		}
		return result;
	}
	
	public String getNoRequiredValidateString() {
		String result = "";
		if(getSqlName().indexOf("mail") >= 0) {
			result += "validate-email ";
		}
		if(DatabaseDataTypesUtils.isFloatNumber(getSqlType(), getSize(), getDecimalDigits())) {
			result += "validate-number ";
		}
		if(DatabaseDataTypesUtils.isIntegerNumber(getSqlType(), getSize(), getDecimalDigits())) {
			result += "validate-integer ";
			if(getJavaType().indexOf("Short") >= 0) {
				result += "max-value-"+Short.MAX_VALUE;
			}else if(getJavaType().indexOf("Integer") >= 0) {
				result += "max-value-"+Integer.MAX_VALUE;
			}else if(getJavaType().indexOf("Byte") >= 0) {
				result += "max-value-"+Byte.MAX_VALUE;
			}
		}
//		if(DatabaseDataTypesUtils.isDate(getSqlType(), getSize(), getDecimalDigits())) {
//			result += "validate-date ";
//		}
		return result;
	}
	
	public boolean getIsStringColumn() {
		return DatabaseDataTypesUtils.isString(getSqlType(), getSize(), getDecimalDigits());
	}
	
	public boolean getIsDateTimeColumn() {
		return DatabaseDataTypesUtils.isDate(getSqlType(), getSize(), getDecimalDigits());
	}
	
	public boolean getIsNumberColumn() {
		return DatabaseDataTypesUtils.isFloatNumber(getSqlType(), getSize(), getDecimalDigits()) || DatabaseDataTypesUtils.isIntegerNumber(getSqlType(), getSize(), getDecimalDigits());
	}
	
	public boolean isHtmlHidden() {
		return isPk() && _table.isSingleId();
	}
	
	public String getJavaType() {
		String normalJdbcJavaType = DatabaseDataTypesUtils.getPreferredJavaType(getSqlType(), getSize(), getDecimalDigits());
//		System.out.println("normalJdbcJavaType: "+normalJdbcJavaType);
		return GeneratorProperties.getProperty("java_typemapping."+normalJdbcJavaType,normalJdbcJavaType).trim();
	}
	
	public String getAsType() {
		return ActionScriptDataTypesUtils.getPreferredAsType(getJavaType());
	}
	
	public String getTestData() {
		return new TestDataGenerator().getDBUnitTestData(getColumnName(),getJavaType(),getSize());
	}
}
