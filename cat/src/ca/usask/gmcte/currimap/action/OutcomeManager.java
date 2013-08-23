/*****************************************************************************
 * Copyright 2012, 2013 University of Saskatchewan
 *
 * This file is part of the Curriculum Alignment Tool (CAT).
 *
 * CAT is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 *(at your option) any later version.
 *
 * CAT is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with CAT.  If not, see <http://www.gnu.org/licenses/>.
 *
 ****************************************************************************/


package ca.usask.gmcte.currimap.action;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Characteristic;
import ca.usask.gmcte.currimap.model.CharacteristicType;
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.CourseOutcome;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.LinkAssessmentCourseOutcome;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingAssessment;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingOutcome;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingOutcomeCharacteristic;
import ca.usask.gmcte.currimap.model.LinkCourseOutcomeProgramOutcome;
import ca.usask.gmcte.currimap.model.LinkOrganizationOrganizationOutcome;
import ca.usask.gmcte.currimap.model.LinkProgramProgramOutcome;
import ca.usask.gmcte.currimap.model.LinkProgramProgramOutcomeCharacteristic;
import ca.usask.gmcte.currimap.model.OrganizationOutcome;
import ca.usask.gmcte.currimap.model.OrganizationOutcomeGroup;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.ProgramOutcome;
import ca.usask.gmcte.currimap.model.ProgramOutcomeGroup;
import ca.usask.gmcte.util.HibernateUtil;

public class OutcomeManager
{
	public static String noMatchName = "No match to a course outcome";
	private static OutcomeManager instance;
	private static Logger logger = Logger.getLogger( OutcomeManager.class );

	public boolean saveCharacteristic(int courseOfferingId, int outcomeId, String characteristicValue, String characteristicType, String creatorUserid)
	{
		return saveCharacteristic(courseOfferingId, outcomeId, characteristicValue, characteristicType, creatorUserid, false);
	}
	
	public boolean saveCharacteristic(int id, int outcomeId, String characteristicValue, String characteristicType, String creatorUserid, boolean isProgram)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkCourseOfferingOutcome lco = null;
			LinkProgramProgramOutcome lpo = null;
			if(isProgram)
			{
				ProgramOutcome outcome = (ProgramOutcome) session.get(ProgramOutcome.class, outcomeId);
				Program program = (Program)session.get(Program.class,id);
				lpo = getLinkProgramProgramOutcome(program, outcome,session);
					
			}
			else
			{
				CourseOutcome outcome = (CourseOutcome) session.get(CourseOutcome.class, outcomeId);
				CourseOffering courseOffering = (CourseOffering)session.get(CourseOffering.class,id);
				lco = getLinkCourseOfferingOutcome(courseOffering, outcome,session);
			}
			CharacteristicType cType =  getCharacteristicTypeById(Integer.parseInt(characteristicType), session);
			Characteristic characteristic = null;
			
