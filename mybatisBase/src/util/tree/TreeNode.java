package util.tree;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * treeNode对象 
 * @author 赵士杰
 *
 */
public class TreeNode implements Serializable{

	private static final long serialVersionUID = 1L;
	/**
	 * 节点唯一ID
	 */
	private String id;
	/**
	 * 节点是否被选中，默认为false 不选中，true为选中
	 */
	private boolean checked;
	/**
	 * 设定节点的自定义图标，以替换 css 样式中配置的普通图标。（设定时请注意指定图标的相对路径是否正确）
	 */
	private String icon;
	/**
	 * 设置某节点是否为父节点,true为父节点。当点击该节点时会触发异步获取子节点的事件
	 * 默认值：如果用户未设置该属性，则根据节点是否有子节点进行自动设置
	 */
	private boolean isParent;
	/**
	 * 节点名称
	 */
	private String name;
	/**
	 * 节点的Code值
	 */
	private String code;
	/**
	 * 子节点数据项
	 */
	private List<TreeNode> nodes = new ArrayList<TreeNode>();
	/**
	 * 设置有子节点的节点初始化展开状态。
	 * 对于不需要异步获取子节点信息的父节点有效
	 * 默认值：true
	 */
	private boolean open;
	/**
	 * 对于存在 url 属性的节点，点击后跳转的目标，同 超链接的 target属性（_blank, _self等）
	 */
	private String target;
	/**
	 * 指定节点被点击后的跳转页面 URL 地址
	 */
	private String url;
	/**
	 * 父节点ID
	 */
	private String parentId;
	/**
	 * 点击默认触发的url
	 */
	private String click;
	/**
	 * 节点皮肤
	 */
	private String iconSkin;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<TreeNode> getNodes() {
		return nodes;
	}
	public void setNodes(List<TreeNode> nodes) {
		this.nodes = nodes;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
	}
	public String getIconSkin() {
		return iconSkin;
	}
	public void setIconSkin(String iconSkin) {
		this.iconSkin = iconSkin;
	}

}
