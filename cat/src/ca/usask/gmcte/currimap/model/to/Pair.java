package ca.usask.gmcte.currimap.model.to;

import java.math.BigInteger;

import ca.usask.gmcte.util.HTMLTools;

@SuppressWarnings("serial")

public class Pair implements java.io.Serializable
{

	private int a;
	private int b;

	public Pair()
	{
	}

	public int getA()
	{
		return a;
	}

	public void setA(Object o)
	{
		this.a = getIntValue(o);
	}

	public int getB()
	{
		return b;
	}

	public void setB(Object o)
	{
		this.b = getIntValue(o);
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
