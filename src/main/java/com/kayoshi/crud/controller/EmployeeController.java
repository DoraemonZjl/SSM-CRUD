package com.kayoshi.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kayoshi.crud.bean.Employee;
import com.kayoshi.crud.bean.Msg;
import com.kayoshi.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	
	
	
	
	
	//删除员工信息
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.delEmpById(id);
		}
		return Msg.successMsg();
	}
	
	
	
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 * 
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 * 
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
                success = true;
                return;
            }
	 * 
	 * 
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工更新方法
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
	public Msg updateEmployee(Employee employee,HttpServletRequest request) {
		System.out.println("请求体中的值："+request.getParameter("gender"));
		System.out.println("data: " + employee);
		employeeService.updateEmp(employee);
		return Msg.successMsg();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/getEmpWithDeptById/{id}",method = RequestMethod.GET) 
	public Msg getEmpWithDeptById(@PathVariable("id") Integer id) {
		 Employee employee = employeeService.getEmpById(id);
		 return Msg.successMsg().add("EmpWithDept", employee);
	  
	}
	 
	
	@ResponseBody
	@RequestMapping("/checkLastName")
	public Msg checkLastName(@RequestParam("lastName") String lastName) {
		//System.out.println(lastName);
		//判断用户名是否合法
		String exp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!lastName.matches(exp)) {
			return Msg.failMsg().add("check_msg", "用户名是6-16位英文和数字的组合或者2-5位中文");
		}
		Boolean x =  employeeService.checkForLastName(lastName);
		System.out.println(x);
		if(x) {
			return Msg.successMsg();
		}else {
			return Msg.failMsg().add("check_msg", "改用户名已被注册");
		}
	}

	//保存新增员工信息
	@ResponseBody
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError error : fieldErrors) {
				System.out.println("错误字段名：" + error.getField());
				System.out.println("错误信息：" + error.getDefaultMessage());
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.failMsg().add("error", map);
		}else {
			employeeService.sava(employee);
			return Msg.successMsg();
		}
	}

	/**
	 *- 前端Ajax请求返回的数据
	 * @param pn --> 页码
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1")Integer pn) {
		PageHelper.startPage(pn, 8);
		List<Employee> emps = employeeService.getAlllist();
		//PageInfo对结果进行包装PageInfo(emps,5) 中的5为显示页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.successMsg().add("PageInfo", page);
	}
	
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn
			,Model model) {
		//1、引用pageHelper分页插件
		//2、查询之前调用，然后紧接着数据,pn为当前页面,8为每一页显示8个数据
		PageHelper.startPage(pn, 8);
		List<Employee> emps = employeeService.getAlllist();
		//PageInfo对结果进行包装PageInfo(emps,5) 中的5为显示页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("PageInfo", page);
		return "list";
	}
	
}
