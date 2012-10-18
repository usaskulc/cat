package ca.usask.gmcte.currimap.model.to;

import java.math.BigInteger;

import ca.usask.gmcte.util.HTMLTools;


@SuppressWarnings("serial")

public class CourseOfferingContribution implements java.io.Serializable
{

	private int courseOfferingId;
	private int contribution;
	private int mastery;
	

	public CourseOfferingContribution()
	{
	}

	public int getCourseOfferingId()
	{
		return courseOfferingId;
	}

	public void setCourseOfferingId(int courseOfferingId)
	{
		this.courseOfferingId = courseOfferingId;
	}

	public void setContributionObject(Object contribution)
	{
		this.contribution = getIntValue(contribution);
	}
	public void setContribution(int contribution)
	{
		this.contribution = contribution;
	}
	public int getContribution()
	{
		return contribution;
	}
	public void setMasteryObject(Object mastery)
	{
		this.mastery = getIntValue(mastery);
	}
	public void setMastery(int mastery)
	{
		this.mastery = mastery;
	}
	public int getMastery()
	{
		return mastery;
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
		
}
