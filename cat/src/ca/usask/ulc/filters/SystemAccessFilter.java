package ca.usask.ulc.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;


public final class SystemAccessFilter implements Filter
{
	private FilterConfig filterConfig=null;
	
	private static Logger logger = Logger.getLogger( SystemAccessFilter.class );

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		// grab the session and HttpServletRequest from the ServletRequest
		javax.servlet.http.HttpServletRequest local=(javax.servlet.http.HttpServletRequest)request;
		HttpSession session=local.getSession(true);
		StringBuffer requestURL = local.getRequestURL();
		//attempt to get the userobject from the session
		Boolean userIsSysadmin = (Boolean)session.getAttribute("userIsSysadmin");
		
		if( !(userIsSysadmin != null && userIsSysadmin))
		{
			RequestDispatcher dispatcher=filterConfig.getServletContext().getRequestDispatcher("/permissionDenied.jsp");
			dispatcher.forward(request,response);
			String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
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
