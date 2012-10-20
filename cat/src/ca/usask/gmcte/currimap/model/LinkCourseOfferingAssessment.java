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

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

/**
 * LinkCourseOfferingAssessment generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "link_course_offering_assessment")
public class LinkCourseOfferingAssessment implements java.io.Serializable
{

	private int id;
	private CourseOffering courseOffering;
	private Assessment assessment;
	private double weight;
	private AssessmentTimeOption when;
	private String additionalInfo;
	private String criterionExists;
	private String criterionSubmitted;
	private String criterionCompleted;
	private double criterionLevel;
	

	public LinkCourseOfferingAssessment()
	{
	}

	public LinkCourseOfferingAssessment(int id, CourseOffering courseOffering, Assessment assessment,
			double weight)
	{
		this.id = id;
		this.courseOffering = courseOffering;
		this.assessment = assessment;
		this.weight = weight;
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
	@JoinColumn(name = "assessment_id", nullable = false)
	@NotNull
	public Assessment getAssessment()
	{
		return this.assessment;
	}

	public void setAssessment(Assessment assessment)
	{
		this.assessment = assessment;
	}

	@Column(name = "weight", nullable = false, precision = 5, scale = 3)
	public double getWeight()
	{
		return this.weight;
	}

	public void setWeight(double weight)
	{
		this.weight = weight;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "assessment_time_option_id", nullable = false)
	@NotNull
	public AssessmentTimeOption getWhen()
	{
		return when;
	}

	public void setWhen(AssessmentTimeOption when)
	{
		this.when = when;
	}


	@Column(name = "additional_info", nullable = true, length = 1000)
	@Length(max = 1000)
	public String getAdditionalInfo()
	{
		return additionalInfo;
	}

	public void setAdditionalInfo(String additionalInfo)
	{
		this.additionalInfo = additionalInfo;
	}

	@Column(name = "criterion_exists", nullable = false, length = 1)
	@Length(max = 1)
	public String getCriterionExists() {
		return criterionExists;
	}

	public void setCriterionExists(String criterionExists) {
		this.criterionExists = criterionExists;
	}
	
	@Column(name = "criterion_level", nullable = false, precision = 5, scale = 3)
	public double getCriterionLevel() {
		return criterionLevel;
	}

	public void setCriterionLevel(double criterionLevel) {
		this.criterionLevel = criterionLevel;
	}
	@Column(name = "criterion_submit_required", nullable = false, length = 1)
	@Length(max = 1)
	public String getCriterionSubmitted() {
		return criterionSubmitted;
	}

	public void setCriterionSubmitted(String criterionSubmitted) {
		this.criterionSubmitted = criterionSubmitted;
	}
	@Column(name = "criterion_completion_required", nullable = false, length = 1)
	@Length(max = 1)
	public String getCriterionCompleted() {
		return criterionCompleted;
	}

	public void setCriterionCompleted(String criterionCompleted) {
		this.criterionCompleted = criterionCompleted;
	}

}
