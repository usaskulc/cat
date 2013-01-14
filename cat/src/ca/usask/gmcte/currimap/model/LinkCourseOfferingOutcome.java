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
import org.hibernate.validator.NotNull;

/**
 * LinkCourseOfferingOutcome generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "link_course_offering_outcome")
public class LinkCourseOfferingOutcome implements java.io.Serializable
{

	private int id;
	private CourseOffering courseOffering;
	private CourseOutcome courseOutcome;
	private int displayIndex;
	private Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics = new HashSet<LinkCourseOfferingOutcomeCharacteristic>(
			0);

	public LinkCourseOfferingOutcome()
	{
	}

	public LinkCourseOfferingOutcome(int id, CourseOffering courseOffering, CourseOutcome outcome)
	{
		this.id = id;
		this.courseOffering = courseOffering;
		this.courseOutcome = outcome;
	}

	public LinkCourseOfferingOutcome(int id, CourseOffering courseOffering, CourseOutcome outcome,
			Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics)
	{
		this.id = id;
		this.courseOffering = courseOffering;
		this.courseOutcome = outcome;
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
		@JoinColumn(name = "course_offering_id", nullable = false)
		@NotNull
	public CourseOffering getCourseOffering()
	{
		return this.courseOffering;
	}

	public void setCourseOffering(CourseOffering courseOffering)
	{
		this.courseOffering = courseOffering;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "course_outcome_id", nullable = false)
	@NotNull
	public CourseOutcome getCourseOutcome()
	{
		return this.courseOutcome;
	}

	public void setCourseOutcome(CourseOutcome outcome)
	{
		this.courseOutcome = outcome;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "linkCourseOfferingOutcome")
	public Set<LinkCourseOfferingOutcomeCharacteristic> getLinkCourseOfferingOutcomeCharacteristics()
	{
		return this.linkCourseOfferingOutcomeCharacteristics;
	}

	public void setLinkCourseOfferingOutcomeCharacteristics(
			Set<LinkCourseOfferingOutcomeCharacteristic> linkCourseOfferingOutcomeCharacteristics)
	{
		this.linkCourseOfferingOutcomeCharacteristics = linkCourseOfferingOutcomeCharacteristics;
	}
	@Column(name = "display_index", nullable = false)
	public int getDisplayIndex() {
		return displayIndex;
	}

	public void setDisplayIndex(int displayIndex) {
		this.displayIndex = displayIndex;
	}

}
