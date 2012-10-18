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
import javax.persistence.Transient;

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;



/**
 * CourseOffering generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "course_offering")
public class CourseOffering implements java.io.Serializable
{

	private int id;
	private String sectionNumber;
	private Course course;
	private String term;
	private String medium;
	private String comments;
	private int numStudents;
	private TimeItTook timeItTook;
	
	
	private Set<LinkCourseOfferingInstructor> instructors;
	
	private Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods = new HashSet<LinkCourseOfferingTeachingMethod>(0);
	private Set<LinkCourseOfferingOutcome> linkCourseOfferingOutcomes = new HashSet<LinkCourseOfferingOutcome>(0);
	private Set<LinkCourseOfferingAssessment> linkCourseOfferingAssessments = new HashSet<LinkCourseOfferingAssessment>(0);
	
	public CourseOffering()
	{
	}

	public CourseOffering(int id, String sectionNumber, String term)
	{
		this.id = id;
		this.sectionNumber = sectionNumber;
		this.term = term;
	}

	public CourseOffering(int id, String sectionNumber, String term,
			Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods,
			Set<LinkCourseOfferingOutcome> linkCourseOfferingOutcomes,
			Set<LinkCourseOfferingAssessment> linkCourseOfferingAssessments)
	{
		this.id = id;
		this.sectionNumber = sectionNumber;
		this.term = term;
		this.linkCourseOfferingTeachingMethods = linkCourseOfferingTeachingMethods;
		this.linkCourseOfferingOutcomes = linkCourseOfferingOutcomes;
		this.linkCourseOfferingAssessments = linkCourseOfferingAssessments;
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

	@Column(name = "section_number", nullable = false, length = 10)
	@NotNull
	@Length(max = 10)
	public String getSectionNumber()
	{
		return this.sectionNumber;
	}

	public void setSectionNumber(String sectionNumber)
	{
		this.sectionNumber = sectionNumber;
	}

	@Column(name = "medium", nullable = false, length = 20)
	@NotNull
	@Length(max = 20)
	public String getMedium()
	{
		return this.medium;
	}

	public void setMedium(String medium)
	{
		this.medium = medium;
	}
	
	@Column(name = "term", nullable = false, length = 6)
	@NotNull
	@Length(max = 6)
	public String getTerm()
	{
		return this.term;
	}

	public void setTerm(String term)
	{
		this.term = term;
	}

//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseOffering")
	@Transient
	public Set<LinkCourseOfferingTeachingMethod> getLinkCourseOfferingTeachingMethods()
	{
		return this.linkCourseOfferingTeachingMethods;
	}

	public void setLinkCourseOfferingTeachingMethods(
			Set<LinkCourseOfferingTeachingMethod> linkCourseOfferingTeachingMethods)
	{
		this.linkCourseOfferingTeachingMethods = linkCourseOfferingTeachingMethods;
	}

//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseOffering")
	@Transient
	public Set<LinkCourseOfferingOutcome> getLinkCourseOfferingOutcomes()
	{
		return this.linkCourseOfferingOutcomes;
	}

	public void setLinkCourseOfferingOutcomes(Set<LinkCourseOfferingOutcome> linkCourseOfferingOutcomes)
	{
		this.linkCourseOfferingOutcomes = linkCourseOfferingOutcomes;
	}

//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseOffering")
	@Transient
	public Set<LinkCourseOfferingAssessment> getLinkCourseOfferingAssessments()
	{
		return this.linkCourseOfferingAssessments;
	}

	public void setLinkCourseOfferingAssessments(
			Set<LinkCourseOfferingAssessment> linkCourseOfferingAssessments)
	{
		this.linkCourseOfferingAssessments = linkCourseOfferingAssessments;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "course_id", nullable = false)
	@NotNull
	public Course getCourse()
	{
		return course;
	}

	public void setCourse(Course course)
	{
		this.course = course;
	}
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "courseOffering")
	public Set<LinkCourseOfferingInstructor> getInstructors()
	{
		return this.instructors;
	}
	
	public void setInstructors(Set<LinkCourseOfferingInstructor> instructors)
	{
		this.instructors = instructors;
	}
	@Column(name = "comments", nullable = true, length = 65000)
	@Length(max = 65000)
	public String getComments()
	{
		return comments;
	}

	public void setComments(String comments)
	{
		this.comments = comments;
	}
	
	@Column(name = "num_students", unique = true, nullable = true)
	public int getNumStudents()
	{
		return numStudents;
	}

	public void setNumStudents(int numStudents)
	{
		this.numStudents = numStudents;
	}
	@Transient
	public String getDisplay()
	{
		return term + " section " + sectionNumber;
	}
	@Transient
	public String getFullDisplay()
	{
		return course.getSubject() + course.getCourseNumber() + " " + term + " " + sectionNumber;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "time_it_took_id")
	public TimeItTook getTimeItTook() 
	{
		return timeItTook;
	}

	public void setTimeItTook(TimeItTook timeItTook) 
	{
		this.timeItTook = timeItTook;
	}
	
}
