package ca.usask.gmcte.currimap.model.xml;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author abv641
 */
@XmlRootElement
public class Department {
    private String name;
    private Courses courses;
    
    public Department() {
    }

    public Department(String name) {
        this.name = name;
    }

    @XmlElement(name = "name")
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    @XmlElement(name = "courses")
    public Courses getCourses() {
        return courses;
    }
    public void setCourses(Courses courses) {
        this.courses = courses;
    }
}
