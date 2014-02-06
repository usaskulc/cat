/*****************************************************************************
 * Copyright 2012, 2013 University of Saskatchewan
 *
 * This file is part of the Curriculum Alignment Tool (CAT).
 *
 * CAT is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 *(at your option) any later version.
 *
 * CAT is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with CAT.  If not, see <http://www.gnu.org/licenses/>.
 *
 ****************************************************************************/


package ca.usask.gmcte.currimap.action;

import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Scanner;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.log4j.Logger;

import ca.usask.gmcte.currimap.model.xml.Course;
import ca.usask.gmcte.currimap.model.xml.Courses;
import ca.usask.gmcte.currimap.model.xml.Department;
import ca.usask.gmcte.currimap.model.xml.Departments;


public class DataImporter
{
	private static Logger logger = Logger.getLogger(DataImporter.class);
	public  List<String> retrieveOrganizations() //Departments
	{
		ResourceBundle bundle = ResourceBundle.getBundle("ldapuser");
		String departmentsSourceURL = bundle.getString("departmentsSourceURL");
		
		List<String> toReturn = new ArrayList<String>();
		try
		{
			URL pawsServiceURL = new URL(departmentsSourceURL);//"http://localhost/abv641/departments.txt");
			Scanner input = new Scanner(pawsServiceURL.openConnection().getInputStream());
			while(input.hasNextLine())
			{
				toReturn.add(input.nextLine().split("=")[1]);
			}
			input.close();
		}
		catch(Exception e)
		{
			logger.error("Problems retrieving departments from PAWS service",e);
		}
		return toReturn;
		
	}
	public  List<Course> retrieveCoursesForDepartment(String department,String term) throws Exception
	{
		try
		{
			ResourceBundle bundle = ResourceBundle.getBundle("ldapuser");
			String classesForDeptURL = bundle.getString("classesForDeptURL");
			
			String url=classesForDeptURL.replaceAll("<dept>",URLEncoder.encode(department,"UTF-8")).replaceAll("<term>",term);
			
			//url = "http://localhost/abv641/Chemistry/sections.xml";
			logger.error("Attempting to get courses from :"+url);
			URL departmentURL=new URL(url);
			JAXBContext jc = JAXBContext.newInstance(Departments.class);
			Unmarshaller unmarshaller = jc.createUnmarshaller();
	
			Departments departmentsObject = (Departments) unmarshaller.unmarshal(departmentURL);
			List<Department> depts = departmentsObject.getDepartments();
			for(Department dept: depts)
			{
				System.out.println(dept.getName());
				Courses coursesObject = dept.getCourses();
				return coursesObject.getCourses();
			}
			return new ArrayList<Course>();
		}
		catch(Exception e)
		{
			return null;
		}
	}
	
	
	public static void main(String[] arg) throws Exception
	{
		
	
		
		System.setProperty("currimap.isStandalone","true");
		try{Thread.sleep(1000);}catch(Exception e){}
		DataImporter di = new DataImporter();
	
		List<Course> crs = di.retrieveCoursesForDepartment("Chemistry","2001009");
		
		
		DataUpdater du = new DataUpdater();
		System.out.println(du.updateCourses(crs,"Chemistry"));
		
		/*
		long start = System.currentTimeMillis(); 
		long processStart = start;
		List<String> depts = di.retrieveDepartments();
		
		long now = System.currentTimeMillis();
		
		logger.error("It took "+(now-start)+" to retrieve all depts");
		start=now;
		System.out.println("RESULT="+du.updateDepartments(depts));
		now = System.currentTimeMillis();
		
		logger.error("It took "+(now-start)+" to update all depts");
		start=now;
		
		for(String dept:depts)
		{
			List<Course> courses  = di.retrieveCoursesForDepartment(dept,"201009");
			now = System.currentTimeMillis();
			
			logger.error("It took "+(now-start)+" to retrieve courses for dept " +dept);
			start=now;
			if(courses!=null)
			{
				String updateResult = du.updateCourses(courses,dept);
				//System.out.println("Updating courses:"+ updateResult);
				now = System.currentTimeMillis();
				logger.error("It took "+(now-start)+" to update courses for dept " +dept);
				start=now;
			}
		}
		now = System.currentTimeMillis();
		
		logger.error("It took "+(now-processStart)+" to process everything!");
		start=now;*/
	}

}
