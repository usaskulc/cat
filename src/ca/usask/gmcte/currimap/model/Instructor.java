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


package ca.usask.gmcte.currimap.model;

// Generated Dec 3, 2011 11:40:19 AM by Hibernate Tools 3.2.4.GA

import java.util.TreeMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

import ca.usask.gmcte.currimap.action.PermissionsManager;
import ca.usask.gmcte.util.HTMLTools;
import ca.usask.ocd.ldap.LdapConnection;

/**
 * Program generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "instructor")
public class Instructor implements java.io.Serializable
{

	private int id;
	private String userid;
	private String lastName;
	private String firstName;

	public Instructor()
	{
	}


	@Id @GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public int getId()
	{
		return this.id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	@Column(name = "userid", nullable = false, length = 30)
	@NotNull
	@Length(max = 30)
	public String getUserid()
	{
		return this.userid;
	}

	public void setUserid(String userid)
	{
		this.userid = userid;
	}
	@Transient
	public String getInstructorDisplay()
	{
		StringBuilder output = new StringBuilder();
		
		if (!HTMLTools.isValid(lastName) && !HTMLTools.isValid(firstName))
		{
			if(PermissionsManager.ldapEnabled)
			{
				try		
				{
					LdapConnection ldapConnection = LdapConnection.instance();
					TreeMap<String,String> data = ldapConnection.getUserData(userid);	
					if(PermissionsManager.instance().saveInstructor(userid, data.get("givenName"), data.get("sn")))
					{
						setLastName(data.get("sn"));
						setFirstName(data.get("givenName"));
					}			
				}
				catch(Exception e)
				{
					output.append(userid+" not found");
				}	
			}
			else
			{
				output.append("no name found");
			}
		}
		if(HTMLTools.isValid(firstName))
		{
			output.append(firstName);
			output.append(" ");
		}
		if(HTMLTools.isValid(lastName))
		{
			output.append(lastName);
		}
		
		output.append("( ");
		output.append(userid);
		output.append(" )");
		return output.toString();
	}

	@Column(name = "last_name", nullable = true, length = 50)
	@Length(max = 50)
	public String getLastName() 
	{
		return lastName;
	}


	public void setLastName(String lastName) 
	{
		this.lastName = lastName;
	}

	@Column(name = "first_name", nullable = true, length = 50)
	@Length(max = 50)
	public String getFirstName() 
	{
		return firstName;
	}


	public void setFirstName(String firstName) 
	{
		this.firstName = firstName;
	}
}