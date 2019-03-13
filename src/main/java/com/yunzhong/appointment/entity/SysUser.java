package com.yunzhong.appointment.entity;

public class SysUser {
    private String userId;

    private String userName;

    private String userPass;

    private String userNickname;

    private String userState;

    private String userInfo;
    
    private Boolean hasDocRole = false;
    
    private String roleId;

    private String roleName;

    private String roleState;

    private String roleInfo;

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public String getRoleState() {
        return roleState;
    }

    public void setRoleState(String roleState) {
        this.roleState = roleState == null ? null : roleState.trim();
    }

    public String getRoleInfo() {
        return roleInfo;
    }

    public void setRoleInfo(String roleInfo) {
        this.roleInfo = roleInfo == null ? null : roleInfo.trim();
    }
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass == null ? null : userPass.trim();
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname == null ? null : userNickname.trim();
    }

    public String getUserState() {
        return userState;
    }

    public void setUserState(String userState) {
        this.userState = userState == null ? null : userState.trim();
    }

    public String getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(String userInfo) {
        this.userInfo = userInfo == null ? null : userInfo.trim();
    }

	@Override
	public String toString() {
		return "SysUser [userId=" + userId + ", userName=" + userName + ", userPass=" + userPass + ", userNickname="
				+ userNickname + ", userState=" + userState + ", userInfo=" + userInfo + "]";
	}

	public Boolean getHasDocRole() {
		return hasDocRole;
	}

	public void setHasDocRole(Boolean hasDocRole) {
		this.hasDocRole = hasDocRole;
	}
}