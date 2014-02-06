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


package ca.usask.gmcte.util;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import org.apache.log4j.*;

/**
 * A thin wrapper around tomcat's connection pooling functionality
 *
 * @author rss050
 * @author cab938
 */
public class ConnectionTool
{
    private static Logger logger = Logger.getLogger( ConnectionTool.class );

    public static int leaks = 0;

	/**
	 * Provides a database connection.
	 * 
	 * Note: if it is returning null mysteriously, make sure you have the database
	 * drivers in tomcat's common/lib directory!
	 *
	 * @param dbname The name of the database to connect to (a magic string)
	 * @return the connection, or null on error.
	 */
	public static Connection getConnection(String dbname)
	{
	//	if ( logger.isDebugEnabled() ){ logger.log( Level.DEBUG , "getConnection(String)" ); }
		Connection conn = null;
		Logger log = Logger.getLogger(ConnectionTool.class);

		try
		{
			String standaloneProperty=System.getProperty("currimap.isStandalone");
			if(standaloneProperty!=null && standaloneProperty.equals("true")) 
			{
				return loadConnectionFromPropertyFile(dbname);
			}
			else
			{
				// get connection from tomcat context
				Context ctx = new InitialContext();

				DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/" + dbname);
			
				log.log(Level.DEBUG, "Context environment: " + ctx.getEnvironment());

				conn = ds.getConnection();

                leaks++;
			}
		}
		catch (Exception e)
		{
			log.error(e);
		}
		
		
		return conn;
	}
	public static Connection loadConnectionFromPropertyFile(String dbname) throws Exception
	{
		Connection con=null;
		java.util.ResourceBundle bundle= java.util.ResourceBundle.getBundle("database");
		int numDatabases = 	bundle.keySet().size()/5;

		String index = "db";
		for (int i = 0; i<numDatabases; i++)
		{
			if (bundle.getString("db"+i+".name") == null) //a number is missing
			{
				continue;
			}
			else if (bundle.getString("db"+i+".name").equalsIgnoreCase(dbname))
			{
				index+=i;
			}
		}
		String dbuserid = bundle.getString(index+".username");
		String dbpasswd = bundle.getString(index+".password");
		String driver = bundle.getString(index+".driver");
		String url = bundle.getString(index+".url");
		Class.forName(driver);
		con = DriverManager.getConnection(url,dbuserid,dbpasswd);
		return con;
	}

	public static void freeConnection(Connection conn)
	{
		//if ( logger.isDebugEnabled() ){ logger.log( Level.DEBUG , "freeConnection(Connection)" ); }
		// Always make sure the connection is returned to the pool

		if (conn != null)
		{
			try
			{
				conn.close();
                                leaks--;
			}
			catch (SQLException e)
			{
				;
			}
			conn = null;
		}
	}
	
	public static void freeStatement(Statement stmt)
	{
		//if ( logger.isDebugEnabled() ){ logger.log( Level.DEBUG , "freeStatement(Statement)" ); }
		// Ensure the Statement is properly cleaned up.

		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				;
			}
			stmt = null;
		}
	}

	public static void freePreparedStatement(PreparedStatement pstmt)
	{
	//	if ( logger.isDebugEnabled() ){ logger.log( Level.DEBUG , "freePreparedStatement(PreparedStatement)" ); }
		// Ensure the PreparedStatement is properly cleaned up.

		if (pstmt != null)
		{
			try
			{
				pstmt.close();
			}
			catch (SQLException e)
			{
				;
			}
			pstmt = null;
		}
	}
	
	public static void freeResultSet(ResultSet rs)
	{
	//	if ( logger.isDebugEnabled() ){ logger.log( Level.DEBUG , "freeResultSet(ResultSet)" ); }
		// Ensure the ResultSet is properly cleaned up.
		if (rs != null)
		{
			try
			{
				rs.close();
			}
			catch (SQLException e)
			{
				;
			}
			rs = null;
		}
	}
	
		public static void rollback(Connection conn)
	{
		logger.log( Level.INFO , "ROLLBACK called." ); 

		if (conn != null)
		{
			try
			{
				conn.rollback();
			}
			catch (SQLException e)
			{
					logger.log(Level.ERROR,"ROLLBACK failed! ", e);
			}
		}
	}

	public static void commit(Connection conn)
	{
		logger.log( Level.INFO , "Explicit COMMIT called." ); 
		if (conn != null)
		{
			try
			{
				conn.commit();
			}
			catch (SQLException e)
			{
					logger.log(Level.ERROR,"COMMIT failed! ", e);
			}
		}
	}

	public static void setAutoCommit(Connection conn, boolean status)
	{
		logger.log( Level.INFO , "Requested AUTO-COMMIT status change to: " + status ); 
		if (conn != null)
		{
			try
			{
				conn.setAutoCommit(status);
			}
			catch (SQLException e)
			{
					logger.log(Level.ERROR,"setAutoCommit() failed! ", e);
			}
		}
	}

}
