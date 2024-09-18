/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class shift {
    private int shiftid;
    private String dayofweek;
    private String shiftname;

    public shift() {
    }

    public shift(int shiftid, String dayofweek, String shiftname) {
        this.shiftid = shiftid;
        this.dayofweek = dayofweek;
        this.shiftname = shiftname;
    }

    public int getShiftid() {
        return shiftid;
    }

    public void setShiftid(int shiftid) {
        this.shiftid = shiftid;
    }

    public String getDayofweek() {
        return dayofweek;
    }

    public void setDayofweek(String dayofweek) {
        this.dayofweek = dayofweek;
    }

    public String getShiftname() {
        return shiftname;
    }

    public void setShiftname(String shiftname) {
        this.shiftname = shiftname;
    }

    @Override
    public String toString() {
        return dayofweek + "/" + shiftname ;
    }
    
    
}
