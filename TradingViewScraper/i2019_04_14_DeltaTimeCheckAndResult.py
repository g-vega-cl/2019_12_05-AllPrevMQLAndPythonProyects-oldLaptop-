# -*- coding: utf-8 -*-
"""
Created on Sun Apr 14 16:41:55 2019

@author: gvega
"""


def CheckTimeStatus(DBName,CurrentSymbol):
    import pandas as pd
    import datetime
    
    try:
        Database = pd.read_csv(DBName)
    except:
        print('No-Db-Found')
        pass
    
    
    for i in range(0, len(Database)):
        try:
            Database['Date'][i] = datetime.datetime.strptime(Database['Date'][i], '%d/%m/%Y %H:%M')
        except:
            try:
                Database['Date'][i] = datetime.datetime.strptime(Database['Date'][i], '%Y/%m/%d %H:%M:%S')
            except:
                Database['Date'][i] = datetime.datetime.strptime(Database['Date'][i], '%Y-%m-%d %H:%M:%S')   
    
    def TestDelta(TimePeriod, TimePeriodClosingPrice):
        if(TimePeriod == 'Hour1PeriodStatus'):
            RequiredDelta = datetime.timedelta(0,3600)        
        elif(TimePeriod == 'Hour4PeriodStatus'):
            RequiredDelta = datetime.timedelta(0,14400)
        elif(TimePeriod == 'DayPeriodStatus'):
            RequiredDelta = datetime.timedelta(1,0)
        elif(TimePeriod == 'WeekPeriodStatus'):
            RequiredDelta = datetime.timedelta(7,0)
        elif(TimePeriod == 'MonthPeriodStatus'):
            RequiredDelta = datetime.timedelta(30,0)
            
        for i in range(0,len(Database)):
            if( Database[TimePeriod][i] == 'PENDING' and (Database['Symbol'][i] == CurrentSymbol ) ):
                Delta = Database['Date'][len(Database)-1] - Database['Date'][i]
                if(Delta > RequiredDelta): #Timedelta
                    Database[TimePeriod][i] = "CLOSED"
                    Database[TimePeriodClosingPrice][i] = Database['Price'][len(Database)-1]    
    
    TestDelta('Hour1PeriodStatus','Hour1ClosingPrice')
    TestDelta('Hour4PeriodStatus','Hour4ClosingPrice')
    TestDelta('DayPeriodStatus','DayClosingPrice')
    TestDelta('WeekPeriodStatus','WeekClosingPrice')
    TestDelta('MonthPeriodStatus','MonthClosingPrice')                  
    
    Database.to_csv(DBName, index = False)