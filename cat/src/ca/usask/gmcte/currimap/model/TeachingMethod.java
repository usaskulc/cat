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

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

/**
 * TeachingMethod generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "teaching_method")
public class TeachingMethod implements java.io.Serializable
{

	private int id;
	private String name;
	private String description;
	private int displayIndex;
	private Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods = new HashSet<LinkCourseOfferingTeachingMethod>(
			0);

	public TeachingMethod()
	{
	}

	public TeachingMethod(int id, String name)
	{
		this.id = id;
		this.name = name;
	}

	public TeachingMethod(int id, String name, String description,
			Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.linkCourseOfferingTeachingMethods = linkCourseOfferingTeachingMethods;
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

	@Column(name = "name", nullable = false, length = 100)
	@NotNull
	@Length(max = 100)
	public String getName()
	{
		return this.name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	@Column(name = "description", length = 1024)
	@Length(max = 1024)
	public String getDescription()
	{
		return this.description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "teachingMethod")
	public Set<LinkCourseOfferingTeachingMethod> getLinkCourseOfferingTeachingMethods()
	{
		return this.linkCourseOfferingTeachingMethods;
	}

	public void setLinkCourseOfferingTeachingMethods(
			Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods)
	{
		this.linkCourseOfferingTeachingMethods = linkCourseOfferingTeachingMethods;
	}

	@Column(name = "display_index")
	public int getDisplayIndex()
	{
		return displayIndex;
	}

	public void setDisplayIndex(int displayIndex)
	{
		this.displayIndex = displayIndex;
	}

}
