package ca.usask.gmcte.util;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import ca.usask.gmcte.currimap.model.Organization;

public class HibernateUtil
{
	private static Logger logger = Logger.getLogger(HibernateUtil.class);
	private static SessionFactory sessionFactory;
	private static int retryCount = 2;
	private static boolean emailSent = false;

	private static void initSessionFactory()
	{
		logger.error("Attempting to initialize connection!");
		// Create the SessionFactory from hibernate.cfg.xml
		sessionFactory = new Configuration().configure().buildSessionFactory();
	}

	private static boolean connectionOkay(SessionFactory factory)
	{
		try
		{
			Session session = factory.getCurrentSession();
			session.beginTransaction();
			session.get(Organization.class, -1);
			session.getTransaction().commit();
			return true;
		} catch (Exception e)
		{
			logger.fatal("ERROR IN connectionOkay ", e);
			if (!emailSent)
			{
				HTMLTools.sendEmailMessage("guus.v@usask.ca",
						"ulc_events@usask.ca", "Connection error in Currimap!",
						"You better go and check it ouT");
				emailSent = true;
			}
			return false;
		}

	}

	public static SessionFactory getSessionFactory()
	{
		// return sessionFactory;
		if (sessionFactory == null)
			initSessionFactory();

		if (connectionOkay(sessionFactory))
		{
			retryCount = 2;
			emailSent = false;
			return sessionFactory;
		} 
		else
		{
			retryCount--;
			initSessionFactory();
			logger.error("ERROR retryCount = " + retryCount);
			if (retryCount > 0)
				return getSessionFactory();
			else
			{
				if (!emailSent)
				{
					HTMLTools.sendEmailMessage("guus.v@usask.ca",
							"ulc_events@usask.ca", "Connection error in Currimap!",
							"You better go and check it out");
					emailSent = true;
				}
				throw new ExceptionInInitializerError("Unable to establish connection");
			}

		}
	}

	public static void logException(Logger log, Exception e)
	{
		StackTraceElement[] stack = e.getStackTrace();
		StringBuilder stackString = new StringBuilder("\n\t\t");
		stackString.append(e.getClass().getName());
		stackString.append("\n\t\t");
		if (e.getCause() != null && e.getCause().getMessage() != null)
			stackString.append(e.getCause().getMessage());
		stackString.append("\n\t\t");
		stackString.append(e.toString());
		stackString.append("\n\t\t");
		boolean caFound = false;
		for (int i = 0; i < stack.length; i++)
		{
			stackString.append(stack[i]);
			stackString.append("\n\t\t");
			if (stack[i].getClassName().startsWith("ca.usask"))
			{
				if (caFound)
					break;
				else
					caFound = true;
			}
		}

		log.error("Exception ocurred during SQL processing\n "
				+ stackString.toString());
	}
	public static String getListAsString(String field, List<String> list , boolean addAnd)
	{
		if(list == null || list.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(field);
		sb.append(" IN (");
		boolean first = true;
		for(String s : list)
		{
			if(first)
				first = false;
			else
				sb.append(",");
			sb.append("'");
			sb.append(s);
			sb.append("'");	
		}
		sb.append(")");
		if(addAnd)
			sb.append(" AND ");
		return sb.toString();
	}

}