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
 * Outcome generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "program_outcome")
public class ProgramOutcome implements java.io.Serializable, Comparable<ProgramOutcome>
{

	private int id;
	private String name;
	private String description;
	private ProgramOutcomeGroup group;
	private Set<LinkProgramProgramOutcome> linkProgramProgramOutcomes = new HashSet<LinkProgramProgramOutcome>(0);

	public ProgramOutcome()
	{
	}

	public int compareTo(ProgramOutcome other)
	{
		return other.getId() - id;
	}
	
	public ProgramOutcome(int id, String name)
	{
		this.id = id;
		this.name = name;
	}

	public ProgramOutcome(int id, String name, String description,
			Set<LinkProgramProgramOutcome> linkProgramProgramOutcomes)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.linkProgramProgramOutcomes = linkProgramProgramOutcomes;
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

	@Column(name = "name", nullable = false, length = 500)
	@NotNull
	@Length(max = 500)
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
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "programOutcome")
	public Set<LinkProgramProgramOutcome> getLinkProgramProgramOutcomes()
	{
		return this.linkProgramProgramOutcomes;
	}

	public void setLinkProgramProgramOutcomes(Set<LinkProgramProgramOutcome> linkProgramProgramOutcomes)
	{
		this.linkProgramProgramOutcomes = linkProgramProgramOutcomes;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "program_outcome_group_id")
	public ProgramOutcomeGroup getGroup()
	{
		return group;
	}

	public void setGroup(ProgramOutcomeGroup group)
	{
		this.group = group;
	}
	

}
