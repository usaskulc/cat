package ca.usask.gmcte.currimap.model;

// Generated Dec 3, 2011 11:40:19 AM by Hibernate Tools 3.2.4.GA

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

/**
 * Outcome generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "program_outcome_group")
public class ProgramOutcomeGroup implements java.io.Serializable, Comparable<CourseOutcomeGroup>
{

	private int id;
	private String name;
	private String programSpecific;
	private int programId;

	public ProgramOutcomeGroup()
	{
	}

	public int compareTo(CourseOutcomeGroup other)
	{
		return other.getId() - id;
	}
	
	public ProgramOutcomeGroup(int id, String name)
	{
		this.id = id;
		this.name = name;
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

	@Column(name = "name", nullable = false, length = 250)
	@NotNull
	@Length(max = 250)
	public String getName()
	{
		return this.name;
	}

	public void setName(String name)
	{
		this.name = name;
	}
	
	@Column(name = "program_specific", nullable = false, length = 1)
	@NotNull
	@Length(max = 1)
	public String getProgramSpecific()
	{
		return this.programSpecific;
	}

	public void setProgramSpecific(String p)
	{
		this.programSpecific = p;
	}
	
	
	@Column(name = "program_id", nullable = false)
	public int getProgramId()
	{
		return programId;
	}

	public void setProgramId(int programId)
	{
		this.programId = programId;
	}

}
