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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;



/**
 * Characteristic generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "characteristic")
public class Characteristic implements java.io.Serializable
{

	private int id;
	private CharacteristicType characteristicType;
	private String name;
	private String description;
	private int displayIndex;
	private Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics = new HashSet<LinkCourseOfferingOutcomeCharacteristic>(
			0);

	public Characteristic()
	{
	}

	public Characteristic(int id, CharacteristicType characteristicType, String name,
			int displayIndex)
	{
		this.id = id;
		this.characteristicType = characteristicType;
		this.name = name;
		this.displayIndex = displayIndex;
	}

	public Characteristic(int id, CharacteristicType characteristicType, String name,
			String description, int displayIndex,
			Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics)
	{
		this.id = id;
		this.characteristicType = characteristicType;
		this.name = name;
		this.description = description;
		this.displayIndex = displayIndex;
		this.linkCourseOfferingOutcomeCharacteristics = linkCourseOfferingOutcomeCharacteristics;
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "characteristic_type_id", nullable = false)
	@NotNull
	public CharacteristicType getCharacteristicType()
	{
		return this.characteristicType;
	}

	public void setCharacteristicType(CharacteristicType characteristicType)
	{
		this.characteristicType = characteristicType;
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

	@Column(name = "display_index", nullable = false)
	public int getDisplayIndex()
	{
		return this.displayIndex;
	}

	public void setDisplayIndex(int displayIndex)
	{
		this.displayIndex = displayIndex;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "characteristic")
	public Set<LinkCourseOfferingOutcomeCharacteristic> getLinkCourseOfferingOutcomeCharacteristics()
	{
		return this.linkCourseOfferingOutcomeCharacteristics;
	}

	public void setLinkCourseOfferingOutcomeCharacteristics(
			Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics)
	{
		this.linkCourseOfferingOutcomeCharacteristics = linkCourseOfferingOutcomeCharacteristics;
	}

}
