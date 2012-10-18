package ca.usask.gmcte.currimap.model.xml;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author abv641
 */
@XmlRootElement(name = "departments")
public class Departments {
    private List<Department> departments;

    public Departments() {
   	 departments = new ArrayList<Department>();
    }

    public Departments(List<Department> departments) {
        this.departments = departments;
    }

    @XmlElement(name = "department")
    public List<Department> getDepartments() {
        return departments;
    }
    public void setDepartments(List<Department> departments) {
        this.departments = departments;
    }
   
}
