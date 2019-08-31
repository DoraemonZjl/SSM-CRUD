package com.kayoshi.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.kayoshi.crud.bean.Department;
import com.kayoshi.crud.bean.Msg;
import com.kayoshi.crud.service.DepartmentService;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/getAllDept")
	public Msg getAllDept() {
		List<Department> dept = departmentService.getAllDept();
		PageInfo page = new PageInfo(dept);
		return Msg.successMsg().add("allDept", page);
	}

}
