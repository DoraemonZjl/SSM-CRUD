package com.kayoshi.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kayoshi.crud.bean.Employee;
import com.kayoshi.crud.bean.EmployeeExample;
import com.kayoshi.crud.bean.EmployeeExample.Criteria;
import com.kayoshi.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	


	public void sava(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	public List<Employee> getAlllist() {
		return employeeMapper.selectByExampleWhitDept(null);
	}
	//检验用户名是否可用
	public Boolean checkForLastName(String lastName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andLastNameEqualTo(lastName);
		int countByExample = employeeMapper.countByExample(example);
		System.out.println(countByExample);
		return countByExample == 0 ;
	}

	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKeyWhitDept(id);
	}

	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void delEmpById(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

	

}
