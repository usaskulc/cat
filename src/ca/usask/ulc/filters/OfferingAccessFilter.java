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

import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.util.HTMLTools;

public final class OfferingAccessFilter implements Filter
{
	private FilterConfig filterConfig = null;

	private static Logger logger = Logger.getLogger(OfferingAccessFilter.class);

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException
	{
		// grab the session and HttpServletRequest from the ServletRequest
		javax.servlet.http.HttpServletRequest local = (javax.servlet.http.HttpServletRequest) request;
		HttpSession session = local.getSession(true);
		StringBuffer requestURL = local.getRequestURL();
		// attempt to get the userobject from the session

		@SuppressWarnings("unchecked")
		// get list of programs from session
		HashMap<String, CourseOffering> userHasAccessToOfferings = (HashMap<String, CourseOffering>) session.getAttribute("userHasAccessToOfferings");
		String userid = (String) session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
		Boolean userIsSysadmin = (Boolean) session.getAttribute("userIsSysadmin");

		boolean hasAccess = false;
		// if user is sysadmin
		if (userIsSysadmin != null && userIsSysadmin)
		{
			// all is well
			hasAccess = true;
			chain.doFilter(request, response);
			return;
		}
		String courseOfferingId = local.getParameter("course_offering_id");

		if (requestURL.indexOf("loginCheck") > 0) 
			// if this is a login check request, we don't care about the parameter
		{
			chain.doFilter(request, response);
			return;
		}
		if (!HTMLTools.isValid(courseOfferingId))
		{
			String[] values = local.getParameterValues("course_offering_id");

			if (values == null || values.length == 0)
			{
				RequestDispatcher dispatcher = filterConfig.getServletContext().getRequestDispatcher("/error.jsp?message=Unable to retrieve course offering id");
				dispatcher.forward(request, response);
				logger.error(requestURL	+ " does not appear to have a course_offering_id parameter associated with it");
				return;
			}
			courseOfferingId = values[0];
		}

		// if program accessed is in the list
		hasAccess = userHasAccessToOfferings != null && userHasAccessToOfferings.containsKey(courseOfferingId);

		if (!hasAccess)
		{
			RequestDispatcher dispatcher = filterConfig.getServletContext().getRequestDispatcher("/permissionDenied.jsp");
			dispatcher.forward(request, response);
			if (requestURL.indexOf("loginCheck") < 0)
			{
				logger.error(userid + " attempted to access " + requestURL	+ " but does not have the proper access!");
			}
			return;
		}
		chain.doFilter(request, response);
	}

	public void destroy()
	{
		this.filterConfig = null;
	}

	public void init(FilterConfig filterConfig)
	{
		this.filterConfig = filterConfig;
	}

}
