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
}
