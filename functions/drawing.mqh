#ifndef functions_drawing
#define functions_drawing
#include "../definitions/constants.mqh"
#include "../functions/core.mqh"

void DrawHLines(){
   int hLinesLength=sizeof(hLines)/sizeof(hLines[0]);
   for(int i=0; i< hLinesLength; i++){
      HLine hLine= hLines[i];
      LineCore hLineCore=hLine.core;
      if(Symbol()!=hLineCore.symbol)continue; // only draw lines for the specific variety.
      string lineName=hLineCore.name;
      CreateHLine(lineName, hLine.price, hLine.markTime,
         hLineCore.level.baseColor, hLineCore.level.baseStyle, hLineCore.level.baseHLineRayProp);
      //A. create entry peice line and exit price line.
      if(hLineCore.entryPriceDiff>0){
        double realEntryPriceDiff=GetRealPriceDiff(hLineCore,0);
        CreateHLine(StringConcatenate(lineName,ENTRY_LINE_SUFFIX), hLine.price+realEntryPriceDiff,  hLine.markTime,
           hLineCore.level.entryColor, hLineCore.level.entryStyle, hLineCore.level.entryHLineRayProp);
      }
      if(hLineCore.exitPriceDiff>0){
        double realExitPriceDiff=GetRealPriceDiff(hLineCore,1);
        CreateHLine(StringConcatenate(lineName,EXIT_LINE_SUFFIX), hLine.price+realExitPriceDiff,  hLine.markTime,
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
        case ACTION_SELL: return type==0?-lineCore.entryPriceDiff:lineCore.exitPriceDiff;
        case ACTION_BUY: return type==0?lineCore.entryPriceDiff:-lineCore.exitPriceDiff;
        default: return 0;
    }
}

/*
 * Creates a horizontal line for the current chart.
 *
 * @param lineName the line name
 * @param price the display price of the horizontal line
 */
void CreateHLine(string lineName, double price, datetime markTime, color lineColor, int lineStyle, int rayStyle){
    //ObjectCreate(ChartID(), lineName, OBJ_HLINE, 0, TimeCurrent(), price, 0, 0);
    CreateMarkArrow(lineName+MARK_ARROW_HLINE_SUFFIX, markTime, price);
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
    CreateMarkArrow(lineName+MARK_ARROW_TREND_START_SUFFIX, startTime,  startPrice);
    CreateMarkArrow(lineName+MARK_ARROW_TREND_END_SUFFIX,   endTime,    endPrice);
    ObjectSet(lineName, rayStyle, true);
    ObjectSet(lineName, OBJPROP_COLOR, lineColor);
    ObjectSet(lineName, OBJPROP_STYLE, lineStyle);
}


void CreateMarkArrow(string lineName, datetime markTime, double price){
    int bars=Bars(Symbol(), Period(), markTime, TimeCurrent());
    double highPrice=iHigh(Symbol(),Period(),bars);
    double lowPrice=iLow(Symbol(),Period(),bars);
    bool isAbove=MathAbs(highPrice-price)< MathAbs(lowPrice-price);
    double realPriceShift=isAbove? MARK_ARROW_OFFSET: -MARK_ARROW_OFFSET;
    
    ObjectCreate(ChartID(), lineName, OBJ_TREND, 0, markTime,  price, markTime, price + realPriceShift);
    ObjectSet(lineName, OBJPROP_RAY, false);
    ObjectSet(lineName, OBJPROP_COLOR, MARK_ARROW_COLOR);
    ObjectSet(lineName, OBJPROP_STYLE, MARK_ARROW_STYLE);
    ObjectSet(lineName, OBJPROP_WIDTH, MARK_ARROW_WIDTH);
}

void CreateMarkArrowTrading(string lineName, datetime markTime, double price, color arrowColor){
    ObjectCreate(ChartID(), lineName, OBJ_TREND, 0, markTime,  price, markTime+MARK_ARROW_TRADING_DATETIME_OFFSET, price);
    ObjectSet(lineName, OBJPROP_RAY, false);
    ObjectSet(lineName, OBJPROP_COLOR, arrowColor);
    ObjectSet(lineName, OBJPROP_STYLE, MARK_ARROW_TRADING_STYLE);
    ObjectSet(lineName, OBJPROP_WIDTH, MARK_ARROW_TRADING_WIDTH);
}


color getMarkArrowEntryColor(int action){
   switch(action){
      case ACTION_SELL: return MARK_ARROW_TRADING_ENTRY_SELL_COLOR; 
      case ACTION_BUY: return MARK_ARROW_TRADING_ENTRY_BUY_COLOR; 
      default: { 
         ThrowError("mark arrow entry color error! "+IntegerToString(action)); 
         return clrWhite;  
      }
   }
}


#endif

