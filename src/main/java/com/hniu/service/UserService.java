package com.hniu.service;

import java.util.List;

import com.hniu.pojo.SysUser;

public interface UserService {
	//查询所有用户信息
	List<SysUser> selectAll();
	//查询单个用户信息
	SysUser selectUser(String usercode);

}
