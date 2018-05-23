package com.hniu.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.hniu.mapper.SysUserMapper;
import com.hniu.pojo.SysUser;
import com.hniu.pojo.SysUserExample;
import com.hniu.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	SysUserMapper userMapper;

	@Override
	public List<SysUser> selectAll() {
		SysUserExample example = new SysUserExample();
		example.setOrderByClause("id desc");
		return userMapper.selectByExample(example);
	}

	@Override
	public SysUser selectUser(String usercode) {
		SysUserExample example = new SysUserExample();
		example.createCriteria().andUsercodeEqualTo(usercode);
		return userMapper.selectByExample(example).get(0);
	}

	@Override
	public int updateUser(SysUser user) {
	if(StringUtils.isEmpty(userMapper.selectByPrimaryKey(user.getId())) == true) {
		return 2;
	}
		int i = userMapper.updateByPrimaryKeySelective(user);
		if(i!=0) {
			return 1;
		}
		return 0;
	}

	@Override
	public int deleteUser(Integer id) {
		if(StringUtils.isEmpty(userMapper.selectByPrimaryKey(id)) == true) {
			return 2;
		}
		int i = userMapper.deleteByPrimaryKey(id);
		if(i != 0) {
			return 1;
		}
		return 0;
	}

	@Override
	public int updateBatch(List<Integer> id) {
		int sum = id.size();
		if(sum > 0) {
			int i = userMapper.updateBatch(id);
			if(i == sum) {
				return 1;
			}else {
				return 0;
			}
		}
		return 0;
	}
	
	
	
	

}
