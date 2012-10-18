package ca.usask.gmcte.currimap.model;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;


@SuppressWarnings("serial")
@Entity
@Table(name = "time_it_took")
public class TimeItTook implements java.io.Serializable
{

	private int id;
	private String name;
	private int calculationValue;
	private int displayIndex;
	
	public TimeItTook()
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

	
	@Column(name = "display_index", nullable = false)
	public int getDisplayIndex()
	{
		return this.displayIndex;
	}

	public void setDisplayIndex(int displayIndex)
	{
		this.displayIndex = displayIndex;
	}

	@Column(name = "calculation_value", nullable = false)
	public int getCalculationValue() 
	{
		return calculationValue;
	}


	public void setCalculationValue(int calculationValue) 
	{
		this.calculationValue = calculationValue;
	}

}
