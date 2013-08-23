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


package ca.usask.gmcte.currimap.model.xml;

import java.io.UnsupportedEncodingException;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 
 * @author abv641
 */
@XmlRootElement
public class Course
{
	private String subject;
	private String coursenum;
	private String title;
	private String section;
	private String term;
	private String numStudents;
	private Instructors instructors;

	public Course()
	{
	}

	public Course(String subject, String coursenum, String title, String section)
	{
		this.subject = subject;
		this.coursenum = coursenum;
		this.title = title;
		this.section = section;
	}

	@XmlElement(name = "classnum")
	public String getCoursenum()
	{
		return coursenum;
	}

	public void setCoursenum(String coursenum)
	{
		this.coursenum = coursenum;
	}

	@XmlElement(name = "section")
	public String getSection()
	{
		return section;
	}

	public void setSection(String section)
	{
		this.section = section;
	}
	public String getCleanSection()
	{
		char last = section.charAt(section.length()-1);
		if(last<='9' && last>='0')
		{
			return section;
		}
		return section.substring(0,section.length()-1);
	}
	@XmlElement(name = "title")
	public String getTitle() throws UnsupportedEncodingException
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	@XmlElement(name = "subject")
	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}
	@XmlElement(name = "instructors")
	public Instructors getInstructors()
	{
		return instructors;
	}

	public void setInstructors(Instructors instructors)
	{
		this.instructors = instructors;
	}
	@XmlElement(name = "term")
	public String getTerm()
	{
		return term;
	}

	public void setTerm(String term)
	{
		this.term = term;
	}
	
	@XmlElement(name = "numstudents")
	public String getNumStudents()
	{
		return numStudents;
	}

	public void setNumStudents(String numStudents)
	{
		this.numStudents = numStudents;
	}
}