			if(cType.getValueType().equals("String"))
			{
				characteristic = this.getCharacteristicById(Integer.parseInt(characteristicValue),session);
			}
			else if(cType.getValueType().equals("Boolean"))
			{
				characteristic = this.getCharacteristicByNameAndTypeId(characteristicValue,Integer.parseInt(characteristicType),session);
			}
			if(isProgram)
			{
				LinkProgramProgramOutcomeCharacteristic characteristicLink = new LinkProgramProgramOutcomeCharacteristic();
				characteristicLink.setCharacteristic(characteristic);
				characteristicLink.setCreatedByUserid(creatorUserid);
				characteristicLink.setCreatedOn(new Date(System.currentTimeMillis()));
				characteristicLink.setLinkProgramProgramOutcome(lpo);
				session.save(characteristicLink);
			}
			else
			{
				LinkCourseOfferingOutcomeCharacteristic characteristicLink = new LinkCourseOfferingOutcomeCharacteristic();
				characteristicLink.setCharacteristic(characteristic);
				characteristicLink.setCreatedByUserid(creatorUserid);
				characteristicLink.setCreatedOn(new Date(System.currentTimeMillis()));
				characteristicLink.setLinkCourseOfferingOutcome(lco);
				session.save(characteristicLink);
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
	
	public CourseOutcome getNoMatchOutcome()
	{
	     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
         session.beginTransaction();
         CourseOutcome c = null;
         
         try
         {
                 c = (CourseOutcome) session.createQuery("FROM CourseOutcome WHERE name=:name").setParameter("name", OutcomeManager.noMatchName).uniqueResult();
                 if(c == null)
                 {
                	 c = new CourseOutcome();
                	 c.setName(OutcomeManager.noMatchName);
                	 session.save(c);
                 }
                 session.getTransaction().commit();
         }
         catch(Exception e)
         {
                 HibernateUtil.logException(logger, e);
         }
         return c;
		
	}
	public boolean updateCharacteristic(int courseOfferingId, int outcomeId, String characteristicValue, String characteristicType)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CourseOutcome outcome = (CourseOutcome) session.get(CourseOutcome.class, outcomeId);
			CourseOffering courseOffering = (CourseOffering)session.get(CourseOffering.class,courseOfferingId);
			LinkCourseOfferingOutcome lco = getLinkCourseOfferingOutcome(courseOffering, outcome,session);
			CharacteristicType cType =  getCharacteristicTypeById(Integer.parseInt(characteristicType), session);
			Characteristic characteristic = null;
			if(cType.getValueType().equals("String"))
			{
				characteristic = this.getCharacteristicById(Integer.parseInt(characteristicValue),session);
			}
			else if(cType.getValueType().equals("Boolean"))
			{
				characteristic = this.getCharacteristicByNameAndTypeId(characteristicValue,Integer.parseInt(characteristicType),session);
			}
			
			LinkCourseOfferingOutcomeCharacteristic characteristicLink = this.getCharacteristicLinkWithType(cType, lco,session);
			boolean createNew = false;
			if (characteristicLink == null)
			{
				characteristicLink = new LinkCourseOfferingOutcomeCharacteristic();
				characteristicLink.setLinkCourseOfferingOutcome(lco);
				createNew = true;
			}
			characteristicLink.setCharacteristic(characteristic);
			characteristicLink.setCreatedByUserid("website");
			characteristicLink.setCreatedOn(new Date(System.currentTimeMillis()));
			if(createNew)
				session.save(characteristicLink);
			else
				session.merge(characteristicLink);
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
	public CourseOutcome getCourseOutcomeById(int id)
    {
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            CourseOutcome c = null;
            try
            {
                    c = (CourseOutcome) session.get(CourseOutcome.class, id);
                    session.getTransaction().commit();
            }
            catch(Exception e)
            {
                    HibernateUtil.logException(logger, e);
            }
            return c;
    }
	public boolean updateProgramOutcomeCharacteristic(int linkId, String characteristicValue, String characteristicType, String creatorUserid)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkProgramProgramOutcome lpo = (LinkProgramProgramOutcome)session.get(LinkProgramProgramOutcome.class, linkId);
			CharacteristicType cType =  getCharacteristicTypeById(Integer.parseInt(characteristicType), session);
			Characteristic characteristic = null;
			
			if(cType.getValueType().equals("String"))
			{
				characteristic = this.getCharacteristicById(Integer.parseInt(characteristicValue),session);
			}
			else if(cType.getValueType().equals("Boolean"))
			{
				characteristic = this.getCharacteristicByNameAndTypeId(characteristicValue,Integer.parseInt(characteristicType),session);
			}
			LinkProgramProgramOutcomeCharacteristic characteristicLink = this.getCharacteristicLinkWithType(cType, lpo,session);
			if (characteristicLink == null)
			{
				characteristicLink = new LinkProgramProgramOutcomeCharacteristic();
				characteristicLink.setLinkProgramProgramOutcome(lpo);
				characteristicLink.setCharacteristic(characteristic);
				characteristicLink.setCreatedByUserid(creatorUserid);
				characteristicLink.setCreatedOn(new Date(System.currentTimeMillis()));
				session.save(characteristicLink);
			}
			else
			{
				characteristicLink.setCharacteristic(characteristic);
				characteristicLink.setCreatedByUserid(creatorUserid);
				characteristicLink.setCreatedOn(new Date(System.currentTimeMillis()));
				session.merge(characteristicLink);
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
	public boolean saveNewProgramOutcome(String name,String programId,String description,String programSpecific)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			ProgramOutcome outcome = new ProgramOutcome();
			outcome.setDescription(description);
			outcome.setName(name);
			ProgramOutcomeGroup group = null;
			if (programSpecific.equals("true"))
			{
				group = (ProgramOutcomeGroup)session.createQuery("from ProgramOutcomeGroup og WHERE og.programId = :programId AND og.name like '%Custom'")
							.setParameter("programId",Integer.parseInt(programId))
							.uniqueResult();
				if(group == null)
				{
					Program p = (Program)session.get(Program.class,Integer.parseInt(programId));
					group = new ProgramOutcomeGroup();
					group.setName(p.getName()+" Custom");
					group.setProgramId(p.getId());
					group.setProgramSpecific("Y");
					session.save(group);
				}
					
			}
			else
			{
					group = (ProgramOutcomeGroup)session.createQuery("from ProgramOutcomeGroup og WHERE og.programId = -1 AND og.name = 'Custom'")
								.uniqueResult();
					if(group == null)
					{
						group = new ProgramOutcomeGroup();
						group.setName("Custom");
						group.setProgramId(-1);
						group.setProgramSpecific("N");
						session.save(group);
					}
			}
			outcome.setGroup(group);
			session.save(outcome);
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
	
	public boolean deleteOutcomeObject(String object, int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			if(object.equals("ProgramOutcome"))
			{
				ProgramOutcome o = (ProgramOutcome) session.get(ProgramOutcome.class,id);
				session.delete(o);
			}
			else if(object.equals("ProgramOutcomeGroup"))
			{
				ProgramOutcomeGroup o = (ProgramOutcomeGroup) session.get(ProgramOutcomeGroup.class,id);
				session.delete(o);
			}
			else if(object.equals("OrganizationOutcome"))
			{
				OrganizationOutcome o = (OrganizationOutcome) session.get(OrganizationOutcome.class,id);
				session.delete(o);
			}
			else if(object.equals("OrganizationOutcomeGroup"))
			{
				OrganizationOutcomeGroup o = (OrganizationOutcomeGroup) session.get(OrganizationOutcomeGroup.class,id);
				session.delete(o);
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

	public boolean saveOrganizationOutcomeLink(int organizationId, int outcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcome outcome = (OrganizationOutcome)session.get(OrganizationOutcome.class,outcomeId);
			Organization organization = (Organization)session.get(Organization.class,organizationId);
			LinkOrganizationOrganizationOutcome loo = this.getLinkOrganizationOrganizationOutcome(organization, outcome, session);
			if(loo == null)
			{
				loo = new LinkOrganizationOrganizationOutcome();
				loo.setOrganization(organization);
				loo.setOrganizationOutcome(outcome);
				session.save(loo);
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
	
	public boolean saveProgramOutcomeLink(int programId, int outcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			ProgramOutcome outcome = (ProgramOutcome)session.get(ProgramOutcome.class,outcomeId);
			Program program = (Program)session.get(Program.class,programId);
			LinkProgramProgramOutcome lpo = getLinkProgramOutcome(program, outcome,session);
			if(lpo == null)
			{
				lpo = new LinkProgramProgramOutcome();
				lpo.setProgram(program);
				lpo.setProgramOutcome(outcome);
				session.save(lpo);
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

	public int saveCourseOfferingOutcomeLink(int courseOfferingId, String outcomeName, int outcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			
			CourseOutcome outcome = new CourseOutcome();
			if(outcomeId > -1)
			{
				outcome = (CourseOutcome) session.get(CourseOutcome.class,outcomeId);
				outcome.setName(outcomeName);
				session.merge(outcome);
				logger.debug("Saved new value ["+outcomeName+"] for id "+outcomeId);
			}
			else
			{
				outcome.setName(outcomeName);
				outcome.setDescription("");
				session.save(outcome);
			}
			CourseOffering courseOffering = (CourseOffering)session.get(CourseOffering.class,courseOfferingId);
			LinkCourseOfferingOutcome lco = getLinkCourseOfferingOutcome(courseOffering, outcome,session);
			if(lco == null)
			{
				int existingCount = session.createQuery("FROM LinkCourseOfferingOutcome WHERE courseOffering.id=:offeringId").setParameter("offeringId", courseOfferingId).list().size();		
				lco = new LinkCourseOfferingOutcome();
				lco.setCourseOffering(courseOffering);
				lco.setCourseOutcome(outcome);
				lco.setDisplayIndex(existingCount+1);
				session.save(lco);
			}
			session.getTransaction().commit();
			return outcome.getId();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return -1;
		}
	}
	
	public boolean moveLinkCourseOfferingOutcome(int toMoveId, int courseOfferingId, String direction)
	{
		//when moving up, find the one to be moved (while keeping track of the previous one) and swap display_index values
		//when moving down, find the one to be moved, swap displayIndex values of it and the next one
		//when deleting, reduce all links following one to be deleted by 1
		boolean done = false;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			@SuppressWarnings("unchecked")
			List<LinkCourseOfferingOutcome> existing = (List<LinkCourseOfferingOutcome>)session.createQuery("select l from LinkCourseOfferingOutcome l where l.courseOffering.id = :offeringId order by l.displayIndex").setParameter("offeringId",courseOfferingId).list();
			if(direction.equals("up"))
			{
				LinkCourseOfferingOutcome prev = null;
				for(LinkCourseOfferingOutcome link : existing)
				{
					if(link.getCourseOutcome().getId() == toMoveId && prev!=null)
					{
						int swap = prev.getDisplayIndex();
						prev.setDisplayIndex(link.getDisplayIndex());
						link.setDisplayIndex(swap);
						session.merge(prev);
						session.merge(prev);
						done = true;
						break;
					}
					prev = link;
				}
			}
			else if(direction.equals("down"))
			{
				LinkCourseOfferingOutcome prev = null;
				for(LinkCourseOfferingOutcome link : existing)
				{
					if(prev !=null)
					{
						int swap = prev.getDisplayIndex();
						prev.setDisplayIndex(link.getDisplayIndex());
						link.setDisplayIndex(swap);
						session.merge(prev);
						session.merge(link);
						done = true;
						break;
					}
					if(link.getCourseOutcome().getId() == toMoveId)
					{
						prev = link;
					}
					
				}
			}
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return false;
		}
		return done;
	}
	public boolean deleteCourseOfferingOutcome(int outcomeId, int courseOfferingId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
	
			
			@SuppressWarnings("unchecked")
			List<LinkCourseOfferingOutcome> existing = (List<LinkCourseOfferingOutcome>)session.createQuery("select l from LinkCourseOfferingOutcome l where l.courseOffering.id = :offeringId order by l.displayIndex").setParameter("offeringId",courseOfferingId).list();
				
			LinkCourseOfferingOutcome toDelete = null;
			for(LinkCourseOfferingOutcome link : existing)
			{
				if(toDelete !=null)
				{
					link.setDisplayIndex(link.getDisplayIndex()-1);
					session.merge(link);
				}
				if(link.getCourseOutcome().getId() == outcomeId)
				{
					toDelete = link;
				}
				
			}

			if(toDelete !=null)
			{
				Set<LinkCourseOfferingOutcomeCharacteristic> existingCharacteristics = toDelete.getLinkCourseOfferingOutcomeCharacteristics();
				for(LinkCourseOfferingOutcomeCharacteristic linkToDelete : existingCharacteristics)
				{
					session.delete(linkToDelete);
				}
				List<LinkCourseOutcomeProgramOutcome> existingLinks = ProgramManager.instance().getProgramOutcomeLinksForCourseOutcome(courseOfferingId, outcomeId,session);
				for(LinkCourseOutcomeProgramOutcome programLinktoDelete : existingLinks)
				{
					session.delete(programLinktoDelete);
				}
				@SuppressWarnings("unchecked")
				List<LinkAssessmentCourseOutcome> existingAssessmentLinks =  (List<LinkAssessmentCourseOutcome>)session.createQuery("from LinkAssessmentCourseOutcome l where l.courseOffering.id=:courseOfferingId AND l.outcome.id=:outcomeId")
				          .setParameter("courseOfferingId",courseOfferingId)
				          .setParameter("outcomeId",outcomeId)
				          .list();
				for(LinkAssessmentCourseOutcome assessmentLinktoDelete : existingAssessmentLinks)
				{
					session.delete(assessmentLinktoDelete);
				}
			
			
				session.refresh(toDelete);
				session.delete(toDelete);
			}

			
		
			
			
		//	CourseOutcome toDelete = (CourseOutcome)session.get(CourseOutcome.class, outcomeId);
		//	session.delete(toDelete);
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
	public int saveProgramOutcomeLink(int programId, String outcomeName, int programOutcomeGroupId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			
			ProgramOutcome outcome = new ProgramOutcome();
			ProgramOutcomeGroup programOutcomeGroup = (ProgramOutcomeGroup)session.get(ProgramOutcomeGroup.class,programOutcomeGroupId);
			outcome.setName(outcomeName);
			outcome.setDescription("");
			outcome.setGroup(programOutcomeGroup);
			session.save(outcome);
			
			Program program = (Program)session.get(Program.class,programId);
			LinkProgramProgramOutcome lpo = new LinkProgramProgramOutcome();
			lpo.setProgram(program);
			lpo.setProgramOutcome(outcome);
		
			session.save(lpo);
			session.getTransaction().commit();
			return outcome.getId();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return -1;
		}
	}

	public boolean saveProgramOutcome(String outcomeName, int programOutcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			
			ProgramOutcome outcome = (ProgramOutcome)session.get(ProgramOutcome.class, programOutcomeId);
			outcome.setName(outcomeName);
			session.merge(outcome);
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
	public boolean update(String id,String name, String description, String programSpecific)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
/*
		Outcome c = (Outcome) session.get(Outcome.class, Integer.parseInt(id));
		c.setName(name);
		c.setDescription(description);
		c.setProgramSpecific(programSpecific);
		session.merge(c);*/
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
	public LinkProgramProgramOutcome getLinkProgramOutcome(Program program, ProgramOutcome outcome, Session session)
	{
		LinkProgramProgramOutcome link = (LinkProgramProgramOutcome)session.createQuery("from LinkProgramProgramOutcome lpo WHERE lpo.program.id=:programId and lpo.programOutcome.id=:outcomeId ")
				.setParameter("programId",program.getId())
				.setParameter("outcomeId",outcome.getId())
				.uniqueResult();
		return link;
	}
	public LinkOrganizationOrganizationOutcome getLinkOrganizationOrganizationOutcome(Organization o, OrganizationOutcome outcome, Session session)
	{
		LinkOrganizationOrganizationOutcome link = (LinkOrganizationOrganizationOutcome)session.createQuery("from LinkOrganizationOrganizationOutcome lpo WHERE lpo.organization.id=:orgId and lpo.organizationOutcome.id=:outcomeId ")
				.setParameter("orgId", o.getId())
				.setParameter("outcomeId",outcome.getId())
				.uniqueResult();
		return link;
	}
	public LinkCourseOfferingOutcome getLinkCourseOfferingOutcome(CourseOffering courseOffering, CourseOutcome outcome, Session session)
	{
		LinkCourseOfferingOutcome link = (LinkCourseOfferingOutcome)session.createQuery("from LinkCourseOfferingOutcome lco WHERE lco.courseOffering.id=:courseOfferingId and lco.courseOutcome.id=:outcomeId ")
				.setParameter("courseOfferingId",courseOffering.getId())
				.setParameter("outcomeId",outcome.getId())
				.uniqueResult();
		return link;
	}
	public LinkProgramProgramOutcome getLinkProgramProgramOutcomeById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		LinkProgramProgramOutcome toReturn = null;
		try
		{
			toReturn = (LinkProgramProgramOutcome) session.get(LinkProgramProgramOutcome.class,  id);
			session.getTransaction().commit();
			
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
		}
		return toReturn;
	}
	
	public LinkProgramProgramOutcome getLinkProgramProgramOutcome(Program program, ProgramOutcome outcome, Session session)
	{
		LinkProgramProgramOutcome link = (LinkProgramProgramOutcome)session.createQuery("from LinkProgramProgramOutcome lpo WHERE lpo.program.id=:programId and lpo.programOutcome.id=:outcomeId ")
				.setParameter("programId",program.getId())
				.setParameter("outcomeId",outcome.getId())
				.uniqueResult();
		return link;
	}
	
	public LinkCourseOfferingOutcomeCharacteristic getCharacteristicLinkWithType(CharacteristicType cType, LinkCourseOfferingOutcome lco, Session session)
	{
		return (LinkCourseOfferingOutcomeCharacteristic)session
				.createQuery("FROM LinkCourseOfferingOutcomeCharacteristic WHERE linkCourseOfferingOutcome.id=:lcoId AND characteristic.characteristicType.id=:cTypeId")
				.setParameter("lcoId", lco.getId())
				.setParameter("cTypeId",cType.getId())
				.uniqueResult();
	}
	public LinkProgramProgramOutcomeCharacteristic getCharacteristicLinkWithType(CharacteristicType cType, LinkProgramProgramOutcome lpo, Session session)
	{
		return (LinkProgramProgramOutcomeCharacteristic)session
				.createQuery("FROM LinkProgramProgramOutcomeCharacteristic WHERE linkProgramProgramOutcome.id=:lpoId AND characteristic.characteristicType.id=:cTypeId")
				.setParameter("lpoId", lpo.getId())
				.setParameter("cTypeId",cType.getId())
				.uniqueResult();
	}
	
	public CourseOutcome getOutcomeById(String id)
	{
		return getOutcomeById(Integer.parseInt( id));
	}

	
	public CourseOutcome getOutcomeById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		CourseOutcome c = null;
		try
		{
			c = (CourseOutcome) session.get(CourseOutcome.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
	}
	public Characteristic getCharacteristicById(String id)
	{
		return getCharacteristicById(Integer.parseInt(id));
	}
	public Characteristic getCharacteristicById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Characteristic c = null;
		try
		{
			c = (Characteristic) session.get(Characteristic.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
	}
	public Characteristic getCharacteristicById(int id,Session session)
	{
		Characteristic c = (Characteristic) session.get(Characteristic.class, id);
		return c;
	}
	public CharacteristicType getCharacteristicTypeById(String id)
	{
		return getCharacteristicTypeById(Integer.parseInt(id));
	}
	public CharacteristicType getCharacteristicTypeById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		CharacteristicType c = null;
		try
		{
			c = (CharacteristicType) session.get(CharacteristicType.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
	}
	
	public Characteristic getCharacteristicByNameAndTypeId(String value, int typeId,Session session)
	{
		Characteristic c = (Characteristic) session.createQuery("select c from Characteristic c where c.characteristicType.id = :ctId and c.name = :value")
				.setParameter("ctId",typeId)
				.setParameter("value",value)
				.uniqueResult();
		return c;
	}
	public CharacteristicType getCharacteristicTypeById(int id,Session session)
	{
		CharacteristicType c = (CharacteristicType) session.get(CharacteristicType.class, id);
		return c;
	}
	public LinkCourseOfferingOutcome getLinkCourseOfferingOutcomeById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		LinkCourseOfferingOutcome c = null;
		try
		{
			c = (LinkCourseOfferingOutcome) session.get(LinkCourseOfferingOutcome.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
	}
	@SuppressWarnings("unchecked")
	public List<LinkAssessmentCourseOutcome> getLinkAssessmentCourseOutcomesForCourses(List<String> courseIds)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkAssessmentCourseOutcome> toReturn = null;
		try
		{
			toReturn =  (List<LinkAssessmentCourseOutcome>)session.createQuery("FROM LinkAssessmentCourseOutcome l WHERE "
		            + HibernateUtil.getListAsString(" l.courseOffering.course.id ",courseIds, false, false) 
		            + " ORDER BY l.courseOffering.course.subject, l.courseOffering.course.courseNumber, l.courseOffering.term, l.courseOffering.sectionNumber,l.id").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public List<LinkAssessmentCourseOutcome> getLinkAssessmentCourseOutcomes(int courseOfferingId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkAssessmentCourseOutcome> toReturn = null;
		try
		{
			toReturn = getLinkAssessmentCourseOutcomes(courseOfferingId, session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<LinkAssessmentCourseOutcome> getLinkAssessmentCourseOutcomes(int courseOfferingId, Session session)
	{
		return (List<LinkAssessmentCourseOutcome>)session.createQuery("from LinkAssessmentCourseOutcome where courseOffering.id=:courseOfferingId order by assessmentLink.when.displayIndex")
					          .setParameter("courseOfferingId",courseOfferingId).list();

	}
	
	public boolean addOutcomeAssessmentLink(int courseOfferingId, int outcomeId, int assessmentLinkId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkAssessmentCourseOutcome toSave = new LinkAssessmentCourseOutcome();
			CourseOffering offering = (CourseOffering) session.get(CourseOffering.class,courseOfferingId);
			CourseOutcome outcome = (CourseOutcome) session.get(CourseOutcome.class,  outcomeId);
			LinkCourseOfferingAssessment link = (LinkCourseOfferingAssessment)session.get(LinkCourseOfferingAssessment.class,  assessmentLinkId);
			
			toSave.setAssessmentLink(link);
			toSave.setCourseOffering(offering);
			toSave.setOutcome(outcome);
			session.save(toSave);
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
	
	public boolean deleteOutcomeAssessmentLink(int linkToDelete)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkAssessmentCourseOutcome link = (LinkAssessmentCourseOutcome)session.get(LinkAssessmentCourseOutcome.class, linkToDelete);
			session.delete(link);
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
	public List<Characteristic> getCharacteristicsForType(CharacteristicType ct)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> toReturn = null;
		try
		{
			toReturn = (List<Characteristic>)session.createQuery("select c from Characteristic c where c.characteristicType.id = :ctId order by c.displayIndex").setParameter("ctId",ct.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public List<Characteristic> getCharacteristicsForCourseOfferingOutcome(CourseOffering courseOffering, CourseOutcome o, Organization organization)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> list = null;
		try
		{
			list = getCharacteristicsForCourseOfferingOutcome(courseOffering,o,organization,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}

	public List<Characteristic> getCharacteristicsForCourseOfferingOutcome(CourseOffering courseOffering, CourseOutcome o, Organization organization,Session session)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("	SELECT {c.*} ");
		sql.append("     FROM characteristic c, ");
		sql.append("          link_course_offering_outcome_characteristic lcoc, ");
		sql.append("          link_course_offering_outcome lco, ");
		sql.append("          link_organization_characteristic_type ldct ");
		sql.append("    WHERE lcoc.characteristic_id = c.id ");
		sql.append("      AND lco.id = lcoc.link_course_offering_outcome_id ");
		sql.append("      AND lco.course_offering_id = :courseOfferingId ");
		sql.append("      AND lco.course_outcome_id = :outcomeId ");
		sql.append("      AND ldct.characteristic_type_id = c.characteristic_type_id ");
		sql.append("      AND ldct.organization_id = :organizationId ");
		sql.append(" ORDER BY ldct.display_index ");
		
		logger.debug(" c="+courseOffering.getId()+" o="+o.getId() +"\n"+sql.toString());
		
		@SuppressWarnings("unchecked")
		List<Characteristic> list = (List<Characteristic>)session.createSQLQuery(sql.toString())
			.addEntity("c",Characteristic.class)
			.setParameter("courseOfferingId",courseOffering.getId())
			.setParameter("organizationId",organization.getId())
			.setParameter("outcomeId", o.getId())
			.list();
		return list;
	}
	public List<Characteristic> getCharacteristicsForProgramOutcome(Program program, ProgramOutcome o, Organization organization)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> list = null;
		try
		{
			list = getCharacteristicsForProgramOutcome(program,o,organization,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	public List<Characteristic> getCharacteristicsForProgramOutcome(Program program, ProgramOutcome o, Organization organization,Session session)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("	SELECT {c.*} ");
		sql.append("     FROM characteristic c, ");
		sql.append("          link_program_program_outcome_characteristic lcoc, ");
		sql.append("          link_program_program_outcome lco, ");
		sql.append("          link_organization_characteristic_type ldct ");
		sql.append("    WHERE lcoc.characteristic_id = c.id ");
		sql.append("      AND lco.id = lcoc.link_program_program_outcome_id ");
		sql.append("      AND lco.program_id = :programId ");
		sql.append("      AND lco.program_outcome_id = :outcomeId ");
		sql.append("      AND ldct.characteristic_type_id = c.characteristic_type_id ");
		sql.append("      AND ldct.organization_id = :organizationId ");
		sql.append(" ORDER BY ldct.display_index ");
		
		logger.debug(" c="+program.getId()+" o="+o.getId() +"\n"+sql.toString());
		
		@SuppressWarnings("unchecked")
		List<Characteristic> list = (List<Characteristic>)session.createSQLQuery(sql.toString())
			.addEntity("c",Characteristic.class)
			.setParameter("programId",program.getId())
			.setParameter("organizationId",organization.getId())
			.setParameter("outcomeId", o.getId())
			.list();
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<CourseOutcome> getOutcomesForProgramContaining(Program program,String text)
	{
		text = "%"+text+"%";
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			StringBuilder sql = new StringBuilder();
	
			sql.append("		 SELECT {o.*} ");
			sql.append("		   FROM outcome o ");
			sql.append("		  WHERE (o.name like :text " );
			sql.append("		          OR  o.description like :text) " );
			sql.append("		    AND (o.program_specific ='N' " );
			sql.append("		    		OR (o.program_specific = 'Y' AND o.program_id=:programId) )");
			sql.append("     ORDER BY o.name ");
			
			toReturn = (List<CourseOutcome>)session.createSQLQuery(sql.toString())
				.addEntity("o",CourseOutcome.class)
				.setParameter("text",text)
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
	public List<ProgramOutcome> getProgramOutcomesForProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<ProgramOutcome> toReturn = null;
		try
		{
			StringBuilder sql = new StringBuilder();
	
			sql.append("		 SELECT {o.*} ");
			sql.append("		   FROM program_outcome o ");
			sql.append("             , program_outcome_group og");
			sql.append("        WHERE o.program_outcome_group_id = og.id");
			sql.append("		  AND (og.program_specific ='N' " );
			sql.append("		    		OR (og.program_specific = 'Y' AND og.program_id=:programId) )");
			sql.append("     ORDER BY og.name, o.name ");
		
		
			toReturn = (List<ProgramOutcome>)session.createSQLQuery(sql.toString())
				.addEntity("o",ProgramOutcome.class)
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
	public List<CourseOutcome> getOutcomesForOrganization(Organization d)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			StringBuilder sql = new StringBuilder();
	
			sql.append("		 SELECT {o.*} ");
			sql.append("		   FROM course_outcome o ");
			sql.append("             , course_outcome_group og");
			sql.append("        WHERE o.course_outcome_group_id = og.id");
			sql.append("		  AND (og.organization_specific ='N' " );
			sql.append("		    		OR (og.organization_specific = 'Y' AND og.organization_id=:orgId) )");
			sql.append("     ORDER BY og.name, o.name ");
			
			toReturn = (List<CourseOutcome>)session.createSQLQuery(sql.toString())
				.addEntity("o",CourseOutcome.class)
				.setParameter("orgId", d.getId())
				.list();
			
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public CourseOutcome getCourseOutcomeByName(String name,Session session)
	{

		//logger.error(sql.toString());
		CourseOutcome toReturn = (CourseOutcome)session.createQuery("FROM CourseOutcome WHERE lower(name) =:name")
			.setParameter("name",name.trim().toLowerCase())
			.uniqueResult();
		return toReturn;
	}
	public CourseOutcome getCourseOutcomeByName(String name)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		CourseOutcome toReturn = null;
		try
		{
			toReturn = getCourseOutcomeByName(name,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	
	public ProgramOutcome getProgramOutcomeByName(String name,Session session)
	{

		//logger.error(sql.toString());
		ProgramOutcome toReturn = (ProgramOutcome)session.createQuery("FROM ProgramOutcome WHERE name =:name")
			.setParameter("name",name)
			.uniqueResult();
		return toReturn;
	}
	public ProgramOutcome getProgramOutcomeByName(String name)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		ProgramOutcome toReturn = null;
		try
		{
			toReturn = getProgramOutcomeByName(name,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public OrganizationOutcome getOrganizationOutcomeByName(String name,Session session)
	{

		//logger.error(sql.toString());
		OrganizationOutcome toReturn = (OrganizationOutcome)session.createQuery("FROM OrganizationOutcome WHERE name =:name")
			.setParameter("name",name)
			.uniqueResult();
		return toReturn;
	}
	public OrganizationOutcome getOrganizationOutcomeByName(String name)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		OrganizationOutcome toReturn = null;
		try
		{
			toReturn = getOrganizationOutcomeByName(name,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}

	@SuppressWarnings("unchecked")
	public List<LinkCourseOfferingOutcome> getOutcomesForCourses(List<String> courseIds)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkCourseOfferingOutcome> toReturn = null;
		try
		{
			toReturn =  (List<LinkCourseOfferingOutcome>)session.createQuery("FROM LinkCourseOfferingOutcome l WHERE "
		            + HibernateUtil.getListAsString(" l.courseOffering.course.id ",courseIds, false, false) 
		            + " ORDER BY l.courseOffering.course.subject, l.courseOffering.course.courseNumber, l.courseOffering.term, l.courseOffering.sectionNumber,l.id").list();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public List<CourseOutcome> getOutcomesForCourseOffering(CourseOffering courseOffering)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			
			toReturn = getOutcomesForCourseOffering(courseOffering, session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseOutcome> getOutcomesForCourseOffering(CourseOffering courseOffering, Session session)
	{
		return (List<CourseOutcome>)session.createQuery("SELECT l.courseOutcome FROM LinkCourseOfferingOutcome l WHERE l.courseOffering.id=:courseOfferingId ORDER BY l.displayIndex")
				.setParameter("courseOfferingId", courseOffering.getId())
				.list();
	
	}
	@SuppressWarnings("unchecked")
	public List<ProgramOutcome> getOutcomesForProgram(Program program)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<ProgramOutcome> toReturn = null;
		try
		{
			
			toReturn = (List<ProgramOutcome>)session.createQuery("SELECT l.programOutcome FROM LinkProgramProgramOutcome l WHERE l.program.id=:programId ORDER BY l.programOutcome.name")
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
	public List<CourseOutcome> getOutcomesForCourseOfferingHavingCharacteristic(CourseOffering courseOffering, Characteristic charac)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			StringBuilder sql = new StringBuilder();
	
			sql.append("		 SELECT {o.*} ");
			sql.append("		   FROM link_course_offering_outcome lco, ");
			sql.append("              link_course_offering_outcome_characteristic lcoc, ");
			sql.append("		        course_outcome o ");
			sql.append("		  WHERE o.id = lco.course_outcome_id " );
			sql.append("		    AND lco.course_offering_id = :courseOfferingId ");
			sql.append("          AND lcoc.link_course_offering_outcome_id = lco.id ");
			sql.append("          AND lcoc.characteristic_id = :charId ");
			sql.append("     ORDER BY o.name ");
			
			logger.debug(sql.toString());
			logger.debug(" courseOfferingId="+courseOffering.getId());
			toReturn = (List<CourseOutcome>)session.createSQLQuery(sql.toString())
				.addEntity("o",CourseOutcome.class)
				.setParameter("courseOfferingId", courseOffering.getId())
				.setParameter("charId", charac.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseOutcome> getOutcomesWithCharacteristicTypeForProgramAndCourseOffering(Program p, CharacteristicType c,CourseOffering courseOffering)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT {co.*} ");
			sql.append("  FROM outcome co, ");
			sql.append("       link_outcome_outcome lco,");
			sql.append("       link_outcome_outcome_characteristic lcoc, ");
			sql.append("       characteristic c, ");
			sql.append("       characteristic_type ct, ");
			sql.append("       link_outcome_program lpc");
			
			sql.append(" WHERE c.id=lcoc.characteristic_id  ");
			sql.append("   AND lcoc.link_outcome_outcome_id = lco.id ");
			sql.append("   AND lco.outcome_id=co.id " );
			sql.append("   AND c.characteristic_type = ct.id ");
			sql.append("   AND ct.id=:charTypeId ");
			sql.append("   AND lpc.outcome_id = c.id");
			sql.append("   AND lpc.program_id = :programId ");
			sql.append("ORDER BY co.subject, co.outcome_number ");
			
			toReturn = (List<CourseOutcome>)session.createSQLQuery(sql.toString()).addEntity("co",CourseOutcome.class).setParameter("charTypeId",c.getId()).setParameter("programId", p.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	
	public boolean isAlreadyPartOfCourseOffering(int courseOfferingId,int outcomeId)
	{
		return getLinkCourseOfferingOutcomeByOutcomeAndCourseOffering(courseOfferingId,outcomeId) != null;
	}

	public LinkCourseOfferingOutcome getLinkCourseOfferingOutcomeByOutcomeAndCourseOffering(int courseOfferingId,int outcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		LinkCourseOfferingOutcome toReturn = null;
		try
		{
			toReturn = (LinkCourseOfferingOutcome) session.createQuery("SELECT l FROM LinkCourseOfferingOutcome l WHERE l.outcome.id = :outcomeId and l.courseOffering.id=:courseOfferingId").setParameter("outcomeId",outcomeId).setParameter("courseOfferingId",courseOfferingId).uniqueResult();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseOutcome> getCourseOfferingOutcomesNotUsed(CourseOffering c)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			toReturn = (List<CourseOutcome>) session.createQuery("FROM Outcome ou WHERE ou.id NOT IN (SELECT lco.outcome.id FROM LinkCourseOfferingOutcome lco WHERE lco.courseOffering.id = :courseOfferingId) order by ou.name").setParameter("courseOfferingId",c.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public List<LinkCourseOfferingOutcome> getLinkCourseOfferingOutcome(CourseOffering c)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkCourseOfferingOutcome> toReturn = null;
		try
		{
			toReturn = getLinkCourseOfferingOutcome(c,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<LinkCourseOfferingOutcome> getLinkCourseOfferingOutcome(CourseOffering c,Session session)
	{
		return (List<LinkCourseOfferingOutcome>) session.createQuery("FROM LinkCourseOfferingOutcome l WHERE l.courseOffering.id=:courseOfferingId").setParameter("courseOfferingId",c.getId()).list();
	}
	
	
	public OutcomeManager()
	{

	}

	public static OutcomeManager instance()
	{
		if (instance == null)
		{
			instance = new OutcomeManager();
		}
		return instance;

	}
	public int getCourseOutcomeIndex(List<CourseOutcome> list, int outcomeId)
	{
		int index = 1;
		for(CourseOutcome o : list)
		{
			if(o.getId() == outcomeId)
				return index;
			index++;
		}
		return -1;
	
	}
	

}
