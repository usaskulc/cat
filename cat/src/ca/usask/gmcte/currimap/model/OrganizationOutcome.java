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
 * Outcome generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "organization_outcome")
public class OrganizationOutcome implements java.io.Serializable, Comparable<OrganizationOutcome>
{

	private int id;
	private String name;
	private String description;
	private OrganizationOutcomeGroup group;

	public OrganizationOutcome()
	{
	}

	public int compareTo(OrganizationOutcome other)
	{
		return other.getId() - id;
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
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "organization_outcome_group_id")
	public OrganizationOutcomeGroup getGroup()
	{
		return group;
	}

	public void setGroup(OrganizationOutcomeGroup group)
	{
		this.group = group;
	}

}
