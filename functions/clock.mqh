#ifndef functions_clock
#define functions_clock
#include "../definitions/constants.mqh"

void ClearPrevTradingArrows(string & arrowNames[]){
   int arrowNamesLength=sizeof(arrowNames)/sizeof(arrowNames[0]);
   for(int i=0; i< arrowNamesLength; i++){
      ObjectDelete(ChartID(),arrowNames[i]);
   }
}


void CalculateTradingArrows(string & arrowNames[]){
   int hLinesLength=sizeof(hLines)/sizeof(hLines[0]);
   for(int i=0; i< hLinesLength; i++){
      HLine hLine= hLines[i];
      LineCore hLineCore=hLine.core;
      CreateMarkArrowTrading(hLineCore.name + MARK_ARROW_TRADING_BASE_SUFFIX, TimeCurrent(), hLine.price, MARK_ARROW_TRADING_BASE_COLOR);
      CreateMarkArrowTrading(hLineCore.name + MARK_ARROW_TRADING_ENTRY_SUFFIX, TimeCurrent(), 
         hLine.price, getMarkArrowEntryColor(hLineCore.action));
      CreateMarkArrowTrading(hLineCore.name + MARK_ARROW_TRADING_EXIT_SUFFIX, TimeCurrent(), hLine.price, MARK_ARROW_TRADING_EXIT_COLOR);

   }
   int trendLinesLength=sizeof(trendLines)/sizeof(trendLines[0]);
   for(int i=0; i< trendLinesLength; i++){
      TrendLine trendLine= trendLines[i];
      LineCore trendLineCore=trendLine.core;
   }
//      datetime startTime=StrToTime(trendLine.startTime);
//      datetime endTime=StrToTime(trendLine.endTime);
//
//      int barsNumber=Bars(Symbol(), trendLine.timePeriod, startTime, endTime); // bars number from startTime to endTime.
//      int barsTime=trendLine.timePeriod*barsNumber;
//      double barsTimeDouble=(double)barsTime;
//      double priceDiff=trendLine.endPrice-trendLine.startPrice;
//
//      int currentBarsNumber=Bars(Symbol(), trendLine.timePeriod, endTime, TimeCurrent());
//
//      Print(
//         "lineName: ",lineName,", ",
//         "barsNumber",barsNumber,", ",
//         "time: ",barsTime,"min/",DoubleToStr(barsTimeDouble/60,2),"h/",DoubleToStr(barsTimeDouble/1440,2),"d, "
//         "priceDiff: ",DoubleToStr(priceDiff*10000,1)
//         );
//      double barsSlope = priceDiff/barsNumber;
//      double currentPriceDiff = currentBarsNumber*barsSlope;   
}


#endif