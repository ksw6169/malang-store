package com.malangstore.webapp;

import org.apache.commons.dbcp2.BasicDataSource;

public class DBCP extends BasicDataSource {

    public DBCP() {
        super.setTestOnBorrow(true);
        super.setTestOnReturn(true);
        super.setTestWhileIdle(false);
        super.setTimeBetweenEvictionRunsMillis(180000);
        super.setNumTestsPerEvictionRun(1);
        super.setMinEvictableIdleTimeMillis(180000);
    }
}
