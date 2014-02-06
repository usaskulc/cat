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

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Characteristic;
import ca.usask.gmcte.currimap.model.CharacteristicType;
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingOutcomeCharacteristic;
import ca.usask.gmcte.currimap.model.LinkOrganizationCharacteristicType;
import ca.usask.gmcte.currimap.model.CourseOutcome;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.util.HibernateUtil;

public class CharacteristicManager
{
	private static CharacteristicManager instance;
	private static Logger logger = Logger.getLogger( OutcomeManager.class );

	public boolean updateCharacteristicType(String id,String name, String questionDisplay,String valueType)
	{
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = (CharacteristicType) session.get(CharacteristicType.class, Integer.parseInt(id));
			c.setName(name);
			c.setQuestionDisplay(questionDisplay);
			c.setValueType(valueType);
			session.merge(c);
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
	public boolean saveCharacteristicNameById(String newName, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Characteristic c = this.getCharacteristicById(Integer.parseInt(id), session);
			c.setName(newName);
			c.setDescription("");
			session.merge(c);
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
	public boolean saveCharacteristicDescriptionById(String newDescription, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Characteristic c = this.getCharacteristicById(Integer.parseInt(id), session);
			c.setDescription(newDescription);
			session.merge(c);
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
	public boolean saveNewCharacteristicWithNameAndType(String newName, String charTypeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType cType = this.getCharacteristicTypeById(Integer.parseInt(charTypeId), session);
			List<Characteristic> existing = this.getCharacteristicsForType(cType,session);
			Characteristic c = new Characteristic();
			c.setName(newName);
			c.setDescription("");
			c.setDisplayIndex(existing.size()+1);
			c.setCharacteristicType(cType);
			session.save(c);
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
	
	public boolean saveCharacteristicTypeNameById(String newName, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = this.getCharacteristicTypeById(Integer.parseInt(id), session);
			c.setName(newName);
			session.merge(c);
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
	public boolean saveNewCharacteristicTypeName(String newName)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = new CharacteristicType();
			c.setName(newName);
			c.setShortDisplay("default short value");
			c.setQuestionDisplay("No Question set yet");
			c.setValueType("NOT SET");
			session.save(c);
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
	public boolean saveCharacteristicTypeValueTypeById(String newValue, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = this.getCharacteristicTypeById(Integer.parseInt(id), session);
			c.setValueType(newValue);
			session.merge(c);
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
	
	public boolean saveCharacteristicTypeShortDisplayById(String newName, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = this.getCharacteristicTypeById(Integer.parseInt(id), session);
			c.setShortDisplay(newName);
			session.merge(c);
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
	public boolean saveCharacteristicTypeQuestionById(String newName, String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = this.getCharacteristicTypeById(Integer.parseInt(id), session);
			c.setQuestionDisplay(newName);
			session.merge(c);
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
	public boolean saveNewCharacteristicName(String newName)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Characteristic c = new Characteristic();
			c.setName(newName);
			c.setDescription("");
			session.save(c);
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
	
	public boolean saveCharacteristicType(String name, String questionDisplay,String valueType)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType c = new CharacteristicType();
			c.setName(name);
			c.setQuestionDisplay(questionDisplay);
			c.setValueType(valueType);
			session.save(c);
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
	
	public boolean deleteCharacteristicsType(String toDelete)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			CharacteristicType ct = (CharacteristicType)session.get(CharacteristicType.class, Integer.parseInt(toDelete));
			List<Characteristic> existing = this.getCharacteristicsForType(ct,session);
			for(Characteristic ch : existing)
			{
				deleteCharacteristic(ch,session);
			}
		
			@SuppressWarnings("unchecked")
			List<LinkOrganizationCharacteristicType> programLinks = session.createQuery("FROM LinkOrganizationCharacteristicType WHERE characteristicType.id = :charTypeId").setParameter("charTypeId",ct.getId()).list();
			for(LinkOrganizationCharacteristicType pLink : programLinks)
			{
				session.delete(pLink);
			}
			
			session.delete(ct);
			
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
	
	private void deleteCharacteristic(Characteristic c, Session session)
	{
		@SuppressWarnings("unchecked")
		List<LinkCourseOfferingOutcomeCharacteristic> linkedOutcomes = session.createQuery("FROM LinkCourseOfferingOutcomeCharacteristic WHERE characteristic.id=:charId").setParameter("charId",c.getId()).list();
		for(LinkCourseOfferingOutcomeCharacteristic link : linkedOutcomes)
		{
			session.delete(link);
		}
		session.delete(c);
	}
	public boolean moveCharacteristic(int id, int charTypeId, String direction)
	{
		//when moving up, find the one to be moved (while keeping track of the previous one) and swap display_index values
		//when moving down, find the one to be moved, swap displayIndex values of it and the next one
		//when deleting, reduce all links following one to be deleted by 1
		boolean done = false;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		CharacteristicType ct = (CharacteristicType)session.get(CharacteristicType.class, charTypeId);
		List<Characteristic> existing = this.getCharacteristicsForType(ct,session);
		if(direction.equals("up"))
		{
			Characteristic prev = null;
			for(Characteristic ch : existing)
			{
				if(ch.getId() == id && prev!=null)
				{
					int swap = prev.getDisplayIndex();
					prev.setDisplayIndex(ch.getDisplayIndex());
					ch.setDisplayIndex(swap);
					session.merge(prev);
					session.merge(ch);
					done = true;
					break;
				}
				prev = ch;
			}
		}
		else if(direction.equals("down"))
		{
			Characteristic prev = null;
			for(Characteristic ch : existing)
			{
				if(prev !=null)
				{
					int swap = prev.getDisplayIndex();
					prev.setDisplayIndex(ch.getDisplayIndex());
					ch.setDisplayIndex(swap);
					session.merge(prev);
					session.merge(ch);
					done = true;
					break;
				}
				if(ch.getId() == id)
				{
					prev = ch;
				}
				
			}
		}
		else if(direction.equals("delete"))
		{
			Characteristic toDelete = null;
			for(Characteristic ch : existing)
			{
				if(toDelete !=null)
				{
					ch.setDisplayIndex(ch.getDisplayIndex()-1);
					session.merge(ch);
				}
				if(ch.getId() == id)
				{
					toDelete = ch;
				}
				
			}
			if(toDelete !=null)
			{
					session.delete(toDelete);
					done = true;
			}
		}
		session.getTransaction().commit();
		return done;
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
			try{session.getTransaction().rollback();}catch(Exception e2){logger.error("Unable to roll back!",e2);}
			return false;
		}
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
	public CharacteristicType getFirstCharacteristicType(Session session)
	{
		@SuppressWarnings("unchecked")
		List<CharacteristicType> list= (List<CharacteristicType>) session.createQuery("FROM CharacteristicType ORDER BY id").list();
		if(list!=null && !list.isEmpty())
			return list.get(0);
		return null;
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
	public List<Characteristic> getCharacteristicsForType(CharacteristicType ct,Session session)
	{
		@SuppressWarnings("unchecked")
		List<Characteristic> toReturn = (List<Characteristic>)session.createQuery("select c from Characteristic c where c.characteristicType.id = :ctId order by c.displayIndex").setParameter("ctId",ct.getId()).list();
		return toReturn;
	}

	public List<Characteristic> getCharacteristicsForType(CharacteristicType ct)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> toReturn = null;
		try
		{
			toReturn = getCharacteristicsForType(ct,session);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<CharacteristicType> getAllCharacteristicTypes()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CharacteristicType> toReturn = null;
		try
		{
			toReturn = (List<CharacteristicType>)session.createQuery("from CharacteristicType c order by c.name").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}

	@SuppressWarnings("unchecked")
	public List<Characteristic> getCharacteristicsForCourseOfferingOutcome(Program p,CourseOffering courseOffering, CourseOutcome o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> list = null;
		try
		{
			
			StringBuilder sql = new StringBuilder();
			sql.append("	SELECT {c.*} ");
			sql.append("     FROM characteristic c, ");
			sql.append("          link_courseOffering_outcome_characteristic lcoc, ");
			sql.append("          link_courseOffering_outcome lco, ");
			sql.append("          link_program_characteristic_type lpct ");
			sql.append("    WHERE lcoc.characteristic_id = c.id ");
			sql.append("      AND lco.id = lcoc.link_courseOffering_outcome_id ");
			sql.append("      AND lco.courseOffering_id = :courseOfferingId ");
			sql.append("      AND lco.outcome_id = :outcomeId ");
			sql.append("      AND lpct.program_id = :programId ");
			sql.append("      AND lpct.characteristic_type_id = c.characteristic_type_id ");
			sql.append(" ORDER BY lpct.display_index ");
			
			logger.error("p="+p.getId()+" c="+courseOffering.getId()+" o="+o.getId() +"\n"+sql.toString());
			
			list = (List<Characteristic>)session.createSQLQuery(sql.toString())
				.addEntity("c",Characteristic.class)
				.setParameter("courseOfferingId",courseOffering.getId())
				.setParameter("outcomeId", o.getId())
				.setParameter("programId", p.getId())
				.list();
			
			
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}

	
	public CharacteristicManager()
	{

	}

	public static CharacteristicManager instance()
	{
		if (instance == null)
		{
			instance = new CharacteristicManager();
		}
		return instance;

	}
	public static void main(String[] a)
	{
		System.out.println(CharacteristicManager.getColour(0, 1, 2));
		System.out.println(CharacteristicManager.getColour(0, 2, 2));
		System.out.println();
		
		System.out.println(CharacteristicManager.getColour(0, 1, 3));
		System.out.println(CharacteristicManager.getColour(0, 2, 3));
		System.out.println(CharacteristicManager.getColour(0, 3, 3));
		System.out.println();
			
		System.out.println(CharacteristicManager.getColour(0, 1, 4));
		System.out.println(CharacteristicManager.getColour(0, 2, 4));
		System.out.println(CharacteristicManager.getColour(0, 3, 4));
		System.out.println(CharacteristicManager.getColour(0, 4, 4));
		System.out.println();
	}
	
	public static String getColour(int type, int level, int maxLevel)
	{
		char[] colourValues="0123456789ABCDEFFEDCBA9876543210".toCharArray();
		int colourLevel = 15;
		if(level <= 1)
		{
			colourLevel = 0;
		}
		else if(maxLevel > level)
		{
			level = level - 1;
			maxLevel--;
			double ratio = (level *1.0 )/maxLevel;
			colourLevel = (int)(ratio * 16);
		}
		if(colourLevel < 0)
			colourLevel = 0;
		else if(colourLevel >14)
			colourLevel = 14;
		
		char levelChar = colourValues[colourLevel];
		if(type == 0)
		{
			return "F" + levelChar + levelChar;
		}
		else if(type == 1)
		{
			return levelChar + "F" + levelChar;
		}
		else if(type == 2)
		{
			return levelChar + levelChar + "F";
		}
		else if(type == 3)
		{
			return levelChar + "FF";
		}
		else if(type == 4)
		{
			return "F" + levelChar + "F";
		}
		else if(type == 5)
		{
			return "FF" + levelChar;
		}
		return "000";
	}

}
