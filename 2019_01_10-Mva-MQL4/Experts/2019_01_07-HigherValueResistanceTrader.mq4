//+------------------------------------------------------------------+
//|                       2019_01_07-HigherValueResistanceTrader.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

double ArraySum;
double ArrayHigh;
int BarTimeFrame = 1440;
double specificHighValue;
int HighTimeframe = 20;
extern double LotSize = 0.01;
extern double ProfitCents = 0.03;
extern double LossCents = -0.1;
double SoldPrice;
int sellticket;


void OnTick()
  {
  
   double FirstHigh = 0;
   double SecondHigh = 0;
   double ThirdHigh = 0;
   double FourthHigh = 0;
   /*
     for(int n = 0; n < SizeOfArray; n++){
         ArrayHigh = iHigh(NULL,NULL,n);
         
         ArraySum = ArraySum + ArrayHigh;  
      }
      
      double ArrayAverage = ArraySum / SizeOfArray;      
      ArraySum = 0;
      */
      
      //AAAAAAAAAAAAAAAAAAAAA USA iHIGHEST!!!!
      double NumberOfTicks = iBars(NULL,BarTimeFrame);

      for(int HighCount = 0; HighCount < HighTimeframe; HighCount++){
                
         specificHighValue = iHigh(NULL,BarTimeFrame, HighCount); 
         
         if(specificHighValue > FirstHigh){
            FirstHigh = specificHighValue;
         }
 
      }
      
      for(int HighCount = 0 + (HighTimeframe*1); HighCount < (HighTimeframe*2); HighCount++){
                
         specificHighValue = iHigh(NULL,BarTimeFrame, HighCount); 
         
         if(specificHighValue > SecondHigh){
            SecondHigh = specificHighValue;
         }
 
      }
      /////////////Third
      for(int HighCount = 0 + (HighTimeframe*2); HighCount < (HighTimeframe*3); HighCount++){
                
         specificHighValue = iHigh(NULL,BarTimeFrame, HighCount); 
         
         if(specificHighValue > ThirdHigh){
            ThirdHigh = specificHighValue;
         }
 
      }
      /////////////fourth
      for(int HighCount = 0 + (HighTimeframe*3); HighCount < (HighTimeframe*4); HighCount++){
                
         specificHighValue = iHigh(NULL,BarTimeFrame, HighCount); 
         
         if(specificHighValue > FourthHigh){
            FourthHigh = specificHighValue;
         }
 
      }
      
      //////AAAAAAAAAAAAA USA iHighest !!!!!!
   
      double ClosestResistanceValue;
      
      double DistanceFirst = MathAbs(FirstHigh - Bid);
      double DistanceSecond = MathAbs(SecondHigh - Bid);
      double DistanceThird = MathAbs(ThirdHigh - Bid);
      double DistanceFourth = MathAbs(FourthHigh - Bid); 
      
      if(DistanceFirst < DistanceSecond && DistanceFirst < DistanceThird && DistanceFirst < DistanceFourth){
         ClosestResistanceValue = FirstHigh;
      }
      else if(DistanceSecond < DistanceThird && DistanceSecond < DistanceFourth){
         ClosestResistanceValue = SecondHigh;
      }
      else if(DistanceThird < DistanceFourth){
         ClosestResistanceValue = ThirdHigh;
      }
      else ClosestResistanceValue = FourthHigh;
    
       if(OrdersTotal() < 1){
          if(Bid > ClosestResistanceValue){
            if(iClose(NULL,BarTimeFrame,1) < ClosestResistanceValue){
               sellticket = OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,0,NULL,NULL,0,0,Red);
               SoldPrice = Bid;
            }
          }
       }
      
      bool OrderCResult;
      if (OrdersTotal() > 0) {
         if((SoldPrice - Ask) > ProfitCents){ 
            OrderCResult = OrderClose(sellticket,LotSize,Ask,3,clrGreen); 
         }
         if((SoldPrice - Ask) < LossCents){ 
            OrderCResult = OrderClose(sellticket,LotSize,Ask,3,clrYellowGreen); 
         }
      }
      
      
       Comment("NumberOfTicks: ",NumberOfTicks,"\n", "SHV: ", specificHighValue, "\n",
      "FirstHigh: ", FirstHigh, "\n","Second: ", SecondHigh,
       "\n","Third: ", ThirdHigh, "\n", "Fourth: ", FourthHigh, "\n",
       "Closest resistance value: ", ClosestResistanceValue, "\n",
       "Sold Price: ", SoldPrice, " Bid: ", Bid, "\n", "Net Cents: ", (SoldPrice - Ask));
  }
//+------------------------------------------------------------------+
