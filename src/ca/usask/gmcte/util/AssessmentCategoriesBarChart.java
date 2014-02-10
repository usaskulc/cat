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


import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.text.NumberFormat;
import java.util.List;
import java.util.ArrayList;

public class AssessmentCategoriesBarChart
{
		
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	private String text = "";
	final int width = 250;
	final int height = 300;
	private List<String> columnLabels;
	private List<Double> columnValues;
	private boolean[] periods;
	private Double maxColumnValue = 0.0;
	private int numColumns;
	private String noDataMessage = "";
	//private Color[] colours = { Color.black, Color.blue, Color.cyan, Color.darkGray, Color.green, Color.magenta,Color.gray,Color.orange, Color.pink, Color.red, Color.yellow};
	private Color[] colours = { new Color(28,203,254),
            new Color(33,126,160), 
            new Color(27,64,83),
            new Color(95,73,27),
            new Color(172,133,32),
            new Color(254,199,66),
            new Color(34,26,99),
            new Color(205,29,99),
            new Color(140,137,135)};
//	private static Logger logger = Logger.getLogger( CourseManager.class );

	
	public void init(int numColumns, List<String> columnLabels, String noDataMessage, List<Double> columnValues, Double maxColumnValue,List<Integer> periods)
	{
		
		this.numColumns = numColumns;
		this.columnLabels = columnLabels;
		this.noDataMessage = noDataMessage;
		this.columnValues = columnValues;
		this.maxColumnValue = maxColumnValue;
		this.periods = new boolean[numColumns];
		for(int i = 0; i<numColumns; i++)
			this.periods[i] = false;
	
		for(Integer i : periods)
			this.periods[i] = true;
	}
	public BufferedImage getImage()
	{
		BufferedImage image = new BufferedImage(550, 300, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2 = image.createGraphics();
		g2.setBackground(Color.WHITE);
		createImage(g2);
		return image;
	}

	public void createImage(Graphics g)
   {
	  int topMargin = 25;
	g.setColor(Color.WHITE);
	  g.fillRect(0,0,550,300);
		
      g.setColor(Color.BLACK);
    	Font titleFont = new Font("Arial", Font.BOLD,  25);
		g.setFont(titleFont);
		g.drawString("Assessment Method Categories",25,25);
      
      NumberFormat formatter = NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(1);
		
		Font labelFont = new Font("Arial", Font.BOLD,  14);
		Font percentageFont = new Font("Arial", Font.PLAIN,  12);
		g.setFont(labelFont);
     
      if(maxColumnValue < 1.0)
      {
      	text = noDataMessage;
      }
      else
      {
	      
	      try
	      {
		      int maxValue = ((maxColumnValue.intValue() + 19) / 20) * 20;
		      int numLabels = 5;
		      double spaceBetweenLabels = (height - 40 - topMargin)/ (numLabels);
		      double barWidth = (width-40)/(0.0 + numColumns);
		      int bottomLine = height-20;
		      int leftLine = 30;
		      
		      int percentLevel = 0;
		      int labelCount = 0;
		      while (percentLevel <= maxValue)
		      {
		      	 g.drawString(""+percentLevel, 0, (int)(height - 15 - (labelCount++ * spaceBetweenLabels)));
		      	 percentLevel += maxValue/numLabels;
		      }
		      g.drawString("%", 0, 10);
		  
		   //   g.drawString("Start of term", 10, height - 8);
		   //   g.drawString("End of term", width -50, height - 8);
		      g.setFont(percentageFont);
		      char letter = 'a';
		      for(int i = 0; i< numColumns; i++)
		      {
		      	g.setColor(colours[i]);
		      	int barHeight = (int) ((columnValues.get(i)/maxValue) * (height - 40 - topMargin));
		      	if(barHeight==0)
		      		barHeight++;
		      	//show the rectangle (bar)
		      	g.fillRect((int)(leftLine + i * barWidth), bottomLine -barHeight, (int)barWidth, barHeight);
		      	
		      	//show the % value above the bar
		      	g.setColor(Color.BLACK);
		      	g.drawString(formatter.format(columnValues.get(i))+" %", (int)(leftLine + 2 + i * barWidth), bottomLine -barHeight - 5);
		      	g.drawString(letter+")", (int)(leftLine + 10 + i * barWidth), bottomLine + 15);
		      	letter++;
		      }
		      g.setFont(labelFont);
		      letter='a';
		      int labelY = 20 + topMargin;
		      for(int i = 0; i < columnLabels.size();i++)
		      {
		      	g.setColor(colours[i]);
		      	String text = letter++ + ") " + columnLabels.get(i);	
		    	List<String> chunks = getWrappedText(text);
		    	for(String c : chunks)
		    	{
		    		g.drawString(c , width , labelY);
		    	    labelY += 20;	
		    	}
		      }
		      
	      }
	      catch(Exception e)
	      {
	      	StackTraceElement[] stack = e.getStackTrace();
	      	for(int i = 0; i< 5; i++)
	      		text += stack[i].toString()+"\n";
	      	
	      	text += /*"An Error occurred displaying data: "+*/e.toString();
	      }
      }
	   if(text.length() > 0)
	   {
		   g.setFont(labelFont);
		   g.drawString(text, 0, height/2);
	   }
	   g.dispose();
    }

	private List<String> getWrappedText(String s)
	{
		int maxLength = 40;
		
		List<String> r = new ArrayList<String>();
		while(s.length() > 0)
		{
			if (s.length() <= maxLength)
            {
				r.add(s);
                s="";
            }
            else
            {
            	int spaceLoc = findSpaceLoc(s, maxLength);
        		r.add(s.substring(0, spaceLoc));
                s = s.substring(spaceLoc);
            }
       	}
		return r;
	}
	
	private int findSpaceLoc(String s, int maxLength)
	{
		String temp = s.substring(0,Math.min(s.length(), maxLength));
		int spaceLoc  = temp.lastIndexOf(" ");
		if(spaceLoc > 0)
			return spaceLoc;
		return Math.min(s.length(), maxLength);
	}


}
