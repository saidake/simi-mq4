#ifndef functions_clock
#define functions_clock
#include "../definitions/constants.mqh"

void UpdateActionList(){
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