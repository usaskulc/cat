package ca.usask.gmcte.currimap.model;

// Generated Dec 3, 2011 11:40:19 AM by Hibernate Tools 3.2.4.GA

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.validator.NotNull;

/**
 * LinkCourseOfferingTeachingMethod generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "link_course_offering_teaching_method")
public class LinkCourseOfferingTeachingMethod implements java.io.Serializable
{

	private int id;
	private CourseOffering courseOffering;
	private TeachingMethodPortionOption howLong;
	private TeachingMethod teachingMethod;

	public LinkCourseOfferingTeachingMethod()
	{
	}

	public LinkCourseOfferingTeachingMethod(int id, CourseOffering courseOffering,
			TeachingMethod teachingMethod)
	{
		this.id = id;
		this.courseOffering = courseOffering;
		this.teachingMethod = teachingMethod;
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

	@ManyToOne(fetch = FetchType.LAZY)
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
	@JoinColumn(name = "teaching_method_id", nullable = false)
	@NotNull
	public TeachingMethod getTeachingMethod()
	{
		return this.teachingMethod;
	}

	public void setTeachingMethod(TeachingMethod teachingMethod)
	{
		this.teachingMethod = teachingMethod;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "teaching_method_portion_option_id", nullable = false)
	@NotNull
	public TeachingMethodPortionOption getHowLong()
	{
		return howLong;
	}

	public void setHowLong(TeachingMethodPortionOption howLong)
	{
		this.howLong = howLong;
	}

}
