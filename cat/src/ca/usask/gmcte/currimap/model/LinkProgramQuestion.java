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



/**
 * CourseOffering generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "link_program_question")
public class LinkProgramQuestion implements java.io.Serializable
{

	private int id;
	private Program program;
	private Question question;
	private int displayIndex;

	public LinkProgramQuestion()
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "program_id", nullable = false)
	@NotNull
	public Program getProgram() {
		return program;
	}

	public void setProgram(Program program) {
		this.program = program;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "question_id")
	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	@Column(name = "display_index", nullable = false)
	public int getDisplayIndex() {
		return displayIndex;
	}

	public void setDisplayIndex(int displayIndex) {
		this.displayIndex = displayIndex;
	}

}