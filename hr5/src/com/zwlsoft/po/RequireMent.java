package com.zwlsoft.po;



/**
 * 需求
 * @author zhangweilin
 *
 */
public class RequireMent extends AbstractEntity
{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    private Integer id;
        
    /**
     * 姓名
     */
    private String name;
        
    /**
     * 邮件
     */
    private String email;
        
    /**
     * 电话
     */
    private String tel;
        
    /**
     * 项目名称
     */
    private String projectName;
        
    /**
     * 项目类型，枚举类型
     */
    private String projectType;
        
    /**
     * 项目预算
     */
    private Long budget;
        
    /**
     * 是否有硬件环境
     */
    private Boolean hasHardwareFlag;
        
    /**
     * 硬件环境配置描述
     */
    private String hardwareDesc;
        
    /**
     * 是否外网环境
     */
    private Boolean hasOutNetFlag;
        
    /**
     * 外网情况描述
     */
    private String outNetDesc;
        
    /**
     * 是否有局域网
     */
    private Boolean hasLanFlag;
        
    /**
     * 局域网情况描述
     */
    private String lanDesc;
        
    /**
     * 预计部署方式 1: 本地局域网部署 2:自己外网部署 3:SAAS模式部署
     */
    private String deployType;
        
    /**
     * 使用人数
     */
    private Integer peopleNum;
    
    /**
     * 项目描述
     */
    private String projectDesc;
    
    /**
     * 附件路径
     */
    private String attachment;

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getTel()
    {
        return tel;
    }

    public void setTel(String tel)
    {
        this.tel = tel;
    }

    public String getProjectName()
    {
        return projectName;
    }

    public void setProjectName(String projectName)
    {
        this.projectName = projectName;
    }

    public String getProjectType()
    {
        return projectType;
    }

    public void setProjectType(String projectType)
    {
        this.projectType = projectType;
    }

    public Long getBudget()
    {
        return budget;
    }

    public void setBudget(Long budget)
    {
        this.budget = budget;
    }

    public Boolean getHasHardwareFlag()
    {
        return hasHardwareFlag;
    }

    public void setHasHardwareFlag(Boolean hasHardwareFlag)
    {
        this.hasHardwareFlag = hasHardwareFlag;
    }

    public String getHardwareDesc()
    {
        return hardwareDesc;
    }

    public void setHardwareDesc(String hardwareDesc)
    {
        this.hardwareDesc = hardwareDesc;
    }

    public Boolean getHasOutNetFlag()
    {
        return hasOutNetFlag;
    }

    public void setHasOutNetFlag(Boolean hasOutNetFlag)
    {
        this.hasOutNetFlag = hasOutNetFlag;
    }

    public String getOutNetDesc()
    {
        return outNetDesc;
    }

    public void setOutNetDesc(String outNetDesc)
    {
        this.outNetDesc = outNetDesc;
    }

    public Boolean getHasLanFlag()
    {
        return hasLanFlag;
    }

    public void setHasLanFlag(Boolean hasLanFlag)
    {
        this.hasLanFlag = hasLanFlag;
    }

    public String getLanDesc()
    {
        return lanDesc;
    }

    public void setLanDesc(String lanDesc)
    {
        this.lanDesc = lanDesc;
    }

    public String getDeployType()
    {
        return deployType;
    }

    public void setDeployType(String deployType)
    {
        this.deployType = deployType;
    }

    public Integer getPeopleNum()
    {
        return peopleNum;
    }

    public void setPeopleNum(Integer peopleNum)
    {
        this.peopleNum = peopleNum;
    }

    public String getProjectDesc()
    {
        return projectDesc;
    }

    public void setProjectDesc(String projectDesc)
    {
        this.projectDesc = projectDesc;
    }

    public String getAttachment()
    {
        return attachment;
    }

    public void setAttachment(String attachment)
    {
        this.attachment = attachment;
    }
        
}
   