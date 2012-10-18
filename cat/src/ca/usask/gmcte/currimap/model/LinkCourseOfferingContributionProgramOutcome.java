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
