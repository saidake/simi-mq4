#ifndef functions_drawing
#define functions_drawing
#include "../definitions/constants.mqh"

void DrawHLines(){
   int hLinesLength=sizeof(hLines)/sizeof(hLines[0]);
   for(int i=0; i< hLinesLength; i++){
      HLine hLine= hLines[i];
      LineCore hLineCore=hLine.core;
      if(Symbol()!=hLineCore.symbol)continue; // only draw lines for the specific variety.
      string lineName=hLineCore.name;
      CreateHLine(lineName, hLine.price, hLineCore.level.baseColor, hLineCore.level.baseStyle, hLineCore.level.baseHLineRayProp);
      CreateArrow(lineName+ARROW_SUFFIX,  hLine.markTime, hLine.price, true);
      //A. create entry peice line and exit price line.
      if(hLineCore.entryPriceDiff>0){
        double realEntryPriceDiff=GetRealPriceDiff(hLineCore,0);
        CreateHLine(StringConcatenate(lineName,ENTRY_LINE_SUFFIX), hLine.price+realEntryPriceDiff, 
           hLineCore.level.entryColor, hLineCore.level.entryStyle, hLineCore.level.entryHLineRayProp);
      }
      if(hLineCore.exitPriceDiff>0){
        double realExitPriceDiff=GetRealPriceDiff(hLineCore,1);
        CreateHLine(StringConcatenate(lineName,EXIT_LINE_SUFFIX), hLine.price+realExitPriceDiff, 
           hLineCore.level.exitColor, hLineCore.level.exitStyle, hLineCore.level.exitHLineRayProp);
      }
   }
}

void DrawTrendLines(){
   int trendLinesLength=sizeof(trendLines)/sizeof(trendLines[0]);
   for(int i=0; i< trendLinesLength; i++){
      TrendLine trendLine= trendLines[i];
      LineCore trendLineCore=trendLine.core;
      if(Symbol()!=trendLineCore.symbol)continue; // only draw lines for the specific variety.
      string lineName=trendLineCore.name;
      
      CreateTrendLine(lineName, trendLine.startTime, trendLine.startPrice, trendLine.endTime, trendLine.endPrice,
        trendLineCore.level.baseColor, trendLineCore.level.baseStyle, trendLineCore.level.baseTrendLineRayProp);
      //A. create entry peice line and exit price line.
      if(trendLineCore.entryPriceDiff>0){
        double realEntryPriceDiff=GetRealPriceDiff(trendLineCore,0);
        Print("realEntryPriceDiff: ",realEntryPriceDiff);
        CreateTrendLine(lineName+ENTRY_LINE_SUFFIX, trendLine.startTime, trendLine.startPrice+realEntryPriceDiff, 
            trendLine.endTime, trendLine.endPrice+realEntryPriceDiff,
            trendLineCore.level.entryColor, trendLineCore.level.entryStyle, trendLineCore.level.entryTrendLineRayProp);
      }
      if(trendLineCore.exitPriceDiff>0){
        double realExitPriceDiff=GetRealPriceDiff(trendLineCore,1);
        Print("realExitPriceDiff: ",realExitPriceDiff);
        Print("trendLine.startPrice: ",trendLine.startPrice);
        Print("trendLine.endPrice: ",trendLine.endPrice);
        CreateTrendLine(lineName+EXIT_LINE_SUFFIX, trendLine.startTime, trendLine.startPrice+realExitPriceDiff, 
            trendLine.endTime, trendLine.endPrice+realExitPriceDiff,
            trendLineCore.level.exitColor, trendLineCore.level.exitStyle, trendLineCore.level.exitTrendLineRayProp);
      }
   }
}

//========================================================================================== Data Util

/**
 * Obtains the difference between the base price and the edge price.
 *
 * @param   hLine the horizontal line
 * @param   type {@code 0} for entry price;
                 {@code 1} for exit price
 * @return  the price difference
 */
double GetRealPriceDiff(LineCore & lineCore, int type){
    switch(lineCore.action){
        case CROSS_ABOVE: return type==0?-lineCore.entryPriceDiff:lineCore.exitPriceDiff;
        case CROSS_BELOW: return type==0?lineCore.entryPriceDiff:-lineCore.exitPriceDiff;
        default: return 0;
    }
}

/*
 * Creates a horizontal line for the current chart.
 *
 * @param lineName the line name
 * @param price the display price of the horizontal line
 */
void CreateHLine(string lineName, double price, color lineColor, int lineStyle, int rayStyle){
    ObjectCreate(ChartID(), lineName, OBJ_HLINE, 0, TimeCurrent(), price, 0, 0);
    ObjectSet(lineName, rayStyle, true);
    ObjectSet(lineName, OBJPROP_COLOR, lineColor);
    ObjectSet(lineName, OBJPROP_STYLE, lineStyle);
}

/*
 * Creates a trend line for the current cahrt.
 *
 * @param lineName the line name
 * @param startTime the start time
 */
void CreateTrendLine(string lineName, datetime startTime, double startPrice, datetime endTime, double endPrice, 
                     color lineColor, int lineStyle, int rayStyle){
    ObjectCreate(ChartID(), lineName, OBJ_TREND, 0,
          startTime, startPrice, endTime, endPrice
       );
    ObjectSet(lineName, rayStyle, true);
    ObjectSet(lineName, OBJPROP_COLOR, lineColor);
    ObjectSet(lineName, OBJPROP_STYLE, lineStyle);
}

void CreateArrow(string lineName, datetime time, double price, bool bullish){
    ObjectCreate(lineName, OBJ_ARROW, 0, time,price);
    ObjectSet(lineName, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(lineName, OBJPROP_ARROWCODE, 234);
    ObjectSet(lineName, OBJPROP_COLOR, bullish? clrLime : clrRed);
}


#endif

