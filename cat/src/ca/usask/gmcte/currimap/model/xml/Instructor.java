package ca.usask.gmcte.currimap.model.xml;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author cfh928
 */
@XmlRootElement
public class Instructor {
    private String username;
    private String firstName;
    private String lastName;
    
     public Instructor() {
    	
    }
 
    public Instructor(String username) {
   	 this.username = username;
    }

    @XmlElement(name = "username")
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    @XmlElement(name = "firstname")
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	 @XmlElement(name = "lastname")
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
    
    
}
