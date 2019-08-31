package com.kayoshi.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kayoshi.crud.bean.Employee;
import com.kayoshi.crud.dao.DepartmentMapper;
import com.kayoshi.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestCRUD {
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		System.out.println(employeeMapper);
		System.out.println(departmentMapper);
//		int i = employeeMapper.insertSelective(new Employee(null, "Hy", "1", "hy@kayoshi.top", 5300));
//		System.out.println(i);
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<=200;i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 6)+i;
			mapper.insertSelective(new Employee(null, uuid, "1", uuid+"@kayoshi.top", 530));
		}
		System.out.println("批量完成");
	}
}
