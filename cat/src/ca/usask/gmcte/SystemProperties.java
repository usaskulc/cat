package ca.usask.gmcte;

import java.util.ResourceBundle;

public class SystemProperties 
{

	private ResourceBundle resourceBundle;
	
	public SystemProperties()
	{
		resourceBundle = ResourceBundle.getBundle("matterhorn_rest");
	}
	public String getProperty(String name)
	{
		return resourceBundle.getString(name);
	}
}
