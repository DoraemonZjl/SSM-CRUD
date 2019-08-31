package com.kayoshi.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kayoshi.crud.bean.Department;
import com.kayoshi.crud.bean.Employee;
import com.kayoshi.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getAllDept() {
		return departmentMapper.selectByExample(null);
	}

}
