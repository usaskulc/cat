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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;


public final class CasLogoutFilter implements Filter
{
	private FilterConfig filterConfig=null;
	
	private static Logger logger = Logger.getLogger( CasLogoutFilter.class );

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		HttpServletRequest local=(HttpServletRequest)request;
		HttpSession session=local.getSession(true);
		// clear local session 
		session.removeAttribute("edu.yale.its.tp.cas.client.filter.user");

		session.removeAttribute("userIsSysadmin");
		session.removeAttribute("userHasAccessToOfferings");
		session.removeAttribute("userHasAccessToOrganizations");
		session.removeAttribute("userHasAccessToOrganizations");

		session.removeAttribute("sessionInitialized");
		session.removeAttribute("JSESSIONID");
		
		// goto CAS logout url to clear CAS session
		String url = filterConfig.
			getInitParameter("ca.usask.ulc.filters.CasLogoutFilter.url");
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		httpResponse.sendRedirect(url);
		return;
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
