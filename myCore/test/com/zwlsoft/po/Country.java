package com.zwlsoft.po;

import com.zwl.core.po.Entity;

/**
 * Description: Country
 * Author: liuzh
 * Update: liuzh(2014-06-06 13:38)
 */
public class Country implements Entity {
    private int id;
    private String countryname;
    private String countrycode;
    
    public Country()
    {
//        System.out.println("能调吗？");
//        setAllMethodList();
//        System.out.println("调完");
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCountryname() {
        return countryname;
    }

    public void setCountryname(String countryname) {
        this.countryname = countryname;
    }

    public String getCountrycode() {
        return countrycode;
    }

    public void setCountrycode(String countrycode) {
        this.countrycode = countrycode;
    }
}
