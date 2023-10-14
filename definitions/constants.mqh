#ifndef definition_constants
#define definition_constants
//========================================================================================== Arrow Style
#define MARK_ARROW_COLOR      clrAzure
#define MARK_ARROW_STYLE      STYLE_SOLID
#define MARK_ARROW_WIDTH      2
#define MARK_ARROW_OFFSET     0.0013

#define MARK_ARROW_TRADING_ENTRY_SELL_COLOR          clrRed
#define MARK_ARROW_TRADING_ENTRY_BUY_COLOR           clrLime
#define MARK_ARROW_TRADING_BASE_COLOR          clrYellow
#define MARK_ARROW_TRADING_EXIT_COLOR          clrSalmon


#define MARK_ARROW_TRADING_STYLE               STYLE_SOLID
#define MARK_ARROW_TRADING_WIDTH               2
#define MARK_ARROW_TRADING_DATETIME_OFFSET     300*60

//========================================================================================== Line Style
#define ENTRY_LINE_STYLE         clrGray, STYLE_SOLID, OBJPROP_RAY, OBJPROP_RAY_RIGHT
#define EXIT_LINE_STYLE          clrGray, STYLE_SOLID, OBJPROP_RAY, OBJPROP_RAY_RIGHT

#define BASE_STYLE               STYLE_SOLID, OBJPROP_RAY, OBJPROP_RAY_RIGHT
#define ENTRY_BASE_STYLE         STYLE_SOLID, OBJPROP_RAY, OBJPROP_RAY_RIGHT
#define EXIT_BASE_STYLE          STYLE_SOLID, OBJPROP_RAY, OBJPROP_RAY_RIGHT

#define LD1 {clrAqua,         BASE_STYLE, ENTRY_LINE_STYLE, EXIT_LINE_STYLE}
#define LW1 {clrYellow,       BASE_STYLE, ENTRY_LINE_STYLE, EXIT_LINE_STYLE}
#define LY1 {clrDarkViolet,   BASE_STYLE, ENTRY_LINE_STYLE, EXIT_LINE_STYLE}
#define LE1 {clrDarkViolet,   BASE_STYLE, ENTRY_LINE_STYLE, EXIT_LINE_STYLE}
//========================================================================================== Action
#define ACTION_SELL 300
#define ACTION_BUY 400
//========================================================================================== Suffix
#define MARK_ARROW_HLINE_SUFFIX "-arrow"
#define MARK_ARROW_TREND_START_SUFFIX "-arrow-start"
#define MARK_ARROW_TREND_END_SUFFIX "-arrow-end"
#define MARK_ARROW_TRADING_BASE_SUFFIX "-arrow-trading"
#define MARK_ARROW_TRADING_ENTRY_SUFFIX "-arrow-trading-entry"
#define MARK_ARROW_TRADING_EXIT_SUFFIX "-arrow-trading-exit"

#define ENTRY_LINE_SUFFIX "-entry"
#define EXIT_LINE_SUFFIX "-exit"
//========================================================================================== Object
struct LineLevel {
    color   baseColor;
    int     baseStyle;
    int     baseHLineRayProp;
    int     baseTrendLineRayProp;

    color   entryColor;
    int     entryStyle;
    int     entryHLineRayProp;
    int     entryTrendLineRayProp;

    color   exitColor;
    int     exitStyle;
    int     exitHLineRayProp;
    int     exitTrendLineRayProp;
};
struct LineCore {
   string symbol;
   string name;
   LineLevel level;
   int action;
   double entryPriceDiff;
   double exitPriceDiff;
   int guardTime; // minutes
};

struct HLine {
   LineCore core;

   datetime markTime;
   double price;
}; 

struct TrendLine {
   LineCore core;

   datetime startTime;   // yyyy.mm.dd hh:mi
   double startPrice;
   datetime endTime;
   double endPrice;
   int timePeriod; // represents the accurency of the current input time parameter.
};


//========================================================================================== Data
//FOREX.com
HLine hLines[] = {
//   symbol    name         level action       entryPriceDiff exitPriceDiff guardTime markTime             price
   {{"EURUSD", "h1",        LD1,  ACTION_SELL,  0.0200,      0.0100,        20},      D'2023.10.12 12:30', 1.06270}
};

TrendLine trendLines[] = {
//   symbol     name        level action       entryPriceDiff exitPriceDiff guardTime startTime            startPrice endTime              endPrice  timePeriod
   {{"EURUSD", "t1",        LD1,  ACTION_SELL, 0.0200,        0.0100,       20},      D'2023.07.18 15:35', 1.12749,   D'2023.08.10 12:30', 1.10646,  PERIOD_M1},
   {{"EURUSD", "Godzilla",  LW1,  ACTION_SELL, 0.0200,        0.0100,       20},      D'2023.07.18 15:35', 1.12749,   D'2023.08.30 22:00', 1.09454,  PERIOD_M1}
      // 2023.07.18 20:30   U.S. Retail Sales YoY(Jun)  [PREV 1.61 - EST 1.6 - CURR 1.49]   Bullish USD

};
#endif