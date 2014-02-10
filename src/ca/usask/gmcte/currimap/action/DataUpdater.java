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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;

import ca.usask.gmcte.currimap.model.xml.Course;
import ca.usask.gmcte.currimap.model.xml.Instructor;
import ca.usask.gmcte.currimap.model.xml.Instructors;
import ca.usask.gmcte.util.ConnectionTool;


public class DataUpdater
{
	private static Logger logger = Logger.getLogger(DataUpdater.class);

	@SuppressWarnings("resource")
	public String updateCourses(List<Course> courses,String department)
	{
		Connection con = ConnectionTool.getConnection("currimap");
		PreparedStatement queryStmt = null;
		PreparedStatement insertStmt = null;
		PreparedStatement departmentStmt = null;
		int count = 0;
		int inserted = 0;
		boolean debug = true;
		ResultSet rs = null;
		StringBuilder r = new StringBuilder();
		try
		{
			con.setAutoCommit(true);
			String departmentQuery = "SELECT id FROM organization WHERE system_name = ?";
			
			String courseQuery = "SELECT id FROM course WHERE course_number = ? AND subject = ?";
			String courseInsert  = "INSERT INTO course (course_number,subject,title) values (?,?,?)";
			
			String courseOfferingQuery = "SELECT id FROM course_offering WHERE course_id = ? AND section_number = ? AND term = ?";
			String courseOfferingInsert  = "INSERT INTO course_offering (course_id,section_number,term,medium,num_students) values (?,?,?,'Face to face',?)";
		

			String instructorQuery = "SELECT id FROM instructor WHERE userid = ?";
			String instructorInsert  = "INSERT INTO instructor (userid,first_name,last_name) values (?,?,?)";
		
			String instructorLinkQuery = "SELECT id FROM link_course_offering_instructor WHERE course_offering_id = ? AND instructor_id = ?";
			String instructorLinkInsert  = "INSERT INTO link_course_offering_instructor (course_offering_id,instructor_id) values (?,?)";
		
			String courseDepartmentQuery = "SELECT id FROM link_course_organization WHERE course_id = ? AND organization_id = ?";
			String courseDepartmentInsert  = "INSERT INTO link_course_organization (course_id,organization_id) values (?,?)";
		
			
			departmentStmt = con.prepareStatement(departmentQuery);
			departmentStmt.setString(1,department);
			rs = departmentStmt.executeQuery();
			if(rs.next())
			{
				if(debug) r.append(department+ " Number of courses to process:"+courses.size());
				int deptId = rs.getInt(1);
				
				for(int i =0; i< courses.size() ; i++)
				{
					Course course = courses.get(i);
				//	System.out.print(course.getSubject()+" "+course.getCoursenum() +" "+ course.getCleanSection()+" "+course.getTitle());
					if(debug) r.append("Processing: "+course.getSubject()+" "+ course.getCoursenum()+ " "+course.getCleanSection()+" "+course.getTerm());
					
					queryStmt = con.prepareStatement(courseQuery);
					queryStmt.setString(1,course.getCoursenum().trim());
					queryStmt.setString(2,course.getSubject().trim());
					rs = queryStmt.executeQuery();
					int courseId = -1;
					if(rs.next())
					{
						courseId = rs.getInt(1);
						if(debug) r.append("found courseId: ");
						r.append(courseId);

					}
					else
					{
						insertStmt = con.prepareStatement(courseInsert);
						insertStmt.setString(1,course.getCoursenum().trim());
						insertStmt.setString(2,course.getSubject().trim());
						insertStmt.setString(3,course.getTitle().trim());
						inserted = insertStmt.executeUpdate();
						if(inserted < 1)
						{
							r.append("ERROR: Unable to insert course "+course.getSubject()+" "+ course.getCoursenum()+" "+course.getTitle());
							throw new Exception ("Unable to insert course "+course.getSubject()+" "+ course.getCoursenum()+" "+course.getTitle());
						}
						rs = queryStmt.executeQuery();
						if(rs.next())
						{
							courseId = rs.getInt(1);
							if(debug) 
							{
								if(debug) 
								{
									r.append("INSERTED :");	
									r.append("found courseId:");
									r.append(courseId);
								}
							}
				
						}
						else
						{
							r.append("ERROR: Unable to find course after insert "+course.getSubject()+" "+ course.getCleanSection()+" "+course.getTitle());
							//can't process this course, move on to the next course
							continue;
						}
					}
					
					//courseId known now. link to dept
					
					queryStmt = con.prepareStatement(courseDepartmentQuery);
					queryStmt.setInt(1,courseId);
					queryStmt.setInt(2,deptId);
					rs = queryStmt.executeQuery();
					if(rs.next())
					{
						if(debug)  r.append(" course is part of dept ");

					}
					else
					{
						insertStmt = con.prepareStatement(courseDepartmentInsert);
						insertStmt.setInt(1,courseId);
						insertStmt.setInt(2,deptId);
						inserted = insertStmt.executeUpdate();
						if(inserted<1)
						{
							r.append("ERROR: Unable to link course " + courseId + " to dept " + deptId);
							throw new Exception ("Unable to link course " + courseId + " to dept " + deptId);
						}
						rs = queryStmt.executeQuery();
						if(rs.next())
						{
							if(debug) r.append(" course is NOW part of dept ");
						}
						else
						{
							r.append("ERROR: Unable to find linked course afer insert course " + courseId + " to dept " + deptId);
						}
					}
					//course now linked to dept Process section
					
					queryStmt = con.prepareStatement(courseOfferingQuery);
					queryStmt.setString(2,course.getCleanSection().trim());
					queryStmt.setString(3,course.getTerm().trim());
					queryStmt.setInt(1,courseId);
					rs = queryStmt.executeQuery();
					int courseOfferingId = -1;
					if(rs.next())
					{
						courseOfferingId = rs.getInt(1);
						if(debug) 
						{
							r.append(" found courseOfferingId:");
							r.append(courseOfferingId);
							r.append("\n");
						}
					}
					else
					{
						insertStmt = con.prepareStatement(courseOfferingInsert);
						insertStmt.setString(2,course.getCleanSection().trim());
						insertStmt.setString(3,course.getTerm().trim());
						insertStmt.setInt(4,Integer.parseInt(course.getNumStudents()));
						
						insertStmt.setInt(1,courseId);
						inserted = insertStmt.executeUpdate();
						if(inserted<1)
						{
							r.append("ERROR: Unable to insert course offering "+courseId +" "+ course.getCleanSection()+" "+course.getTerm());
							throw new Exception ("Unable to insert course offering "+courseId +" "+ course.getCleanSection()+" "+course.getTerm());
						}
					
						rs = queryStmt.executeQuery();
						if(rs.next())
						{
							courseOfferingId = rs.getInt(1);
							if(debug) 
							{
								r.append(" INSERTED :");
								r.append("found courseOfferingId:");
								r.append(courseOfferingId);
								r.append("\n");
							}
						}
						else
						{
							r.append("ERROR: Unable to fid course offering after insert "+courseId +" "+ course.getCleanSection()+" "+course.getTerm());
							//can't process this course offering, move on to the next course
							continue;
						}
					}
					//courseOffering is now known as well. Process instructors
					Instructors instructorsObject = course.getInstructors();
					if(instructorsObject!=null)
					{
						List<Instructor> instructorsList = instructorsObject.getInstructors();
					
						for(Instructor instr: instructorsList)
						{
							
							queryStmt = con.prepareStatement(instructorQuery);
							queryStmt.setString(1,instr.getUsername().trim());
							rs = queryStmt.executeQuery();
							int instructorId = -1;
							if(rs.next())
							{
								instructorId = rs.getInt(1);
								
								if(debug) r.append(" found instructor \n");
							}
							else
							{
								insertStmt = con.prepareStatement(instructorInsert);
								insertStmt.setString(1,instr.getUsername().trim());
								insertStmt.setString(2,instr.getFirstName().trim());
								insertStmt.setString(3,instr.getLastName().trim());
								
								inserted = insertStmt.executeUpdate();
								if(inserted<1)
								{
									r.append("ERROR: Unable to insert instructor "+ instr.getUsername());
									throw new Exception ("Unable to insert instructor "+ instr.getUsername());
								}
								rs = queryStmt.executeQuery();
								if(rs.next())
								{
									if(debug) r.append(" INSTRUCTOR INSERTED\n");
									instructorId = rs.getInt(1);
								}
								else
								{
									r.append("ERROR: Unable to find instructor after insert "+ instr.getUsername());
								}
							}
									
							if(instructorId > 0)//instructor data done, handle the link to the course offering now
							{		
								queryStmt = con.prepareStatement(instructorLinkQuery);
								queryStmt.setInt(1,courseOfferingId);
								queryStmt.setInt(2,instructorId);
								rs = queryStmt.executeQuery();
								if(rs.next())
								{
									if(debug) r.append(" found instructor link \n");
								}
								else
								{
									insertStmt = con.prepareStatement(instructorLinkInsert);
									insertStmt.setInt(1,courseOfferingId);
									insertStmt.setInt(2,instructorId);
									inserted = insertStmt.executeUpdate();
									if(inserted<1)
									{
										r.append("ERROR: Unable to insert instructor "+courseOfferingId +" "+ instructorId);
										throw new Exception ("Unable to insert instructor "+courseOfferingId +" "+ instructorId);
									}
									rs = queryStmt.executeQuery();
									if(rs.next())
									{
										if(debug) r.append(" INSTRUCTOR LINK INSERTED\n");
									}
									else
									{
										r.append("ERROR: Unable to find instructor link after insert"+courseOfferingId +" "+ instructorId);
									}
								}
							}
							
							
						}
						
					}//done processing instructors
					count++;
					//r.append("At bottom of loop through courses "+course.getSubject()+" "+ course.getCleanSection()+" "+course.getTitle()+" i="+i);
				}//end of loop through courses
				System.out.println("All done processed: "+count);
			}
			else
			{
				logger.fatal("UNABLE TO FIND Organization ["+department+"]");
			}
		}
		catch(Exception e)
		{
			logger.error("Problems checking organizations",e);
			e.printStackTrace();
		}
		finally
		{
			ConnectionTool.freeResultSet(rs);
			ConnectionTool.freePreparedStatement(queryStmt);
			ConnectionTool.freePreparedStatement(insertStmt);
			ConnectionTool.freePreparedStatement(departmentStmt);
			ConnectionTool.freeConnection(con);
			
		}
		
		return r.toString();
	}
	
