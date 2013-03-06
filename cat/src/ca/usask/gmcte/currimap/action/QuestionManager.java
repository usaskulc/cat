package ca.usask.gmcte.currimap.action;


import java.util.List;
import java.util.TreeMap;


import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.AnswerOption;
import ca.usask.gmcte.currimap.model.AnswerSet;

import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.Question;
import ca.usask.gmcte.currimap.model.QuestionResponse;
import ca.usask.gmcte.currimap.model.QuestionType;

import ca.usask.gmcte.util.HibernateUtil;

public class QuestionManager
{
	private static QuestionManager instance;
	private static Logger logger = Logger.getLogger(QuestionManager.class);

	public boolean save(int id,String display, int answerSetId, int questionTypeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Question o = new Question();
			
			if(id > -1)
			{
				o = (Question)session.get(Question.class, id);
			}
			o.setDisplay(display);
			if(answerSetId > -1)
			{
				AnswerSet set = (AnswerSet)session.get(AnswerSet.class, answerSetId);
				o.setAnswerSet(set);
			}
			if(questionTypeId > -1)
			{
				QuestionType type = (QuestionType)session.get(QuestionType.class, questionTypeId);
				o.setQuestionType(type);
			}
			if(id > -1)
				session.update(o);
			else
				session.save(o);
			session.getTransaction().commit();
			return true;
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return false;
		}
	}

	public boolean saveAnswerOption(int id,String value, String display, int displayIndex, int answerSetId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			AnswerOption o = new AnswerOption();
			if( id > -1)
				o = (AnswerOption) session.get(AnswerOption.class,id);
			else
			{
				AnswerSet set = (AnswerSet)session.get(AnswerSet.class,  answerSetId);
				o.setAnswerSet(set);
			}
			o.setValue(value);
			o.setDisplay(display);
			
			if(id < 0)
			{
				int existingCount = session.createQuery("FROM AnswerOption WHERE answerSet.id=:answerSetId").setParameter("answerSetId", answerSetId).list().size();		
				o.setDisplayIndex(existingCount+1);
			}
			session.merge(o);
			session.getTransaction().commit();
			return true;
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public boolean moveAnswerOption(int toMoveId, String direction)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			AnswerOption toMove = (AnswerOption)session.get(AnswerOption.class,toMoveId);
			List<AnswerOption> existing = (List<AnswerOption>)session.createQuery("FROM AnswerOption WHERE answerSet.id=:answerSetId").setParameter("answerSetId", toMove.getAnswerSet().getId()).list();		
			if(direction.equals("up"))
			{
				AnswerOption prev = null;
				for(AnswerOption link : existing)
				{
					if(link.getId() == toMoveId && prev!=null)
					{
						int swap = prev.getDisplayIndex();
						prev.setDisplayIndex(link.getDisplayIndex());
						link.setDisplayIndex(swap);
						session.merge(prev);
						session.merge(prev);
						break;
					}
					prev = link;
				}
			}
			else if(direction.equals("down"))
			{
				AnswerOption prev = null;
				for(AnswerOption link : existing)
				{
					if(prev !=null)
					{
						int swap = prev.getDisplayIndex();
						prev.setDisplayIndex(link.getDisplayIndex());
						link.setDisplayIndex(swap);
						session.merge(prev);
						session.merge(link);
						break;
					}
					if(link.getId() == toMoveId)
					{
						prev = link;
					}
					
				}
			}
			else if(direction.equals("delete"))
			{
				AnswerOption toDelete = null;
				for(AnswerOption link : existing)
				{
					if(toDelete !=null)
					{
						link.setDisplayIndex(link.getDisplayIndex()-1);
						session.merge(link);
					}
					if(link.getId() == toMoveId)
					{
						toDelete = link;
					}
		
				}
			}
			session.getTransaction().commit();
			return true;
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return false;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Question> getAllQuestions()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Question> toReturn = null;
		try
		{
			toReturn = (List<Question>) session.createQuery("FROM Question ORDER BY display")
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<Question> getAllQuestionsForProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Question> toReturn = null;
		try
		{
			toReturn = (List<Question>) session.createQuery("SELECT distinct l.question FROM LinkProgramQuestion l WHERE l.program.id=:programId ORDER BY l.displayIndex")
					.setParameter("programId", program.getId())
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
 
	@SuppressWarnings("unchecked")
	public List<Question> getAllQuestionsNotUsedByProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Question> toReturn = null;
		try
		{
			toReturn = (List<Question>) session.createQuery("FROM Question WHERE id not in (SELECT l.question.id FROM LinkProgramQuestion l WHERE l.program.id=:programId) ORDER BY lower(display)")
					.setParameter("programId", program.getId())
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public Question getQuestionById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Question toReturn = null;
		try
		{
			toReturn = (Question) session.get(Question.class,id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public AnswerSet getAnswerSetById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		AnswerSet toReturn = null;
		try
		{
			toReturn = (AnswerSet) session.get(AnswerSet.class,id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<AnswerSet> getAllAnswerSets()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<AnswerSet> toReturn = null;
		try
		{
			toReturn = (List<AnswerSet>) session.createQuery("FROM AnswerSet ORDER BY name")
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<Question> getAllQuestionsWithResponsesForProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Question> toReturn = null;
		try
		{
			toReturn = (List<Question>) session.createQuery("SELECT distinct l.question FROM QuestionResponse l WHERE l.program.id=:programId")
					.setParameter("programId", program.getId())
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<QuestionResponse> getAllQuestionResponsesForProgramAndOffering(Program program, CourseOffering offering)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<QuestionResponse> toReturn = null;
		try
		{
			toReturn = (List<QuestionResponse>)session.createQuery("FROM QuestionResponse WHERE program.id=:programId AND courseOffering.id=:courseOfferingId").setParameter("programId", program.getId()).setParameter("courseOfferingId", offering.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<QuestionResponse> getAllQuestionResponsesForProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<QuestionResponse> toReturn = null;
		try
		{
			toReturn = (List<QuestionResponse>)session.createQuery("FROM QuestionResponse WHERE program.id=:programId").setParameter("programId", program.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<QuestionResponse> getAllQuestionResponsesForOffering(CourseOffering offering)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<QuestionResponse> toReturn = null;
		try
		{
			toReturn = (List<QuestionResponse>)session.createQuery("FROM QuestionResponse WHERE courseOffering.id=:courseOfferingId").setParameter("courseOfferingId", offering.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public boolean saveResponses(Program p, int courseOffering, TreeMap<String,String> responses)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CourseOffering offering = (CourseOffering)session.get(CourseOffering.class, courseOffering);
			
		
			for(String key : responses.keySet())
			{
				String questionIdString = key.split("_")[2];
				Question q = (Question)session.get(Question.class,Integer.parseInt(questionIdString));
				QuestionResponse response = (QuestionResponse)session
						.createQuery("FROM QuestionResponse WHERE program.id=:programId AND courseOffering.id=:courseOfferingId AND question.id=:questionId")
						.setParameter("programId", p.getId())
						.setParameter("courseOfferingId", courseOffering)
						.setParameter("questionId", q.getId())
					    .uniqueResult();
				if(response == null)
				{
					response = new QuestionResponse();
					response.setProgram(p);
					response.setCourseOffering(offering);
					response.setQuestion(q);
					response.setResponse(responses.get(key));
					session.save(response);
				}
				else
				{
					response.setResponse(responses.get(key));
					session.merge(response);
				}
			}
			session.getTransaction().commit();
			return true;
		}
		catch(Exception e)
		{
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			HibernateUtil.logException(logger, e);
			return false;
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public List<QuestionType> getQuestionTypes()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<QuestionType> toReturn = null;
		try
		{
			toReturn = (List<QuestionType>) session.createQuery("FROM QuestionType")
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public static QuestionManager instance()
	{
		if (instance == null)
		{
			instance = new QuestionManager();
		}
		return instance;

	}
	
	public String inString(List<Integer> in)
	{
		StringBuilder sb = new StringBuilder();
		for(int i : in)
		{
			sb.append(",");
			sb.append(i);
			
		}
		return sb.substring(1);
	}

}
