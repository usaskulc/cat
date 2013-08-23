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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.apache.log4j.Logger;

public class Presenter
{

	private static Logger logger = Logger.getLogger(WorkshopDataFixer.class);
	Connection con = null;
	
	public void getData()
	{
		List<String> presenters = new ArrayList<String>();
		
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try
			{
				// Load the JDBC driver
				String driverName = "com.mysql.jdbc.Driver";
				Class.forName(driverName);

				String userName = "gmtlc";
            String password = "flou3py";
            String url = "jdbc:mysql://localhost/gmtlc";
            con = DriverManager.getConnection (url, userName, password);// Create a connection to the database
				stmt = con.prepareStatement("select distinct(wsinst) from gmcws");
				int counter = 0;
				rs = stmt.executeQuery();
				while (rs.next())
				{
					String instr = rs.getString(1);
					
					System.out.println("["+instr+"]");
					int andIndex = instr.indexOf(" and ");
					if(andIndex>-1)
					{
						String first = instr.substring(0,andIndex).trim();
						String last = instr.substring(andIndex+4).trim();
						System.out.println("\t"+first + " ++++++ "+last);
						presenters.add(first);
						presenters.add(last);
						
					}
					else
					{
						presenters.add(instr);
					}
					
					counter++;
				}
				System.out.println("\n\n"+counter);
			} catch (Exception e)
			{
				logger.error(e);
			} finally
			{
				if (rs != null){try{rs.close();} catch (Exception e){}}
				if (stmt != null){try{stmt.close();} catch (Exception e){}}
				
			}
			System.out.println("++++++++++++++++++++++++++++++++++");
			List<String> departments = new ArrayList<String>();
			for(String p:presenters)
			{
				int comma = p.indexOf(",");
				if(comma>-1)
				{
					String newDept = cleanUp(p.substring(comma+1));
					if(!departments.contains(newDept))
						departments.add(newDept);
				}
			}
			
			System.out.println("++++++++++++++++++++++++++++++++++");
			for(String p:presenters)
			{
				if(p.indexOf("&")>-1)
					System.out.println("\t\t\t"+p);
				else
					System.out.println(p);
			}
			System.out.println("++++++++++++++++++++++++++++++++++");
			Scanner in = new Scanner(System.in);
			
			for(String p:departments)
			{
				System.out.println(p);
				String read = in.nextLine();
				String type = null;
				if(read.trim().length() == 0)
				{
					type="department";
				}
				else if(read.trim().equals("c"))
				{
					type="college";
				}
				else if(read.trim().equals("i"))
				{
					type="institution";
				}
				else if(read.trim().equals("s"))
				{
					System.out.println("SKIP   "+p);
				}
				if(type!=null)
				{
					int inserted = insert(p,type);
					if(inserted < 0)
					{
						System.out.println("NOT INSERTED");
					}
				}
	
			}
	}
	
	private String cleanUp(String s)
	{
		s = s.trim();
		if(s.endsWith(","))
		{
			s = s.substring(s.length()-1);
		}
		if(s.startsWith(","))
		{
			s = s.substring(1);
		}
		
		return s;
	}
	
	private int insert(String name,String type)
	{
		String checkIfExistsQuery = "SELECT * FROM "+type+" where lower(name) = ?";
		String insert = "INSERT INTO "+type+" (name) values (?)" +
				"";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try
		{
			stmt = con.prepareStatement(checkIfExistsQuery);
			stmt.setString(1,name);
			rs = stmt.executeQuery();
			if(rs.next())
				return 1;
			stmt = con.prepareStatement(insert);
			stmt.setString(1,name);
			return stmt.executeUpdate();
		
		} catch (Exception e)
		{
			logger.error(e);
			return -1;
		} finally
		{
			if (rs != null){try{rs.close();} catch (Exception e){}}
			if (stmt != null){try{stmt.close();} catch (Exception e){}}
		}
		
	}
	
		
	
	public void quit()
	{
		if (con != null){try{con.close();} catch (Exception e){}}
	}
	
	public static void main(String[] arg)
	{
		WorkshopDataFixer ws = new WorkshopDataFixer();
		ws.getData();
		ws.quit();
	}

}
