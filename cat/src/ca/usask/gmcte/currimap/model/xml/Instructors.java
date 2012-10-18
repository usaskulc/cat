package ca.usask.gmcte.currimap.model.xml;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author abv641
 */
@XmlRootElement(name = "instructors")
public class Instructors {
    private List<Instructor> instructors;

    public Instructors() {
   	 instructors = new ArrayList<Instructor>();
    }

    public Instructors(List<Instructor> instructors) {
        this.instructors = instructors;
    }

    @XmlElement(name = "instructor")
    public List<Instructor> getInstructors() {
        return instructors;
    }
    public void setInstructors(List<Instructor> instructors) {
        this.instructors = instructors;
    }
   
}