	public String updateOrganizations(List<String> orgs)
	{
		Connection con = ConnectionTool.getConnection("currimap");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		StringBuilder r = new StringBuilder();
		try
		{
			
			String query = "SELECT id FROM organization WHERE system_name = ?";
			String insert  = "INSERT INTO organization (name,system_name,active) values (?,?,'N')";
			for(String org: orgs)
			{
				stmt = con.prepareStatement(query);
				stmt.setString(1,org.trim());
				rs = stmt.executeQuery();
				if(!rs.next())
				{
				
					stmt = con.prepareStatement(insert);
					stmt.setString(1,org.trim());
					stmt.setString(2,org.trim());
					
					int insertCount = stmt.executeUpdate();
					if(insertCount == 1)
					{
						r.append("Added [");
						r.append(org);
						r.append("]\n");
					}
					else
					{
						r.append("Error! Unable to add [");
						r.append(org);
						r.append("] !!!!!!!\n");
					}
				}
			}
		}
		catch(Exception e)
		{
			logger.error("Problems checking organizations",e);
		}
		finally
		{
			ConnectionTool.freeResultSet(rs);
			ConnectionTool.freePreparedStatement(stmt);
			ConnectionTool.freeConnection(con);
		}
		
		return r.toString();
	}

	public static void main(String[] arg) throws Exception
	{
		String[] test = {"01","05A","07B","L09X","09","00"};
		for(int i=0; i<255; i++)
		{
			char c = (char)i;
			System.out.println(i+"="+c);
		}
		for(String t:test)
		{
			char last = t.charAt(t.length()-1);
			if(last<='9' && last>='0')
			{
				System.out.println(t);
			}
			else
			{
				System.out.println(t+" now: ["+t.substring(0,t.length()-1));
						
			}
		}
		
		String[] monthOptions = {"01","05","07","09"};
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		for(int i=(year-3) ; i <= year; i++)
		{
			for(String month : monthOptions)
			{
				String term = i+month;
				System.out.println(term);
			}
		}
	}

}
