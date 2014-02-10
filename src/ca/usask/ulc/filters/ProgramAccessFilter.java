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

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ca.usask.gmcte.currimap.action.OrganizationManager;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.util.HTMLTools;


public final class ProgramAccessFilter implements Filter
{
	private FilterConfig filterConfig=null;
	
	private static Logger logger = Logger.getLogger( ProgramAccessFilter.class );
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		// grab the session and HttpServletRequest from the ServletRequest
		javax.servlet.http.HttpServletRequest local=(javax.servlet.http.HttpServletRequest)request;
		HttpSession session=local.getSession(true);
		StringBuffer requestURL = local.getRequestURL();
		//attempt to get the userobject from the session
		
			
		String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
		Boolean userIsSysadmin = (Boolean)session.getAttribute("userIsSysadmin");
	
		boolean hasAccess = false;
		
		//if user is sysadmin
		if(userIsSysadmin != null && userIsSysadmin)
		{
			// all is well, set okay bool to true
			hasAccess = true;
			chain.doFilter(request,response);
			return;
		}
			
		String programId = local.getParameter("program_id");
		String organizationId = local.getParameter("organization_id");
		
		boolean programFound = false;
		boolean organizationFound = false;
		
		//always pass through the loginCheck and javascript library request
		if(requestURL.indexOf("loginCheck") > 0)
		{
			chain.doFilter(request,response);
			return;
		}
		
			if(!HTMLTools.isValid(programId))
			{
				String[] values = local.getParameterValues("program_id");
				
				if(values != null && values.length > 0)
				{
					programId = values[0]; 
					programFound = true;
				}
			}
			else
			{
				programFound = true;
			}
			if(!HTMLTools.isValid(organizationId))
			{
				String[] values = local.getParameterValues("organization_id");
				
				if(values != null && values.length > 0)
				{
					organizationId = values[0]; 
					organizationFound = true;
				}
			}
			else
			{
				organizationFound = true;
			}
		
		if(!organizationFound && !programFound)
		{
			RequestDispatcher dispatcher=filterConfig.getServletContext().getRequestDispatcher("/error.jsp?message=Unable to retrieve program id");
			dispatcher.forward(request,response);
			logger.error(requestURL +" does not appear to have a required parameter associated with it");
			return;
		}
		
		
		if(organizationFound)
		{
			@SuppressWarnings("unchecked")
			HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
			hasAccess = userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(organizationId);
		}
		else if(programFound)
		{
			Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);
		
			@SuppressWarnings("unchecked")
			HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
			hasAccess = userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
		}

		if(!hasAccess)
		{
			RequestDispatcher dispatcher=filterConfig.getServletContext().getRequestDispatcher("/permissionDenied.jsp");
			dispatcher.forward(request,response);
			logger.error(userid + " attempted to access " + requestURL + " but does not have the proper access!");
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
	}
	 
}
