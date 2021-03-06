//+------------------------------------------------------------------+
//|                                  2019_01_21-NewProbabilistic.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|functions                                   
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+






int Ticket;
int CloseOrder;
string OpenTicket = "FALSE";
string OrderDirection = "NULL";
extern double LotSize = .01;
string SMACrossOrder = "NULL";
int Prev_bars = 0;
double OrderPrice;
extern int SMAPeriod = 5;


void OnTick()
  {
//---
   double PrevSMA = iMA(Symbol(),1440,SMAPeriod,0,MODE_SMA,PRICE_CLOSE,2);
   double SMA = iMA(Symbol(),1440,SMAPeriod,0,MODE_SMA,PRICE_CLOSE,1);
   double SMA_2 = iMA(Symbol(),1440,2,0,MODE_SMA,PRICE_CLOSE,1);
   
   double NormalizedSlope = (MathAbs(SMA - PrevSMA)/SMA) * 100; 
   
   int New_bars = iBars(Symbol(),1440);   
      
   if(OpenTicket == "FALSE"){
   //BUY
      if(NormalizedSlope > 0.05){
         if( (SMA- PrevSMA) > 0){
            Ticket = OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,NULL,NULL,NULL,NULL,NULL,NULL);
            OpenTicket = "TRUE";      
            OrderDirection = "BUY"; 
            OrderPrice = Ask;
         }
      }

      
   //SELL
      if(NormalizedSlope > 0.1){
         if( (SMA- PrevSMA) < 0){
            Ticket = OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,NULL,NULL,NULL,NULL,NULL,NULL);
            OpenTicket = "TRUE";      
            OrderDirection = "SELL"; 
            OrderPrice = Bid;
         }      
      
      }
   }
   
   if(OpenTicket == "TRUE"){
      //CloseBUY
      if(OrderDirection == "BUY"){
         if((New_bars > Prev_bars) && (Bid > OrderPrice)){
            if( (SMA_2 - SMA) < 0){  //(SMA - PrevSMA) < 0 
               CloseOrder = OrderClose(Ticket,LotSize,Bid,3,NULL);
               OpenTicket = "FALSE"; 
               SMACrossOrder = "NULL";
            }
         }
         if( (SMA - PrevSMA) < 0 ){
               CloseOrder = OrderClose(Ticket,LotSize,Bid,3,NULL);
               OpenTicket = "FALSE"; 
               SMACrossOrder = "NULL";         
          }         
      }
      
      //CloseSELL
      if(OrderDirection == "SELL"){
         if((New_bars > Prev_bars) && (Ask < OrderPrice)){
            if( (SMA_2 - SMA) > 0 ){   //if( (SMA - PrevSMA) > 0 )
               CloseOrder = OrderClose(Ticket,LotSize,Ask,3,NULL);
               OpenTicket = "FALSE"; 
               SMACrossOrder = "NULL";
            }
         }
         if( (SMA - PrevSMA) > 0 ){
               CloseOrder = OrderClose(Ticket,LotSize,Ask,3,NULL);
               OpenTicket = "FALSE"; 
               SMACrossOrder = "NULL";         
          }
          
         }
         
   
   
   }
     
      Prev_bars = iBars(Symbol(),1440);
      Comment(SMA, "\n", PrevSMA,
               "\n", NormalizedSlope );
  }
//+------------------------------------------------------------------+
