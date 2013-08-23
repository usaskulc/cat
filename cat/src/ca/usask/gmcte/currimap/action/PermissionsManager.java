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

import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.TreeMap;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Course;
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.Instructor;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingInstructor;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.OrganizationAdmin;
import ca.usask.gmcte.currimap.model.SystemAdmin;
import ca.usask.gmcte.util.HibernateUtil;
import ca.usask.ocd.ldap.LdapConnection;

public class PermissionsManager
{
	private static PermissionsManager instance;
	private static Logger logger = Logger.getLogger(PermissionsManager.class);
	
	public static boolean ldapEnabled=setLdap();
	private static String ldapBoolean;
	
	public static boolean setLdap()
	{
		if(ldapBoolean != null)
			return ldapBoolean.equals("Y");
		ResourceBundle bundle = ResourceBundle.getBundle("currimap");
		ldapBoolean = bundle.getString("ldap.enabled");
		return ldapBoolean.equals("Y");
	}


	public boolean saveOrganizationPermission(int organizationId,String type,String name, String first, String last)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			OrganizationAdmin p = getOrganizationAdminByNameAndType(name,type,organizationId,session);
			boolean existed = true;
			if(p == null)
			{
				p = new OrganizationAdmin();
				Organization Organization = (Organization)session.get(Organization.class, organizationId);
				p.setOrganization(Organization);
				p.setName(name);
				p.setType(type);
				existed = false;
				if(type.equals("Userid"))
					p.setTypeDisplay("Persons");
				else
					p.setTypeDisplay("Organizations");
			
			}
			p.setLastName(last);
			p.setFirstName(first);
			if(existed)			
				session.merge(p);
			else
				session.save(p);
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
	public boolean saveSystemPermission(String type,String name, String createdUserid,String first, String last)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			SystemAdmin p = getSystemAdminByNameAndType(name,type,session);
			boolean existed = true;
			if(p==null)
			{
				p = new SystemAdmin();
				p.setName(name);
				p.setType(type);
				if(type.equals("Userid"))
					p.setTypeDisplay("Persons");
				else
					p.setTypeDisplay("Organizations");
				p.setCreatedUserid(createdUserid);
				p.setCreatedOn(Calendar.getInstance().getTime());
		
				existed = false;
			}
			p.setLastName(last);
			p.setFirstName(first);
			if(existed)
				session.merge(p);
			else
				session.save(p);
			
			
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
	public boolean saveInstructor(int id,String userid,String first,String last)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			boolean createNew = true;
			Instructor i = new Instructor();
			if(id > -1)
			{
				i = (Instructor)session.get(Instructor.class,  id);
				createNew = false;
			}
			else
			{
				i = (Instructor)session.createQuery("FROM Instructor where lower(userid) = :userid").setParameter("userid",userid.toLowerCase()).uniqueResult();
				if( i==null)
					i = new Instructor();
			}
			i.setUserid(userid);
			i.setFirstName(first);
			i.setLastName(last);
			if(createNew)
				session.save(i);
			else
				session.merge(i);
			
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
	
