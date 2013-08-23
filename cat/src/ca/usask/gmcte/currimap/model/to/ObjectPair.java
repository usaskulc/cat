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

@SuppressWarnings("serial")

public class ObjectPair implements java.io.Serializable
{

	private Object a;
	private Object b;

	public ObjectPair(Object a, Object b)
	{
		this.a = a;
		this.b = b;
	}

	public Object getA()
	{
		return a;
	}

	public void setA(Object o)
	{
		this.a = o;
	}

	public Object getB()
	{
		return b;
	}

	public void setB(Object o)
	{
		this.b = o;
	}
		
}
