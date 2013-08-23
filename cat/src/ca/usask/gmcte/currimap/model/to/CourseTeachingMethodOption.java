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


package ca.usask.gmcte.currimap.model.to;

import java.math.BigInteger;

import ca.usask.gmcte.util.HTMLTools;

@SuppressWarnings("serial")

public class CourseTeachingMethodOption implements java.io.Serializable
{

	private int courseId;
	private int teachingMethodIndex;
	private double weight;
	private int offeringCount;
	

	public CourseTeachingMethodOption()
	{
	}

	public int getCourseId()
	{
		return courseId;
	}

	public void setCourseId(int courseId)
	{
		this.courseId = courseId;
	}


	public int getTeachingMethodIndexId()
	{
		return teachingMethodIndex;
	}

	public void setTeachingMethodIndexId(Object teachingMethodIndex)
	{
		this.teachingMethodIndex = getIntValue(teachingMethodIndex);
	}

	public double getWeight()
	{
		return weight;
	}

	public void setWeight(Object weight)
	{
		this.weight = getDoubleValue(weight);
	}

	public int getOfferingCount()
	{
		return offeringCount;
	}

	public void setOfferingCount(Object offeringCount)
	{
		this.offeringCount = getIntValue(offeringCount);
	}

	private int getIntValue(Object value)
	{
		String className = value.getClass().getName();
		if(className.equals("java.math.BigInteger"))
		{
			return ((BigInteger)value).intValue();
		}
		else if(className.contains("String"))
		{
			return HTMLTools.getInt((String)value);
		}
		else if(className.contains("Integer"))
		{
			return ((Integer)value);
		}
		System.out.println(className);
		return -1;
	}	
	private double getDoubleValue(Object value)
	{
		String className = value.getClass().getName();
		if(className.equals("java.math.BigInteger"))
		{
			return ((BigInteger)value).doubleValue();
		}
		else if(className.contains("String"))
		{
			return Double.parseDouble((String)value);
		}
		else if(className.contains("Double"))
		{
			return ((Double)value);
		}
		System.out.println(className);
		return -1;
	}	
		
}
