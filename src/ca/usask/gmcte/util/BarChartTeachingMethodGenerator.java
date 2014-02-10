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
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.text.NumberFormat;
import java.util.List;

public class BarChartTeachingMethodGenerator
{
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	private String text = "";
	final int width = 350;
	final int height = 300;
	private List<String> yAxisLabels;
	private List<Integer> yAxisValues;
	private int maxYValue = 0;
	private double maxColumnValue = 0.0;
	//private Color[] colours = { Color.blue, Color.cyan, Color.green, Color.magenta,Color.gray,Color.orange, Color.pink, Color.red, Color.yellow};
	private Color[] colours = { new Color(28,203,254),
            new Color(33,126,160), 
            new Color(27,64,83),
            new Color(95,73,27),
            new Color(172,133,32),
            new Color(254,199,66),
            new Color(34,26,99),
            new Color(205,29,99),
            new Color(140,137,135)};
	private List<String> columnLabels;
	private List<Double> columnValues;
	private int numColumns;
	private String noDataMessage = "";
	
	public void init(int numColumns, 
					 List<String> columnLabels, 
					 String noDataMessage, 
					 List<Double> columnValues, 
					 Double maxColumnValue,
					 List<Integer> yAxisValues, 
					 List<String> yAxisLabels,
					 int maxYValue)
	{
		this.numColumns = numColumns;
		this.columnLabels = columnLabels;
		this.noDataMessage = noDataMessage;
		this.columnValues = columnValues;
		this.maxYValue = maxYValue;
		
		this.yAxisValues = yAxisValues;
		this.yAxisLabels = yAxisLabels;
		this.maxColumnValue = maxColumnValue;
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
    
      NumberFormat formatter = NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(1);
		Font titleFont = new Font("Arial", Font.BOLD,  25);
		g.setFont(titleFont);
		g.drawString("Instructional Methods",75,25);
		Font labelFont = new Font("Arial", Font.BOLD,  15);
		
		Font percentageFont = new Font("Arial", Font.PLAIN,  12);
		g.setFont(labelFont);
     
      if(maxColumnValue < 0.5)
      {
      	text = noDataMessage;
      }
      else
      {
	      
	      try
	      {
		      double spaceBetweenLabels = (height - 40-topMargin)/ (maxYValue);
		      
		     
		      int bottomLine = height-20;
		      
		      String longest = "";
		      for(int i = 0; i< yAxisLabels.size() ; i++)
		      {
		      	 if(longest.length() < yAxisLabels.get(i).length())
		      		 longest = yAxisLabels.get(i);
		      }
		      FontMetrics fontMetrics = g.getFontMetrics(labelFont);
		      int leftLine = fontMetrics.stringWidth(longest)+20;
		      for(int i = 0; i< yAxisLabels.size() ; i++)
		      {
		      	 g.drawString(yAxisLabels.get(i), leftLine - fontMetrics.stringWidth(yAxisLabels.get(i)), (int)(height - 15 - (yAxisValues.get(i) * spaceBetweenLabels)));
		      }
		      leftLine += 10;
		      double barWidth = (width-leftLine)/(0.0 + numColumns);
		      g.setFont(percentageFont);
		      char letter = 'a';
		      for(int i = 0; i< numColumns; i++)
		      {
		      	g.setColor(colours[i]);
		      	int barHeight = (int) ((columnValues.get(i)/maxYValue) * (height - 40 - topMargin));
		      	if(barHeight==0)
		      		barHeight++;
		      	//show the rectangle (bar)
		      	g.fillRect((int)(leftLine + i * barWidth), bottomLine - barHeight, (int)barWidth, barHeight);
		      	
		      	//show the % value above the bar
		      	g.setColor(Color.BLACK);
		      	g.drawString(formatter.format(columnValues.get(i)), (int)(leftLine + 10 + i * barWidth), bottomLine -barHeight - 5);
		      	g.drawString(letter+")", (int)(leftLine + 10 + i * barWidth), bottomLine + 15);
		      	letter++;
		      }
		      g.setFont(labelFont);
		      letter='a';
		      for(int i = 0; i < columnLabels.size();i++)
		      {
		      	g.setColor(colours[i]);
		      	g.drawString(letter++ +") "+columnLabels.get(i) ,width, topMargin + 20 + (i*20));	
		      }
	      }
	      catch(Exception e)
	      {
	      	StackTraceElement[] stack = e.getStackTrace();
	      	for(int i = 0; i< 5; i++)
	      		text += stack[i].toString()+"\n";
	      	
	      	text += "An Error occurred displaying data: "+e.toString();
	      }
      }
	   if(text.length() > 0)
      	g.drawString(text, 0, height/2);
  
	   g.dispose();
    }
	
}
