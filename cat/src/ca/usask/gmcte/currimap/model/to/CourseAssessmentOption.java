package ca.usask.gmcte.currimap.model.to;

import java.math.BigInteger;

import ca.usask.gmcte.util.HTMLTools;

@SuppressWarnings("serial")

public class CourseAssessmentOption implements java.io.Serializable
{

	private int courseId;
	private int optionId;
	private double weight;
	

	public CourseAssessmentOption()
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


	public int getOptionId()
	{
		return optionId;
	}

	public void setOptionId(Object optionId)
	{
		this.optionId = getIntValue(optionId);
	}

	public double getWeight()
	{
		return weight;
	}

	public void setWeight(Object weight)
	{
		this.weight = getDoubleValue(weight);
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