	public Instructor getInstructorById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Instructor toReturn = null;
		try
		{
			toReturn = (Instructor)session.get(Instructor.class, id);
			session.getTransaction().commit();
			
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public Instructor getInstructorByUserid(Session session,String id)
	{
		return (Instructor)session.createQuery("FROM Instructor where lower(userid) = :userid").setParameter("userid",id.toLowerCase()).uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Instructor> getAllInstructors()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Instructor> toReturn = null;
		try
		{
			toReturn = (List<Instructor>)session.createQuery("FROM Instructor ORDER by lower(lastName), lower(firstName),lower(userid)").list();
			session.getTransaction().commit();
			
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public boolean saveInstructor(String userid,String first, String last)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Instructor i = (Instructor)session.createQuery("FROM Instructor where userid=:userid").setParameter("userid", userid).uniqueResult();
			boolean existed = true;
			if(i == null)
			{
				i = new Instructor();
				i.setUserid(userid);
				existed = false;
			}
			i.setLastName(last);
			i.setFirstName(first);
			
			if(existed)
				session.merge(i);
			else
				session.save(i);
			
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
	private SystemAdmin getSystemAdminByNameAndType(String name, String type, Session session)
	{
		return (SystemAdmin)session.createQuery("FROM SystemAdmin WHERE type=:type AND lower(name)=:name")
				.setParameter("type",type)
				.setParameter("name",name.toLowerCase().trim())
				.uniqueResult();
	}

	private OrganizationAdmin getOrganizationAdminByNameAndType(String name, String type,int organizationId, Session session)
	{
		return (OrganizationAdmin)session.createQuery("FROM OrganizationAdmin WHERE organization.id=:organizationId AND type=:type AND lower(name)=:name")
				.setParameter("type",type)
				.setParameter("organizationId",organizationId)
				.setParameter("name",name.toLowerCase().trim())
				.uniqueResult();
	}
	public boolean removeSystemPermission(String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			SystemAdmin p = (SystemAdmin)session.get(SystemAdmin.class,Integer.parseInt(id));
			session.delete(p);
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

	public boolean removeOrganizationPermission(String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
	
			OrganizationAdmin p = (OrganizationAdmin)session.get(OrganizationAdmin.class,Integer.parseInt(id));
			session.delete(p);
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
	
	public String getDisplayName(OrganizationAdmin p) throws Exception
	{
		if(p.getLastName() == null && PermissionsManager.ldapEnabled)
		{
			try
			{
				TreeMap<String,String> data = LdapConnection.instance().getUserData(p.getName());
				if(data!=null)
				{
					
					String first = data.get("givenName");
					String last = data.get("sn");
					if(this.saveOrganizationPermission(p.getOrganization().getId(),p.getType(),p.getName(), first, last))
					{
						p.setFirstName(first);
						p.setLastName(last);
					}
				}
			}catch(Exception e)
			{
				//fail silently
			}
		}
		String display = null;
		
		if(p.getFirstName() !=null)
			display = p.getFirstName();
		if(p.getLastName() != null)
		{
			if(display == null)
				display = p.getLastName();
			else
				display += " " + p.getLastName();
		}
		return display == null ? p.getName() : display;
	}
	public String getDisplayName(SystemAdmin p) throws Exception
	{
		
		if(p.getLastName() == null && PermissionsManager.ldapEnabled)
		{
			try
			{
				TreeMap<String,String> data = LdapConnection.instance().getUserData(p.getName());
				String first = data.get("givenName");
				String last = data.get("sn");
				if(saveSystemPermission(p.getType(),p.getName(),p.getCreatedUserid(), first, last))
				{
					p.setFirstName(first);
					p.setLastName(last);
				}
			}
			catch(Exception e)
			{//fail silently
			}
		
		}
		String display = null;
		
		if(p.getFirstName() !=null)
			display = p.getFirstName();
		if(p.getLastName() != null)
		{
			if(display == null)
				display = p.getLastName();
			else
				display += " " + p.getLastName();
		}
		return display == null ? p.getName() : display;
	}
	
	

	@SuppressWarnings("unchecked")
	public List<OrganizationAdmin> getAdminsForOrganization(String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<OrganizationAdmin> toReturn = null;
		
		try
		{
			toReturn = session.createQuery("FROM OrganizationAdmin WHERE organization.id = :organizationId ORDER BY type,name").setParameter("organizationId",Integer.parseInt(id)).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<SystemAdmin> getSystemAdmins()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<SystemAdmin> toReturn = null;
		try
		{
			toReturn = session.createQuery("FROM SystemAdmin  ORDER BY type,name").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}

	
	
	
	public HashMap<String,Organization> getOrganizationsForUser(String userid)
	{
		HashMap<String,Organization> toReturn = new HashMap<String,Organization>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		StringBuilder sql = new StringBuilder();
		sql.append("   select {o.*} ");
		sql.append("  from organization o");
		sql.append("      ,organization_admin oa ");
		sql.append(" where oa.organization_id = o.id");
		sql.append("   and oa.name =:userid and type='Userid' ");
		@SuppressWarnings("unchecked")
		List<Organization> organizations = (List<Organization>)session.createSQLQuery(sql.toString())
						.addEntity("o",Organization.class)
						.setParameter("userid",userid)
						.list();
		
		for(Organization o : organizations)
		{
			@SuppressWarnings("unchecked")
			List<Organization> children = session.createQuery("FROM Organization WHERE parentOrganization.id =:orgId").setParameter("orgId", o.getId()).list();
			for(Organization o2 : children)
			{
				toReturn.put(""+o2.getId(), o2);
			}
			toReturn.put(""+o.getId(), o);
		}
				
		session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	
	public HashMap<String,CourseOffering> getOfferingsForUser(String userid, HashMap<String,Organization> userHasAccessToOrganizations)
	{
		HashMap<String,CourseOffering> toReturn = new HashMap<String,CourseOffering>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		StringBuilder sql = new StringBuilder();
		sql.append(" select {co.*} ");
		sql.append("  from  program p ");
		sql.append("      ,link_course_program lcp ");
		sql.append("      ,course_offering co");
		sql.append(" where lcp.program_id = p.id");
		sql.append("   and lcp.course_id = co.course_id");
		sql.append("   and p.organization_id in (");
		sql.append(buildIn(userHasAccessToOrganizations.keySet()));
		sql.append(")");
		sql.append("  UNION");
		sql.append("  select {co.*} ");
		sql.append("  from course_offering co");
		sql.append("     , link_course_offering_instructor coi");
		sql.append("     , instructor instruc");
		sql.append(" where instruc.userid = :userid ");
		sql.append("   and coi.instructor_id = instruc.id");
		sql.append("   and coi.course_offering_id");
		sql.append("   and coi.course_offering_id = co.id");
		logger.error(sql);
		@SuppressWarnings("unchecked")
		List<CourseOffering> offerings = (List<CourseOffering>)session.createSQLQuery(sql.toString())
				.addEntity("co",CourseOffering.class)
				.setParameter("userid",userid)
				.list();
		
		for(CourseOffering o : offerings)
		{
			toReturn.put(""+o.getId(), o);
		}
		
		session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	
	
	
	public boolean isSysadmin(String userid)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		boolean toReturn =  false;
		try
		{
			toReturn =  !session.createQuery("FROM SystemAdmin  WHERE type='Userid' AND name=:userid")
				.setParameter("userid",userid)
				.list()
				.isEmpty();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<Organization> getOrganizationsForUser(String userid, boolean sysadmin, boolean activeOnly) throws Exception
	{
		List<Organization> organizations = null;
		if(userid == null)
		{
			return null;
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		
		try
		{
			if(sysadmin)
			{
				String query=activeOnly?"FROM Organization WHERE active='Y' ORDER BY lower(name)":"FROM Organization ORDER BY lower(name)";
				organizations = (List<Organization>)session.createQuery(query).list();
			}
			else
			{
				 
				StringBuilder sql = new StringBuilder();
				sql.append("   select {o.*} ");
				sql.append("  from organization o");
				sql.append("      ,organization_admin oa ");
				sql.append(" where oa.organization_id = o.id");
				if(activeOnly)
				{
					sql.append(" and o.active='Y' ");
				}
				sql.append("   and oa.name =:userid and type='Userid' ");
				organizations = (List<Organization>)session.createSQLQuery(sql.toString())
								.addEntity("o",Organization.class)
								.setParameter("userid",userid)
								.list();
				
			}
			session.getTransaction().commit();

		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return organizations;
	}

	@SuppressWarnings("unchecked")
	public boolean hasAccessToCourseOffering(String userid,CourseOffering offering,boolean sysadmin) throws Exception
	{
		Set<LinkCourseOfferingInstructor> instructors = offering.getInstructors();
		LinkCourseOfferingInstructor temp = new LinkCourseOfferingInstructor();
		Instructor instructor = CourseManager.instance().getInstructorByUserid(userid);
		temp.setInstructor(instructor);
		if(instructors.contains(temp)) //user is instructor of the course offering
		{
			return true;
		}
		List<Organization> accessOrganizations = getOrganizationsForUser(userid,sysadmin,false);
		if(accessOrganizations == null  || accessOrganizations.isEmpty())
		{ //user is NOT in any organizations
			return false;
		}
		
		StringBuilder in = new StringBuilder();
		for(Organization org: accessOrganizations)
		{
			
			in.append(org.getId());
			in.append(",");
		}
		Course course = offering.getCourse();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT {d.*} ");
		sql.append("  FROM organization d,");
		sql.append("       program_admin pa,");
		sql.append("       link_course_program lcp");
		sql.append(" WHERE d.id = pa.name");
		sql.append("   AND pa.type='orgId' ");
		sql.append("   AND pa.program_id = lcp.program_id");
		sql.append("   AND lcp.course_id = :courseId");
		sql.append("   AND d.id in (");
		sql.append( in.substring(0,in.length()-1) );
		sql.append(")");
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Organization> organizationsWithAccessToCourseForUser = null;
		try
		{
			organizationsWithAccessToCourseForUser = (List<Organization>)session.createSQLQuery(sql.toString())
					.addEntity("d",Organization.class)
					.setParameter("courseId",course.getId())
				.list();
			
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return !organizationsWithAccessToCourseForUser.isEmpty();
	}
	
	
	public PermissionsManager()
	{
	}

	public static PermissionsManager instance()
	{
		if (instance == null)
		{
			instance = new PermissionsManager();
		}
		return instance;

	}
	
	public static String inString(List<Integer> in)
	{
		StringBuilder sb = new StringBuilder();
		for(int i : in)
		{
			sb.append(",");
			sb.append(i);
			
		}
		return sb.substring(1);
	}

	private static String buildIn(Set<String> values)
	{
		StringBuilder r = new StringBuilder();
		if(values == null || values.isEmpty())
		{
			return "''";
		}
		r.append("'bogus'");
		Iterator<String> iter = values.iterator();
		while (iter.hasNext())
		{
			String s = iter.next();
			r.append(",'");
			r.append(s);
			r.append("'");
		}
		return r.toString();
	}

	
}
