//+------------------------------------------------------------------+
//|                                    2018_12_20-MQL4BootCamp-8.mq4 |
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
void OnTick()
  {
   Comment("Hello World"); //f1 opens up help
   //Prints 'Hello World' in the upper left corner.
   {Comment("The current Ask price is", Ask);}
   //Ask tells us the Ask price. Bid tells us the bid.
   {Comment("The current Ask price is", Ask, "And the bid: ", Bid);}
   
   //OPEN A BUY ORDER
     if (Close[1]>Close[2])
     {
      if(OrdersTotal() < 1)
       {
         int buyticket = OrderSend(Symbol(),OP_BUY,0.1,Ask,3,0,(Ask+.25),NULL,0,0,Green);
       }  
     }  
     Comment("Account Balance: ", AccountBalance());
     
    }
//+------------------------------------------------------------------+
