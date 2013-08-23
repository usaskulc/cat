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
