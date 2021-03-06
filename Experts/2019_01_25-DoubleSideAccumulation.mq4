//+------------------------------------------------------------------+
//|                            2019_01_25-DoubleSideAccumulation.mq4 |
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

string Bar1Color;
int LastTradeBars;
int Ticket;
double LotSize = 0.01;

int TicketOrderDirection;
double TicketClosePrice;

int MaxOpenOrders = 30;

int CloseTicket;

void OnTick()
  {
   if (iOpen(Symbol(),10080,1) < iClose(Symbol(),10080,1)){ Bar1Color = "GREEN" ; }
   if (iOpen(Symbol(),10080,1) > iClose(Symbol(),10080,1)){ Bar1Color = "RED" ; }
   
   if(   (Bar1Color == "GREEN") && (iBars(Symbol(),10080) > LastTradeBars) && (OrdersTotal() < MaxOpenOrders )  ){
      Ticket = OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,NULL,NULL,NULL,NULL,NULL,NULL) ;
      LastTradeBars = iBars(Symbol(),10080);
   }
   
   if(   (Bar1Color == "RED") && (iBars(Symbol(),10080) > LastTradeBars) && (OrdersTotal() < MaxOpenOrders ) ) {
      Ticket = OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,NULL,NULL,NULL,NULL,NULL,NULL);
      LastTradeBars = iBars(Symbol(),10080);
   }
   
   
   
   if (  (OrdersTotal() == MaxOpenOrders) && (iBars(Symbol(),10080) > LastTradeBars) ) {
        
     int total = OrdersTotal();
     for(int i=total-1;i>=0;i--)
     {
       int SelectedOrder = OrderSelect(i, SELECT_BY_POS);
       int type   = OrderType();
   
       bool result = false;
       
       switch(type)
       {
         //Close opened long positions
         case OP_BUY       : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
                             break;
         
         //Close opened short positions
         case OP_SELL      : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
                             break;
   
         //Close pending orders
         case OP_BUYLIMIT  :
         case OP_BUYSTOP   :
         case OP_SELLLIMIT :
         case OP_SELLSTOP  : result = OrderDelete( OrderTicket() );
       }
       
       if(result == false)
       {
         Alert("Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
         Sleep(3000);
       }  
     }
   }
   
   //Comment(AccountBalance(), "\n", AccountEquity());
   Comment(OrdersTotal());
   //Si hay un nuevo high  con respecto a tu orden de buy mas alta , vendes, y viceversa...
   //Pero cuando hay trend esto backfirea...Buno, solo acumularías la orden del otro tipo y repeat?
      
  }
//+------------------------------------------------------------------+
