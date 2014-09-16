package com.lvmama.vst.back;

public class BusinessException extends RuntimeException {
    /**
	 * 
	 */
	private static final long serialVersionUID = -3877531184268150162L;
	private String message;

	public BusinessException(String message,  String... paras){
		this.message = String.format(message, paras);
	}
	
	public BusinessException(String message){
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
