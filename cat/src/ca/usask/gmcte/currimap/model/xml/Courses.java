package ca.usask.gmcte.currimap.model.xml;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author abv641
 */
@XmlRootElement(name = "courses")
public class Courses {
    private List<Course> courses;

    public Courses() {
        courses = new ArrayList<Course>();
    }

    public Courses(List<Course> courses) {
        this.courses = courses;
    }

    @XmlElement(name = "course")
    public List<Course> getCourses() {
        return courses;
    }
    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }
   
}
