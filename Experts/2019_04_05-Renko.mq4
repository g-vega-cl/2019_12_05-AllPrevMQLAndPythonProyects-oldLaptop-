//+------------------------------------------------------------------+
//|                                             2019_04_05-Renko.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
double ClosePriceArray[1000];
double RenkoArrayClose[100];
int renkoCounter = 0;
int IsRenkoOpen = 0;
double CurrentRenkoOpen;
void OnTick()
  {  
  5
  
   double HighestCandle = iHigh(Symbol(),10080,iHighest(Symbol(),10080,MODE_HIGH,WHOLE_ARRAY,0));
   double LowestCandle = iLow(Symbol(),10080,iLowest(Symbol(),10080,MODE_HIGH,WHOLE_ARRAY,0));
   for(int i = 0;i < 1000;i++){
      ClosePriceArray[i] = iClose(Symbol(),240,i+1);
   }
     
   double ChartBoundary = HighestCandle - LowestCandle;
   double CandleHeightPercentage = ChartBoundary*0.01;
   
   for(i = 0;i < 100; i++){
      if(IsRenkoOpen == 0){
         CurrentRenkoOpen = ClosePriceArray[
    }
   }
    
   Comment(HighestCandle);
   
  }
//+------------------------------------------------------------------+
