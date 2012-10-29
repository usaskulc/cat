package ca.usask.gmcte.currimap.action;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Course;
import ca.usask.gmcte.currimap.model.CourseAttribute;
import ca.usask.gmcte.currimap.model.CourseAttributeValue;
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.Department;
import ca.usask.gmcte.currimap.model.InstructorAttribute;
import ca.usask.gmcte.currimap.model.InstructorAttributeValue;
import ca.usask.gmcte.currimap.model.LinkOrganizationOrganizationOutcome;
import ca.usask.gmcte.currimap.model.LinkProgramOutcomeOrganizationOutcome;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.OrganizationOutcome;
import ca.usask.gmcte.currimap.model.OrganizationOutcomeGroup;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.ProgramOutcome;
import ca.usask.gmcte.currimap.model.to.ObjectPair;
import ca.usask.gmcte.util.HTMLTools;
import ca.usask.gmcte.util.HibernateUtil;

public class OrganizationManager
{
	private static OrganizationManager instance;
	private static Logger logger = Logger.getLogger(OrganizationManager.class);

	public boolean save(String name, String parentId,int departmentId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		Organization o = new Organization();
		if(HTMLTools.isValid(parentId))
		{
			Organization parent = (Organization) session.get(Organization.class,Integer.parseInt(parentId));
			o.setParentOrganization(parent);
		}
		Department department  = (Department)session.get(Department.class,departmentId);
		o.setDepartment(department);
		o.setName(name);
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

	public boolean update(String id, String name, int departmentId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{

		Organization o = (Organization) session.get(Organization.class,
				Integer.parseInt(id));
		o.setName(name);
		Department department  = (Department)session.get(Department.class,departmentId);
		o.setDepartment(department);
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
	public boolean saveOrganizationOutcomeGroupNameById(String value, int organizationOutcomeGroupId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcomeGroup o = (OrganizationOutcomeGroup) session.get(OrganizationOutcomeGroup.class,organizationOutcomeGroupId);
			o.setName(value);
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
	
	public boolean saveNewOrganizationOutcomeNameAndOrganization(String value, int organizationId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcomeGroup o = new OrganizationOutcomeGroup();
			o.setOrganizationSpecific( organizationId < 0? "N": "Y");
			o.setOrganizationId(organizationId);
			o.setName(value);
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
	public boolean saveOrganizationOutcomeNameById(String value, int organizationOutcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcome o = (OrganizationOutcome) session.get(OrganizationOutcome.class,organizationOutcomeId);
			o.setName(value);
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
	
	public boolean saveNewOrganizationOutcomeNameAndGroup(String value, int organizationOutcomeGroupId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcome o = new OrganizationOutcome();
			OrganizationOutcomeGroup group = (OrganizationOutcomeGroup) session.get(OrganizationOutcomeGroup.class,organizationOutcomeGroupId);
			o.setGroup(group);
			o.setDescription("");
			o.setName(value);
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
	public boolean saveOrganizationOutcomeDescriptionById(String value, int organizationOutcomeId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			OrganizationOutcome o = (OrganizationOutcome) session.get(OrganizationOutcome.class,organizationOutcomeId);
			o.setDescription(value);
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
	public Organization getOrganizationById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Organization o = null;
		try
		{
			o = (Organization) session.get(Organization.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return o;
	}
	@SuppressWarnings("unchecked")
	public List<InstructorAttribute> getInstructorAttributes(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<InstructorAttribute> toReturn = null;
		try
		{
			toReturn = (List<InstructorAttribute>) session.createQuery("FROM InstructorAttribute WHERE organization.id=:orgId ORDER BY name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}

	public TreeMap<String, ObjectPair> getOrganizationOfferings(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		TreeMap<String, ObjectPair> toReturn = new TreeMap<String, ObjectPair>();
		try
		{
			List<CourseOffering> courseOfferings = getOrganizationOfferings(o,session);
			for(CourseOffering offering: courseOfferings)
			{
				String display = offering.getFullDisplay();
				Boolean[] completion = CourseManager.instance().completedRecord(offering, session);
				toReturn.put(display, new ObjectPair(offering,completion));
			}
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseOffering> getOrganizationOfferings(Organization o, Session session)
	{
		return (List<CourseOffering>) session.createQuery("FROM CourseOffering co WHERE co.course.id in (SELECT l.course.id FROM LinkCourseDepartment l WHERE l.department.id = :deptId) order by co.course.subject, co.course.courseNumber, co.term, co.sectionNumber")
					.setParameter("deptId",o.getDepartment().getId()).list();
	}
	
	
	public boolean addAttribute(Organization o, String toAdd)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
		InstructorAttribute newA = new InstructorAttribute();
		newA.setName(toAdd);
		newA.setOrganization(o);
		session.save(newA);
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
	public boolean removeAttribute(int toRemoveId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		@SuppressWarnings("unchecked")
		List<InstructorAttributeValue> existing = (List<InstructorAttributeValue>)session.createQuery("FROM InstructorAttributeValue WHERE attribute.id = :attrId" ).setParameter("attrId",toRemoveId).list();
		for(InstructorAttributeValue toDel : existing)
		{
			session.delete(toDel);
		}
		InstructorAttribute o = (InstructorAttribute)session.get(InstructorAttribute.class,toRemoveId);
		session.delete(o);
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
	public boolean removeAttributeValue(int toRemoveId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		InstructorAttributeValue o = (InstructorAttributeValue)session.get(InstructorAttributeValue.class,toRemoveId);
		session.delete(o);
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
	public List<Course> getAllCourses(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Course> toReturn = null;
		try
		{
			toReturn = (List<Course>) session.createQuery("SELECT distinct l.course FROM LinkCourseProgram l WHERE l.program.organization.id=:orgId ORDER BY l.course.subject, l.course.courseNumber").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseAttribute> getCourseAttributes(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseAttribute> toReturn = null;
		try
		{
			toReturn = (List<CourseAttribute>) session.createQuery("FROM CourseAttribute WHERE organization.id=:orgId ORDER BY name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public boolean addCourseAttribute(Organization o, String toAdd)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		
		CourseAttribute newA = new CourseAttribute();
		newA.setName(toAdd);
		newA.setOrganization(o);
		session.save(newA);
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
	public boolean removeCourseAttribute(int toRemoveId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		@SuppressWarnings("unchecked")
		List<CourseAttributeValue> existing = (List<CourseAttributeValue>)session.createQuery("FROM CourseAttributeValue WHERE attribute.id = :attrId" ).setParameter("attrId",toRemoveId).list();
		for(CourseAttributeValue toDel : existing)
		{
			session.delete(toDel);
		}
		CourseAttribute o = (CourseAttribute)session.get(CourseAttribute.class,toRemoveId);
		session.delete(o);
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
	public boolean removeCourseAttributeValue(int toRemoveId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		CourseAttributeValue o = (CourseAttributeValue)session.get(CourseAttributeValue.class,toRemoveId);
		session.delete(o);
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
	
	
	public Organization getOrganizationByProgram(Program p)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Organization o = null;
		try
		{
			o = (Organization) session.createQuery(
				"select p.organization from Program p where p.id=:programId").setParameter("programId",p.getId()).uniqueResult();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return o;
	}
	public Organization getOrganizationByProgramId(String programId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Organization o = null;
		try
		{
			o = (Organization) session.createQuery(
				"select p.organization from Program p where p.id=:programId").setParameter("programId",Integer.parseInt(programId)).uniqueResult();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return o;
	}

	@SuppressWarnings("unchecked")
	public TreeMap<Organization, ArrayList<Organization>> getOrganizationsOrderedByName()
	{
		TreeMap<Organization, ArrayList<Organization>> toReturn = new TreeMap<Organization,ArrayList<Organization>>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			List<Organization> list = (List<Organization>) session.createQuery(
					"from Organization WHERE parentOrganization is null order by name").list();
			for(Organization o : list)
			{
				ArrayList<Organization> children =  getChildrenForParentOrganization(o, session);
				toReturn.put(o, children);
			}
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<Organization> getParentOrganizationsOrderedByName()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Organization> list = null;
		try
		{
			list = (List<Organization>) session.createQuery(
					"from Organization WHERE parentOrganization is null order by name").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<Organization> getAllOrganizations()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Organization> list = null;
		try
		{
			list = (List<Organization>) session.createQuery(
					"from Organization order by lower(name)").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepartments()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Department> list = null;
		try
		{
			list = (List<Department>) session.createQuery(
					"from Department order by lower(name)").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Organization> getChildOrganizationsOrderedByName(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Organization> list = null;
		try
		{
			list = (List<Organization>) session
					.createQuery("from Organization WHERE parentOrganization.id=:orgId order by name")
					.setParameter("orgId",o.getId())
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	
	public boolean removeOrganizationOutcome(int outcomeLinkId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkOrganizationOrganizationOutcome l = (LinkOrganizationOrganizationOutcome) session.get(LinkOrganizationOrganizationOutcome.class, outcomeLinkId);
			session.delete(l);
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
	public boolean removeLinkProgramOutcomeOrganizationOutcome(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkProgramOutcomeOrganizationOutcome l = (LinkProgramOutcomeOrganizationOutcome) session.get(LinkProgramOutcomeOrganizationOutcome.class, id);
			session.delete(l);
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
	public boolean saveProgramOutcomeOrganizationOutcome(int outcomeId, int organizationOutcomeId,int programId)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			LinkProgramOutcomeOrganizationOutcome o = new LinkProgramOutcomeOrganizationOutcome();
			
			ProgramOutcome outcome = (ProgramOutcome) session.get(ProgramOutcome.class,outcomeId);
			OrganizationOutcome oOutcome  = (OrganizationOutcome)session.get(OrganizationOutcome.class,organizationOutcomeId);
			Program program  = (Program)session.get(Program.class,programId);
			o.setProgram(program);
			o.setProgramOutcome(outcome);
			o.setOrganizationOutcome(oOutcome);
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
	public OrganizationOutcome getOrganizationOutcomeById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		OrganizationOutcome o = null;
		try
		{
			o = (OrganizationOutcome) session.get(OrganizationOutcome.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return o;
	}
	
	public OrganizationOutcomeGroup getOrganizationOutcomeGroupById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		OrganizationOutcomeGroup o = null;
		try
		{
			o = (OrganizationOutcomeGroup) session.get(OrganizationOutcomeGroup.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return o;
	}
	@SuppressWarnings("unchecked")
	public List<OrganizationOutcome> getOrganizationOutcomesForOrg(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<OrganizationOutcome> toReturn = null;
		try
		{
			toReturn = (List<OrganizationOutcome>)session.createQuery("FROM OrganizationOutcome o WHERE (o.group.organizationSpecific = 'Y' AND o.group.organizationId = :orgId) OR (o.group.organizationSpecific = 'N') order by o.group.name, o.name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<OrganizationOutcome> getOrganizationOutcomeForGroup(OrganizationOutcomeGroup group)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<OrganizationOutcome> toReturn = null;
		try
		{
			toReturn = (List<OrganizationOutcome>)session.createQuery("FROM OrganizationOutcome o WHERE o.group.id = :groupId order by o.group.name, o.name").setParameter("groupId",group.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<OrganizationOutcomeGroup> getOrganizationOutcomeGroupsForOrg(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<OrganizationOutcomeGroup> toReturn = null;
		try
		{
			toReturn = (List<OrganizationOutcomeGroup>)session.createQuery("FROM OrganizationOutcomeGroup o WHERE (o.organizationSpecific = 'Y' AND o.organizationId = :orgId) OR (o.organizationSpecific = 'N') order by o.organizationSpecific DESC, o.name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<LinkOrganizationOrganizationOutcome> getLinkOrganizationOrganizationOutcomeForOrg(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkOrganizationOrganizationOutcome> toReturn = null;
		try
		{
			toReturn = (List<LinkOrganizationOrganizationOutcome>)session.createQuery("from LinkOrganizationOrganizationOutcome l where l.organization.id = :orgId order by l.organizationOutcome.group.name, l.organizationOutcome.name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<OrganizationOutcomeGroup> getOrganizationOutcomeGroupsOrganization(Organization o)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<OrganizationOutcomeGroup> toReturn = null;
		try
		{
			toReturn = (List<OrganizationOutcomeGroup>)session.createQuery("SELECT distinct l.organizationOutcome.group from LinkOrganizationOrganizationOutcome l where l.organization.id = :orgId order by l.organizationOutcome.group.name").setParameter("orgId",o.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<LinkOrganizationOrganizationOutcome> getOrganizationOutcomeForGroupAndOrganization(Organization o,OrganizationOutcomeGroup group )
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkOrganizationOrganizationOutcome> toReturn = null;
		try
		{
			toReturn = (List<LinkOrganizationOrganizationOutcome>)session
			.createQuery("from LinkOrganizationOrganizationOutcome l where l.organization.id = :orgId AND l.organizationOutcome.group.id = :groupId order by l.organizationOutcome.name")
			.setParameter("orgId",o.getId())
			.setParameter("groupId",group.getId())
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
	public ArrayList<Organization> getChildrenForParentOrganization(Organization o, Session session)
	{
		return (ArrayList<Organization>)session.createQuery("FROM Organization where parentOrganization.id = :organizationId ORDER BY name").setParameter("organizationId",o.getId()).list();
	}
	@SuppressWarnings("unchecked")
	public List<LinkProgramOutcomeOrganizationOutcome> getProgramOutcomeLinksForOrganizationOutcome(Program program, OrganizationOutcome oo)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkProgramOutcomeOrganizationOutcome> toReturn = null;
		try
		{
			toReturn = (List<LinkProgramOutcomeOrganizationOutcome>)session.createQuery("from LinkProgramOutcomeOrganizationOutcome l where l.organizationOutcome.id = :orgOutcomeId AND l.program.id=:programId order by l.programOutcome.group.name, l.programOutcome.name")
				.setParameter("orgOutcomeId",oo.getId())
				.setParameter("programId",program.getId())
				.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}

	public OrganizationManager()
	{

	}

	public static OrganizationManager instance()
	{
		if (instance == null)
		{
			instance = new OrganizationManager();
		}
		return instance;

	}

}
