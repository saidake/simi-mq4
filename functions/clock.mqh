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
   //Alert("hLinesLength ",hLinesLength);
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
      if(Symbol()!=trendLineCore.symbol)continue; // only draw lines for the specific variety.
      
      int currentPeriod=trendLine.timePeriod==0?PERIOD_D1:trendLine.timePeriod;
      int barNumbers=Bars(Symbol(), currentPeriod, trendLine.startTime, trendLine.endTime); // bars number from startTime to endTime.
      if(barNumbers==0)ThrowError("trend line bar numbers error: "+barNumbers);
      //Alert("PERIOD_D1 ",PERIOD_D1);
      int barHours=24-TimeHour(trendLine.startTime)+TimeHour(trendLine.endTime)
      int barHours=24-TimeMinute(trendLine.startTime)+TimeMinute(trendLine.endTime)
      Alert("barHours",barHours);
      Alert("TimeHour",TimeHour(trendLine.endTime));
      
      int barTimeInterval=currentPeriod*barNumbers;
      double barTimeIntervalDouble=(double)barTimeInterval;
      
      double priceDiff=trendLine.endPrice-trendLine.startPrice;

      int currentBarNumbers=Bars(Symbol(), currentPeriod, trendLine.endTime, TimeCurrent());
      double intervalSlope = priceDiff/barTimeIntervalDouble;
      //double currentPriceDiff = currentBarNumbers*intervalSlope; 
      
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