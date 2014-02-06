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

public class WorkshopDataFixer
{

	private static Logger logger = Logger.getLogger(WorkshopDataFixer.class);
	Connection con = null;
	
	
	public void insertLinks()
	{
			List<Integer> ids = new ArrayList<Integer>();
			List<String> names = new ArrayList<String>();
			
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
         	stmt = con.prepareStatement("select id,name from presenter");
         	rs = stmt.executeQuery();
            while(rs.next())
            {
            	ids.add(rs.getInt(1));
            	names.add(rs.getString(2));
            }
            
            for (int i = 2 ;i < names.size(); i++)
            {
            	String name = names.get(i);
           
            	String insert = "insert into link_workshop_presenter (presenter_id, workshop_id) SELECT "+ids.get(i)+",g.id FROM gmcws g WHERE lower(g.wsinst) LIKE '%"+name.toLowerCase()+"%'";
            	stmt = con.prepareStatement(insert);
            	System.out.println("Inserted: "+stmt.executeUpdate());
            }
            
			} catch (Exception e)
			{
				logger.error(e);
			} finally
			{
				if (rs != null){try{rs.close();} catch (Exception e){}}
				if (stmt != null){try{stmt.close();} catch (Exception e){}}
				
			}
	}
	
	public void getData()
	{
		List<String> skipped = new ArrayList<String>();
		ArrayList<String> allData = new ArrayList<String>();
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
					ArrayList<String> all= new ArrayList<String>();
					
					String instr = rs.getString(1);
					
					all.add(instr);
			
					all = this.breakApart(all," and ");
				all = this.breakApart(all,"(");
			//	System.out.print("\nafter (");
		//		printArray(all);
				all = this.breakApart(all,")");
				//System.out.print("\nafter )");
				//printArray(all);
				all = this.breakApart(all,"&");
				//System.out.print("\nafter &");
				//printArray(all);
				all = this.breakApart(all,";");
				//System.out.print("\nafter \"and \"");
				//printArray(all);
				all = this.breakApart(all," - ");
				//System.out.print("\nafter -");
				//printArray(all);
				all = this.breakApart(all,",");
				System.out.println("\n\n"+instr);
				printArray(all);
				
				allData.addAll(all);
				}
			} catch (Exception e)
			{
				logger.error(e);
			} finally
			{
				if (rs != null){try{rs.close();} catch (Exception e){}}
				if (stmt != null){try{stmt.close();} catch (Exception e){}}
				
			}
		/*	System.out.println("++++++++++++++++++++++++++++++++++");
			List<String> departments = new ArrayList<String>();
			List<String> names = new ArrayList<String>();
			
			for(String p:presenters)
			{
				int comma = p.indexOf(",");
				if(comma>-1)
				{
					ArrayList<String> newDept = breakApart(p.substring(comma+1));
					for(String dept: newDept)
					{
						if(!departments.contains(dept))
							departments.add(dept);
					}
					String first = p.substring(0,comma).trim();
					int dash = first.indexOf("-");
					if(dash> -1)
					{
						String beforeDash = first.substring(0,dash).trim();
						String afterDash = first.substring(dash+1).trim();
						departments.add(afterDash);
						names.add(beforeDash);
					}
					else
					{
						names.add(p.substring(0,comma));
					}
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
			*/
			System.out.println("++++++++++++++++++++++++++++++++++");
			Scanner in = new Scanner(System.in);
			
			for(String p:allData)
			{
			//	System.out.println(p);
			//	String read = in.nextLine();
				String type = getType(p);
				if(type == null)
				{
					System.out.println("TODO   "+p);
					String read = in.nextLine();
					if(read.trim().equals("d"))
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
					else if(read.trim().equals("p"))
					{
						type="presenter";
					}
					
					else if(read.trim().equals("s"))
					{
						System.out.println("SKIP   "+p);
						skipped.add(p);
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
			/*
			for(String p1:names)
			{
				for(String p: breakApart(p1) )
				{
					System.out.println(p);
					String type = getType(p);
					if(type == null)
					{
						System.out.println("TODO   "+p);
						String read = in.nextLine();
						if(read.trim().equals("d"))
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
						else if(read.trim().equals("p"))
						{
							type="presenter";
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
	
			}*/
			
			for(String p:skipped)
			{
				System.out.println(p);
			}
		
	}
	
	private void printArray(ArrayList<String> list)
	{
		for(String s:list)
		{
			System.out.print("["+s+"] ");
		}
	}

	private ArrayList<String> breakApart(ArrayList<String> list, String  separator)
	{
		ArrayList<String> r = new ArrayList<String>();
		for(String s:list)
		{
			int start = 0;
			int loc = s.indexOf(separator);
			if(loc<0)
			{
				r.add(s);
			}
			else
			{
				while(loc >= 0)
				{
					String before = s.substring(start,loc).trim();
					if(before.length()>0)
						r.add(before);
					start = loc+separator.length();
					loc = s.indexOf(separator,start);
				}
				String after = s.substring(start).trim();
				if(after.length()>0)
					r.add(after);
			}
		}
		return r;
	}
	private ArrayList<String> cleanUpList(ArrayList<String> list)
	{
		ArrayList<String> r = new ArrayList<String>();
		for(String s : list)
		{
			r.add(cleanUp(s,"-"));
			r.add(cleanUp(s,"-"));
				
		}
		return r;
	}
	private String cleanUp(String s,String toRemove)
	{
		s = s.trim();
		if(s.endsWith(toRemove))
		{
			s = s.substring(s.length()-1);
		}
		if(s.startsWith(toRemove))
		{
			s = s.substring(1);
		}
		
		return s.trim();
	}
	
	private String getType(String name)
	{
		String[] types = {"department","college","institution","presenter"};
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try
		{
			for(int i = 0; i<types.length ; i++)
			{
				String checkIfExistsQuery = "SELECT * FROM "+types[i]+" where lower(name) = ?";
				
			
				stmt = con.prepareStatement(checkIfExistsQuery);
				stmt.setString(1,name);
				rs = stmt.executeQuery();
				if(rs.next())
					return types[i];
			}
			return null;
		} catch (Exception e)
		{
			logger.error(e);
			return null;
		} finally
		{
			if (rs != null){try{rs.close();} catch (Exception e){}}
			if (stmt != null){try{stmt.close();} catch (Exception e){}}
		}
		
	}
	
	
	private int insert(String name,String type)
	{
		String checkIfExistsQuery = "SELECT * FROM "+type+" where lower(name) = ?";
		String insert = "INSERT INTO "+type+" (name) values (?)";
		if(type.equals("presenter"))
		{
			insert = "INSERT INTO "+type+" (name,system_id) values (?,1)";
		}
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
	
	public void test()
	{
		ArrayList<String> t = new ArrayList<String>();
		t.add("Gregory L. Juliano - University of Manitoba");
		t = this.breakApart(t,"-");
		printArray(t);
		
	}
	
	public void destroy()
	{
		quit();
	}
	public void quit()
	{
		System.out.println("Cleaning up!");
		if (con != null){try{con.close();} catch (Exception e){}}
	}
	
	public static void main(String[] arg)
	{
		WorkshopDataFixer ws = new WorkshopDataFixer();
		//ws.insertLinks();
		ws.getData();
		ws.quit();
		//ws.test();
	}

}
