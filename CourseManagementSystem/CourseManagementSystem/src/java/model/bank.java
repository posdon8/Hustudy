/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class bank {
    private int bankid;
    private String accountnumber;
    private String bankname;
    private Date expirydate;
    private users userid;

    public bank() {
    }

    public bank(int bankid, String accountnumber, String bankname, Date expirydate, users userid) {
        this.bankid = bankid;
        this.accountnumber = accountnumber;
        this.bankname = bankname;
        this.expirydate = expirydate;
        this.userid = userid;
    }

    public int getBankid() {
        return bankid;
    }

    public void setBankid(int bankid) {
        this.bankid = bankid;
    }

    public String getAccountnumber() {
        return accountnumber;
    }

    public void setAccountnumber(String accountnumber) {
        this.accountnumber = accountnumber;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public users getUserid() {
        return userid;
    }

    public void setUserid(users userid) {
        this.userid = userid;
    }

    
}
