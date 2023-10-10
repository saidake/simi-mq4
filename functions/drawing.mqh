#ifndef definition_drawing
#define definition_drawing
#include "../definitions/constants.mqh"


void AutoCreateHlines(){
   int hLinesLength=sizeof(hLines)/sizeof(hLines[0]);
   for(int i=0; i< hLinesLength; i++){
      HLine hLine= hLines[i];
      string lineName=hLine.name;
      ObjectCreate(ChartID(), lineName, OBJ_HLINE, 0,    TimeCurrent(), hLine.price, 0,0);  
      ObjectSet(lineName, OBJPROP_RAY, 0);
      ObjectSet(lineName, OBJPROP_COLOR, hLine.level);
      ObjectSet(lineName, OBJPROP_STYLE, hLine.style);
   }
}

void AutoCreateTrendlines(){
   int trendLinesLength=sizeof(trendLines)/sizeof(trendLines[0]);
   for(int i=0; i< trendLinesLength; i++){
      TrendLine trendLine= trendLines[i];
      string lineName=trendLine.name;
      datetime startTime=StrToTime(trendLine.startTime);
      datetime endTime=StrToTime(trendLine.endTime);
      
      int barsNumber=Bars(Symbol(),Period(),startTime,endTime);
      int barsTime=Period()*barsNumber;
      double barsTimeDouble=(double)(Period()*barsNumber);
      double priceDiff=trendLine.endPrice-trendLine.startPrice;
      
      int currentBarsNumber=Bars(Symbol(),Period(),endTime,TimeCurrent());
      
      Print(
         "lineName: ",lineName,", ",
         "barsNumber: ",barsNumber,", ",
         "time: ",barsTime,"min/",DoubleToStr(barsTimeDouble/60,2),"h/",DoubleToStr(barsTimeDouble/1440,2),"d, "
         "priceDiff: ",DoubleToStr(priceDiff*10000,1)
         );
      double barsSlope = priceDiff/barsNumber;
      double currentPriceDiff = currentBarsNumber*barsSlope;
      
      ObjectCreate(ChartID(), lineName, OBJ_TREND, 0, 
            startTime, trendLine.startPrice, TimeCurrent(),trendLine.endPrice+currentPriceDiff
         );
      ObjectSet(lineName, OBJPROP_RAY, 0);
      ObjectSet(lineName, OBJPROP_COLOR, trendLine.level);
      ObjectSet(lineName, OBJPROP_STYLE, trendLine.style);
   }
}

#endif

