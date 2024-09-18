/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class schedules {
    private int schedulesid;
    private courses courseid;
    private shift shiftid;
    
    public schedules() {
    }

    public schedules(int schedulesid, courses courseid, shift shiftid) {
        this.schedulesid = schedulesid;
        this.courseid = courseid;
        this.shiftid = shiftid;
    }

    public int getSchedulesid() {
        return schedulesid;
    }

    public void setSchedulesid(int schedulesid) {
        this.schedulesid = schedulesid;
    }

    public courses getCourseid() {
        return courseid;
    }

    public void setCourseid(courses courseid) {
        this.courseid = courseid;
    }

    public shift getShiftid() {
        return shiftid;
    }

    public void setShiftid(shift shiftid) {
        this.shiftid = shiftid;
    }

    
    
    
}
