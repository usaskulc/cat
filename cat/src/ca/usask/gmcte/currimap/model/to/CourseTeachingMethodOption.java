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
