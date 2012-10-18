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
 * LinkCourseAssessment generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "link_course_prerequisite")
public class LinkCoursePrerequisite implements java.io.Serializable
{

	private int id;
	private Course course;
	private Course prerequisite;


	public LinkCoursePrerequisite()
	{
	}

	public LinkCoursePrerequisite(int id, Course course, Course p)
	{
		this.id = id;
		this.course = course;
		this.prerequisite = p;
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
	@JoinColumn(name = "course_id", nullable = false)
	@NotNull
	public Course getCourse()
	{
		return this.course;
	}

	public void setCourse(Course course)
	{
		this.course = course;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "prerequisite_id", nullable = false)
	@NotNull
	public Course getPrerequisite()
	{
		return this.prerequisite;
	}

	public void setPrerequisite(Course p)
	{
		this.prerequisite = p;
	}
}
