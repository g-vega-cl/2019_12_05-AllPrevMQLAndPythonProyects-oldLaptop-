//+------------------------------------------------------------------+
//|                                2019_01_17-ProbabilisticTrade.mq4 |
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
//Una nota: hice un backtest en la que trailing pips no cambiaba, más bien era un stop loss. y en un solo backtest dio medio decente, eh.
//Checa que pasa si hay mucha volatilidad y cortas la trail, si hay poca la agrandas. TrailingPipModifier debe de ser cambiante dependiendo
   //De la volatilidad

/*

   Bollinger band: Si en la bollinger semanal esta fuera y luego entra, agrega probabilidad al lado que entra.
   MACD: Si la segunda barra del MACD histogram (dos anteriores) es mayor a la anterior, probabilidad a la direccion contraria. 
   Video de first candle:

*/

#include "2019_01_17-BollingerBandProbability.mq4"
#include "2019_01_18-MACDProbability.mq4"
#include "2019_01_19-TrailingPipCalculator.mq4"
double BuyOrSell = 0;
int Ticket;
int CloseOrder;
string OpenTicket = "FALSE";
string OrderDirection = "NULL";
extern double LotSize = .01;
double ClosePrice;
double TrailingPips = .01;
double HighestPrice;
double LowestPrice;
double BollingerModifier;
double MACDModifier;
double TrailingPipModifier = 1;
double RVGI;
double OrderPrice;
double CurrentDayCloseValue;
void OnTick()
  {
   
   CurrentDayCloseValue = iClose(Symbol(),1440,0);
   RVGI = iRVI(Symbol(),10080,10,0,0); //No sirve de nada creo. solo dejo el placeholder
   BuyOrSell = MathRand()%100;
   BollingerModifier = BollingerOdds();
   MACDModifier = MACDOdds();
   
   BuyOrSell = BuyOrSell + BollingerModifier + MACDModifier;
   
   if(OpenTicket == "FALSE"){
      
      if(BuyOrSell < 50){
         Ticket = OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,NULL,NULL,NULL,NULL,NULL,NULL);
         OpenTicket = "TRUE";      
         OrderDirection = "SELL"; 
         LowestPrice = Bid;
         ClosePrice = LowestPrice + (TrailingPips); 
         OrderPrice = Bid;
         
         
      }
      
      if(BuyOrSell > 50){
         Ticket = OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,NULL,NULL,NULL,NULL,NULL,NULL);    
         OpenTicket = "TRUE";    
         OrderDirection = "BUY";    
         HighestPrice = Ask;
         ClosePrice = HighestPrice - (TrailingPips);
         OrderPrice = Ask;
         
       }
   }
  
  TrailingPips = TrailPips();
  
  if(OpenTicket == "TRUE"){
       //Sell
       if(OrderDirection == "SELL"){
         if(ClosePrice > (LowestPrice + TrailingPips)){ ClosePrice = (LowestPrice + TrailingPips); }
         
         if(ClosePrice > OrderPrice){
            if(Ask < OrderPrice){   ClosePrice = OrderPrice; }
            }
         if(LowestPrice  > Ask){
            LowestPrice = Ask;
           // ClosePrice = LowestPrice + (TrailingPips);
         }
         if(CurrentDayCloseValue > ClosePrice){
            CloseOrder = OrderClose(Ticket,LotSize,Ask,3,NULL);
            OpenTicket = "FALSE";
         }
             
       } 
       //Buy
       if(OrderDirection == "BUY"){
         if(ClosePrice < (HighestPrice - TrailingPips)){   ClosePrice = (HighestPrice - TrailingPips); } 
         if(ClosePrice < OrderPrice){
            if(Bid > OrderPrice){   ClosePrice = OrderPrice; }
            }         
         if(HighestPrice < Bid){
            HighestPrice = Bid;
            //ClosePrice = HighestPrice - (TrailingPips);
         }
         if(CurrentDayCloseValue < ClosePrice){
            CloseOrder = OrderClose(Ticket,LotSize,Bid,3,NULL);
            OpenTicket = "FALSE";
         }
         
       }
  
  }
  
  
  
  Comment("Buy Or Sell value: ", BuyOrSell, "\n",
  "MACD Modifier value: ",  MACDModifier, "\n", 
  "Bollinger Modifier value: ", BollingerModifier, "\n",
  "ClosePrice: ", ClosePrice, "\n",
  "TrailingPips: ", TrailingPips);
   

  }
//+------------------------------------------------------------------+
