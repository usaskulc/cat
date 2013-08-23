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


package ca.usask.ulc.filters;

import ca.usask.ocd.ldap.LdapConnection;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.log4j.*;


public final class ULDAPFilter implements Filter
{
	
	private FilterConfig filterConfig=null;
	
	private static Logger logger = Logger.getLogger( ULDAPFilter.class );
	private ArrayList<String> groupsAllowed;
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		// grab the session and HttpServletRequest from the ServletRequest
		javax.servlet.http.HttpServletRequest local=(javax.servlet.http.HttpServletRequest)request;
		HttpSession session=local.getSession(true);
		//attempt to get the userobject from the session

		StringBuffer requestURLBuffer = local.getRequestURL();
		logger.debug("URL requested (before rebuilding)"+requestURLBuffer.toString());
		String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
		LdapConnection ldap=null;
		ArrayList<String> uldapRolesForUser=null;
		
		try
		{
			ldap=LdapConnection.instance();
		
		//	uldapRolesForUser=ldap.getUserGroupsIncludingSelf(userid);
		}
		catch(Exception e)
		{}
		if(uldapRolesForUser==null)
		{
			HttpServletResponse r=(HttpServletResponse)response;
			r.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			r.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,"Unable to retrieve uLDAP groups");
			return;
		}
		
		boolean okayToContinue=false;
		for(int i=0;i<groupsAllowed.size() && !okayToContinue ; i++)
		{
			okayToContinue=uldapRolesForUser.contains(groupsAllowed.get(i));
		}
		if(!okayToContinue)
		{
			HttpServletResponse r=(HttpServletResponse)response;
			r.setStatus(HttpServletResponse.SC_FORBIDDEN);
			r.sendError(HttpServletResponse.SC_FORBIDDEN,"You are not permitted to access this application");
			return;
		}
		chain.doFilter(request,response);
	}
	
	
	public void destroy()
	{
		this.filterConfig=null;
	}
	
	public void init(FilterConfig filterConfig)
	{
		this.filterConfig=filterConfig;
		if (groupsAllowed==null || groupsAllowed.size()<1)
		{
			groupsAllowed=new ArrayList<String>();
		    String groupString = this.filterConfig.getInitParameter("groupsAllowed");
		    String[] groups = groupString.split(",");
		    for(int i=0;i<groups.length;i++)
		    {
		    	groupsAllowed.add(groups[i]);
		    }
		}	
	}
	 
}
