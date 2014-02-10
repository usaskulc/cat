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
