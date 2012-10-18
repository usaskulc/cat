package ca.usask.gmcte.currimap.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Course;
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.Department;
import ca.usask.gmcte.currimap.model.Instructor;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingInstructor;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.OrganizationAdmin;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.ProgramAdmin;
import ca.usask.gmcte.currimap.model.SystemAdmin;
import ca.usask.gmcte.util.HibernateUtil;
import ca.usask.ocd.ldap.LdapConnection;

public class PermissionsManager
{
	private static PermissionsManager instance;
	private static Logger logger = Logger.getLogger(PermissionsManager.class);
	

	public boolean saveProgramPermission(int programId,String type,String name, String createdUserid)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			ProgramAdmin p = getProgramAdminByNameAndType(name,type,programId,session);
			if(p == null)
			{
				p = new ProgramAdmin();
				Program program = (Program)session.get(Program.class, programId);
				p.setProgram(program);
				p.setName(name);
				p.setType(type);
				p.setCreatedUserid(createdUserid);
				p.setCreatedOn(Calendar.getInstance().getTime());
				session.save(p);
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
	public boolean saveOrganizationPermission(int organizationId,String type,String name)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			OrganizationAdmin p = getOrganizationAdminByNameAndType(name,type,organizationId,session);
			if(p == null)
			{
				p = new OrganizationAdmin();
				Organization Organization = (Organization)session.get(Organization.class, organizationId);
				p.setOrganization(Organization);
				p.setName(name);
				p.setType(type);
				if(type.equals("Userid"))
					p.setTypeDisplay("Persons");
				else
					p.setTypeDisplay("Departments");
						
				session.save(p);
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
	public boolean saveSystemPermission(String type,String name, String createdUserid)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
			SystemAdmin p = getSystemAdminByNameAndType(name,type,session);
			if(p==null)
			{
				p = new SystemAdmin();
				p.setName(name);
				p.setType(type);
				if(type.equals("Userid"))
					p.setTypeDisplay("Persons");
				else
					p.setTypeDisplay("Departments");
				p.setCreatedUserid(createdUserid);
				p.setCreatedOn(Calendar.getInstance().getTime());
				session.save(p);
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
	private SystemAdmin getSystemAdminByNameAndType(String name, String type, Session session)
	{
		return (SystemAdmin)session.createQuery("FROM SystemAdmin WHERE type=:type AND lower(name)=:name")
				.setParameter("type",type)
				.setParameter("name",name.toLowerCase().trim())
				.uniqueResult();
	}
	private ProgramAdmin getProgramAdminByNameAndType(String name, String type,int programId, Session session)
	{
		return (ProgramAdmin)session.createQuery("FROM ProgramAdmin WHERE program.id=:programId AND type=:type AND lower(name)=:name")
				.setParameter("type",type)
				.setParameter("programId",programId)
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
	public boolean removeProgramPermission(String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
	
			ProgramAdmin p = (ProgramAdmin)session.get(ProgramAdmin.class,Integer.parseInt(id));
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
	public String getDisplayName(ProgramAdmin p) throws Exception
	{
		
		if(p.getType().equalsIgnoreCase("LDAP"))
		{
			return p.getName();
		}
		return getDisplayName( LdapConnection.instance().getUserData(p.getName()),p.getName() );
	}
	public String getDisplayName(OrganizationAdmin p) throws Exception
	{
		
		if(p.getType().equalsIgnoreCase("LDAP"))
		{
			return p.getName();
		}
		return getDisplayName( LdapConnection.instance().getUserData(p.getName()),p.getName() );
	}
	public String getDisplayName(SystemAdmin p) throws Exception
	{
		
		if(p.getType().equalsIgnoreCase("LDAP"))
		{
			return p.getName();
		}
		return getDisplayName( LdapConnection.instance().getUserData(p.getName()),p.getName() );
	}
	private String getDisplayName(TreeMap<String,String> data, String name) throws Exception
	{
		StringBuilder toReturn  =  new StringBuilder();
		toReturn.append(data.get("cn"));
		return toReturn.toString();
	}
	
	@SuppressWarnings("unchecked")
	public List<ProgramAdmin> getAdminsForGroup(String id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<ProgramAdmin> toReturn = null;
		
		try
		{
			toReturn = session.createQuery("FROM ProgramAdmin WHERE program.id = :programId ORDER BY type,name").setParameter("programId",Integer.parseInt(id)).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
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
	@SuppressWarnings("unchecked")
	public List<String> getAccessProgramListForUser(String userid,List<String> userGroups)
	{
		List<String> toReturn = new ArrayList<String>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		String query="SELECT p FROM Program p, ProgramAdmin pa WHERE pa.program.id=p.id AND ( (pa.name in ("+buildIn(userGroups)+") AND pa.type='LDAP') OR (pa.type='Userid' AND pa.name=:userid) ) ";
		List<Program> programList = (List<Program>)session.createQuery(query)
				.setParameter("userid",userid)
				.list();
		
		for(Program p : programList)
		{
			toReturn.add(""+p.getId());
		}
		session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public HashMap<String,Program> getProgramsForUser(String userid,List<String> userGroups)
	{
		HashMap<String,Program> toReturn = new HashMap<String,Program>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		StringBuilder sql = new StringBuilder();
		String inGroups = buildIn(userGroups);
		sql.append("   select {p.*} ");
		sql.append("  from program p");
		sql.append("      ,program_admin pa ");
		sql.append(" where pa.program_id = p.id");
		sql.append("   and (pa.name in (");
		sql.append(inGroups);
		sql.append(") and type='LDAP' ");
		sql.append("        OR");
		sql.append("        pa.name =:userid and type='Userid' )");
		@SuppressWarnings("unchecked")
		List<Program> programs = (List<Program>)session.createSQLQuery(sql.toString())
						.addEntity("p",Program.class)
						.setParameter("userid",userid)
						.list();
				
		for(Program p : programs)
		{
			toReturn.put(""+p.getId(), p);
		}
				
		session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public HashMap<String,Organization> getOrganizationsForUser(String userid,List<String> userGroups)
	{
		HashMap<String,Organization> toReturn = new HashMap<String,Organization>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		StringBuilder sql = new StringBuilder();
		String inGroups = buildIn(userGroups);
		sql.append("   select {o.*} ");
		sql.append("  from organization o");
		sql.append("      ,organization_admin oa ");
		sql.append(" where oa.organization_id = o.id");
		sql.append("   and (oa.name in (");
		sql.append(inGroups);
		sql.append(") and type='LDAP' ");
		sql.append("        OR");
		sql.append("        oa.name =:userid and type='Userid' )");
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
	
	
	
	
	public boolean isSysadmin(String userid,List<String> userGroups)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		boolean toReturn =  false;
		try
		{
			//get Groups for user
			toReturn =  !session.createQuery("FROM SystemAdmin  WHERE (name in ("+buildIn(userGroups)+") AND type='LDAP') OR (type='Userid' AND name=:userid)")
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
	public List<Department> getDepartmentsForUser(String userid, boolean sysadmin) throws Exception
	{
		List<Department> departments = null;
		if(userid == null)
		{
			return null;
		}
		LdapConnection ldap = LdapConnection.instance();
		ArrayList<String> depts = null;
		try
		{
			depts = ldap.getUserDepartments(userid);
		}
		catch(Exception e)
		{ 
			departments = new ArrayList<Department>(0);
			depts = new ArrayList<String>(0);
		}
		if(!sysadmin && depts.isEmpty())
		{
			return departments;
		}
		StringBuilder in = new StringBuilder();
		for(String dept: depts)
		{
			in.append("'");
			in.append(dept);
			in.append("',");
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		
		try
		{
			if(sysadmin)
			{
				departments = (List<Department>)session.createQuery("FROM Department ORDER BY lower(name)").list();
			}
			else
			{
				//@SuppressWarnings("unchecked") promoted to method
				departments = (List<Department>)session.createQuery("FROM Department WHERE ldapName in (" +  in.substring(0,in.length()-1) +")").list();
				logger.error("FROM Department WHERE ldapName in (" +  in.substring(0,in.length()-1) +")");
				boolean deptsCreated = false;
				for(String dept: depts)
				{
					boolean found = false;
					for(Department d : departments)
					{
						if(d.getName().equals(dept))
						{
							found = true;
							break;
						}
					}
					if(!found)
					{
						Department tempDept = new Department();
						tempDept.setName(dept);
						tempDept.setLdapName(dept);
						logger.error("Dept with ldap_name["+dept+"] not found");
						session.save(tempDept);
						deptsCreated = true;
					}
				}
				if(deptsCreated)
				{
					//@SuppressWarnings("unchecked") promoted to method
					departments = (List<Department>)session.createQuery("FROM Department WHERE ldapName in (" +  in.substring(0,in.length()-1) +")").list();
				}
			}
			session.getTransaction().commit();

		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return departments;
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
		List<Department> accessDepartments = getDepartmentsForUser(userid,sysadmin);
		if(accessDepartments == null  || accessDepartments.isEmpty())
		{ //user is NOT in any departments
			return false;
		}
		
		StringBuilder in = new StringBuilder();
		for(Department dept: accessDepartments)
		{
			
			in.append(dept.getId());
			in.append(",");
		}
		Course course = offering.getCourse();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT {d.*} ");
		sql.append("  FROM department d,");
		sql.append("       program_admin pa,");
		sql.append("       link_course_program lcp");
		sql.append(" WHERE d.id = pa.name");
		sql.append("   AND pa.type='deptId' ");
		sql.append("   AND pa.program_id = lcp.program_id");
		sql.append("   AND lcp.course_id = :courseId");
		sql.append("   AND d.id in (");
		sql.append( in.substring(0,in.length()-1) );
		sql.append(")");
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Department> departmentsWithAccessToCourseForUser = null;
		try
		{
			departmentsWithAccessToCourseForUser = (List<Department>)session.createSQLQuery(sql.toString())
					.addEntity("d",Department.class)
					.setParameter("courseId",course.getId())
				.list();
			
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return !departmentsWithAccessToCourseForUser.isEmpty();
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
	private static String buildIn(List<String> values)
	{
		StringBuilder r = new StringBuilder();
		if(values == null || values.isEmpty())
		{
			return "''";
		}
		r.append("'bogus'");
		for(String s : values)
		{
			r.append(",'");
			r.append(s);
			r.append("'");
		}
		return r.toString();
	}
	
}
