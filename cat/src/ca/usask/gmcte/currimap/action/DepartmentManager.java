package ca.usask.gmcte.currimap.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import ca.usask.gmcte.currimap.model.Characteristic;
import ca.usask.gmcte.currimap.model.CharacteristicType;
import ca.usask.gmcte.currimap.model.Course;
import ca.usask.gmcte.currimap.model.CourseOutcome;
import ca.usask.gmcte.currimap.model.Department;
import ca.usask.gmcte.currimap.model.LinkCourseProgram;
import ca.usask.gmcte.currimap.model.LinkDepartmentCharacteristicType;
import ca.usask.gmcte.currimap.model.LinkProgramProgramOutcome;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.util.HibernateUtil;

public class DepartmentManager
{
	private static DepartmentManager instance;
	private static Logger logger = Logger.getLogger(DepartmentManager.class);

	public boolean save(String name)
	{
		Department c = this.getDepartmentByName(name);
		if(c != null) //already exists, done.
		{
			return true;
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
		c = new Department();
		c.setName(name);
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
	
	public boolean saveCourseOutcomeValue(CourseOutcome o , String name)
        {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
                session.beginTransaction();
                try
                {
                	o.setName(name);
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
	public List<CharacteristicType> getDepartmentCharacteristicTypes(Department d)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CharacteristicType> toReturn = null;
		try
		{
			toReturn = (List<CharacteristicType>)session
			.createQuery("select ct from CharacteristicType ct, LinkDepartmentCharacteristicType ldct where ldct.department.id=:deptId and ldct.characteristicType = ct order by ldct.displayIndex")
			.setParameter("deptId",d.getId())
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
	public List<CharacteristicType> getCandidateCharacteristicTypes(List<Integer> alreadyUsed)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CharacteristicType> toReturn = null;
		try
		{
			StringBuilder queryString = new StringBuilder("select ct from CharacteristicType ct ");
			if(alreadyUsed.size()>0)
			{
				queryString.append("where ct.id not in (");
				queryString.append(inString(alreadyUsed));
				queryString.append(") ");
			}
			queryString.append(" order by ct.name");
			toReturn = (List<CharacteristicType>)session.createQuery(queryString.toString()).list();
			session.getTransaction().commit();
			}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	public boolean addCharacteristicToDepartment(int charId, int deptId)
	{
		boolean createSuccessful = false;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		try
		{
			Department d = (Department) session.get(Department.class, deptId);
			CharacteristicType cType = (CharacteristicType) session.get(CharacteristicType.class,charId);
			LinkDepartmentCharacteristicType link  = new LinkDepartmentCharacteristicType();
			int max = 0;
			try
			{
				max = (Integer)session.createQuery("select max(displayIndex) from LinkDepartmentCharacteristicType l where l.department.id = :deptId").setParameter("deptId",d.getId()).uniqueResult();
			}
			catch(Exception e)
			{
				logger.error("unable to determine max!",e);
			}
			
			link.setDisplayIndex(max+1);
			link.setCharacteristicType(cType);
			link.setDepartment(d);
			//p.getLinkProgramCharacteristicTypes().add(link);
			session.persist(link);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		createSuccessful = true;
		return createSuccessful;
	}
	public boolean moveCharacteristicType(int id, int charTypeId, String direction)
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
			List<LinkDepartmentCharacteristicType> existing = (List<LinkDepartmentCharacteristicType>)session.createQuery("select l from LinkDepartmentCharacteristicType l where l.department.id = :deptId order by l.displayIndex").setParameter("deptId",id).list();
			if(direction.equals("up"))
			{
				LinkDepartmentCharacteristicType prev = null;
				for(LinkDepartmentCharacteristicType link : existing)
				{
					if(link.getCharacteristicType().getId() == charTypeId && prev!=null)
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
				LinkDepartmentCharacteristicType prev = null;
				for(LinkDepartmentCharacteristicType link : existing)
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
					if(link.getCharacteristicType().getId() == charTypeId)
					{
						prev = link;
					}
					
				}
			}
			else if(direction.equals("delete"))
			{
				LinkDepartmentCharacteristicType toDelete = null;
				for(LinkDepartmentCharacteristicType link : existing)
				{
					if(toDelete !=null)
					{
						link.setDisplayIndex(link.getDisplayIndex()-1);
						session.merge(link);
					}
					if(link.getCharacteristicType().getId() == charTypeId)
					{
						toDelete = link;
					}
					
				}
				if(toDelete !=null)
				{
						session.delete(toDelete);
						done = true;
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
	
	@SuppressWarnings("unchecked")
	public List<CharacteristicType> setDepartmentCharacteristicTypes(Department d)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CharacteristicType> toReturn = null;
		try
		{
			toReturn = (List<CharacteristicType>)session.createQuery("select ct from CharacteristicType ct, LinkDepartmentCharacteristicType lpct where lpct.department.id=:deptId and lpct.characteristicType = ct  order by lpct.displayIndex")
					.setParameter("deptId",d.getId()).list();
			d.setCharacteristicTypes(toReturn);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	@SuppressWarnings("unchecked")
	public List<Characteristic> getProgramCharacteristics(Program p, int level)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Characteristic> toReturn = null;
		try
		{
			toReturn = (List<Characteristic>)session.createQuery("select c from Characteristic c, CharacteristicType ct, LinkProgramCharacteristicType lpct where lpct.program.id=:programId and lpct.displayIndex=:index and lpct.characteristicType = ct and c.characteristicType = ct order by c.displayIndex").setParameter("programId",p.getId()).setParameter("index",level).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
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

	@SuppressWarnings("unchecked")
	public List<Program> getProgramOrderedByName()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Program> list = null;
		try
		{
			list = (List<Program>) session.createQuery("from Program order by name").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Program> getProgramOrderedByNameForDepartment(Department dept)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Program> list = null;
		try
		{
			list = (List<Program>) session.createQuery("FROM Program p WHERE p.organization.department.id=:deptId order by lower(name)").setParameter("deptId",dept.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Program> getProgramOrderedByNameForDepartmentLinkedToCourse(Department dept, Course course)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Program> list = null;
		try
		{
			list = (List<Program>) session.createQuery("FROM Program p WHERE p.organization.department.id=:deptId and p.id in (SELECT l.program.id FROM LinkCourseProgram l WHERE l.course.id=:courseId) order by lower(name)")
					.setParameter("deptId",dept.getId())
					.setParameter("courseId", course.getId())
					.list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<CourseOutcome> getCourseOutcomesForDepartment(Department d)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<CourseOutcome> toReturn = null;
		try
		{
			toReturn = (List<CourseOutcome>)session.createQuery("from CourseOutcome l where l.group.departmentId=:deptId ORDER BY l.group.name, l.name").setParameter("deptId",d.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<String> getUsedCourseOutcomeIdsForDepartment(Department d)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<String> toReturn = new ArrayList<String>();;
		try
		{
			List<Integer> ids = (List<Integer>)session.createQuery("SELECT l.courseOutcome.id FROM LinkCourseOfferingOutcome l WHERE l.courseOutcome.group.departmentId=:deptId").setParameter("deptId",d.getId()).list();
			for(Integer id:ids)
			{
				toReturn.add(""+id);
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
	public List<LinkProgramProgramOutcome> getLinkProgramOutcomeForProgram(Program p)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkProgramProgramOutcome> toReturn = null;
		try
		{
			toReturn = (List<LinkProgramProgramOutcome>)session.createQuery("from LinkProgramOutcome l where l.program.id = :programId order by l.outcome.group.name, l.outcome.name").setParameter("programId",p.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<LinkCourseProgram> getLinkCourseProgramForProgram(Program p)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<LinkCourseProgram> toReturn = null;
		try
		{
			toReturn = (List<LinkCourseProgram>)session.createQuery("from LinkCourseProgram l where l.program.id = :programId order by l.time.displayIndex, l.course.subject, l.course.courseNumber ").setParameter("programId",p.getId()).list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepartments()
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List<Department> toReturn = null;
		try
		{
			toReturn = (List<Department>)session.createQuery("from Department order by name").list();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return toReturn;
	}
	
	public Department getDepartmentById(int id)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Department c = null;
		try
		{
			c = (Department) session.get(Department.class, id);
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
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
	public Department getDepartmentByName(String name)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Department c = null;
		try
		{
			c = (Department) session.createQuery("FROM Department WHERE name=:name").setParameter("name",name).uniqueResult();
			session.getTransaction().commit();
		}
		catch(Exception e)
		{
			HibernateUtil.logException(logger, e);
		}
		return c;
	}

	public DepartmentManager()
	{

	}

	public static DepartmentManager instance()
	{
		if (instance == null)
		{
			instance = new DepartmentManager();
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
