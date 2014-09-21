package com.zwlsoft.po;

import java.util.Date;

/**
 * 支付对象.
 * @author liwenzhan
 *
 */
public class PayPayment //extends AbstractEntity implements Serializable 
{
	/**
	 * 序列化ID.
	 */
	/**
	 * 
	 */
	private Long paymentId;
	/**
	 * 流水号.
	 */
    private String serial;
    /**
     * 业务类型(哪个业务类型(自由行/代售)).
     */
	private String bizType;
	/**
	 * 对象ID.
	 */
	private Long objectId;
	/**
	 * 对象类型(订单).
	 */
	private String objectType;
	/**
	 * 支付类型(正常支付/预授权).
	 */
	private String paymentType;
	/**
	 * 支付网关(渠道).
	 */
	private String paymentGateway;
	/**
	 * 支付金额.
	 */
	private Long amount;
	/**
	 * 支付状态(CREATE,PRE_SUCCESS,CANCEL,SUCCESS,FAIL).
	 */
	private String status;
	/**
	 * 回馈时间.
	 */
	private Date callbackTime;
	/**
	 * 支付回馈信息.
	 */
	private String callbackInfo;
	/**
	 * 创建时间.
	 */
	private Date createTime;
	/**
	 * 支付网关交易流水号.
	 */
	private String gatewayTradeNo;
	/**
	 * 汇付天下标注银行卡所在行.
	 */
	private String gateId;
	/**
	 * 发出去的交易流水号.
	 */
	private String paymentTradeNo;
	/**
	 * 退款的流水号(中行与招行的分期与支付网关交易流水号不一样，其它的一样).
	 */
	private String refundSerial;
	/**
	 * 是否已通知业务系统.
	 */
	private String notified;
	/**
	 * 操作人(SYSTEM/CSxxx/LVxxx).
	 */
	private String operator;
	/**
	 * 通知时间.
	 */
	private Date notifyTime;
	/**
	 * 原对象ID,当发生支付转移时使用
	 */
	private Long oriObjectId;
	
	 
}
