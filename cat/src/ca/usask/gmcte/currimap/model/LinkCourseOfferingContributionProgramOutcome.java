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


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.validator.NotNull;

@SuppressWarnings("serial")
@Entity
@Table(name = "link_course_offering_contribution_program_outcome")
public class LinkCourseOfferingContributionProgramOutcome implements java.io.Serializable
{

	private int id;
	private LinkProgramProgramOutcome linkProgramOutcome;
	private CourseOffering courseOffering;
	private ContributionOptionValue contribution;
	private MasteryOptionValue mastery;
	
	public LinkCourseOfferingContributionProgramOutcome()
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


	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "link_program_program_outcome_id", nullable = false)
	@NotNull
	public LinkProgramProgramOutcome getLinkProgramOutcome()
	{
		return this.linkProgramOutcome;
	}

	public void setLinkProgramOutcome(LinkProgramProgramOutcome outcome)
	{
		this.linkProgramOutcome = outcome;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "course_offering_id", nullable = false)
	@NotNull
	public CourseOffering getCourseOffering()
	{
		return courseOffering;
	}

	public void setCourseOffering(CourseOffering courseOffering)
	{
		this.courseOffering = courseOffering;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "contribution_option_id")
	public ContributionOptionValue getContribution()
	{
		return contribution;
	}

	public void setContribution(ContributionOptionValue contribution)
	{
		this.contribution = contribution;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mastery_option_id")
	public MasteryOptionValue getMastery() 
	{
		return mastery;
	}

	public void setMastery(MasteryOptionValue mastery) 
	{
		this.mastery = mastery;
	}
}
