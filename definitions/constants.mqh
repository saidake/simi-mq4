#ifndef definition_constants
#define definition_constants
//=================================================== Timeline Color
#define LD1 clrAqua
#define LW1 clrYellow
#define LY1 clrDarkViolet
//=================================================== Event Color
#define LE1 clrDarkViolet

//=================================================== Object 
struct HLine{ 
   string name;
   string note;
   
   color level;
   int style;
   double price;
}; 

struct TrendLine{ 
   string name;
   string note;
   
   color level;
   int style;
   
   string startTime;   // yyyy.mm.dd hh:mi 
   double startPrice;
   
   string endTime;
   double endPrice;
}; 

//=================================================== Data 
// 7*0.45=3.15   7*0.4=2.80 （2 rounds） 2 3 4 5 6 7 8
// 7*0.57=3.99   7*0.52=3.64 （2 rounds）  2 3 4 5 6 7 8
HLine hLines[] = {
   {"h1", "test1", LD1, STYLE_SOLID,  1.07975},  
   {"h2", "test2", LW1, STYLE_DOT, 1.07485 },
   {"h3", "test2", LY1, STYLE_SOLID, 1.07785 }
};

TrendLine trendLines[] = {
   {"t1", "test trend line1", LE1,  STYLE_SOLID, "2023.07.18 07:30", 1.12757, "2023.08.10 12:30",1.10646}
   //lineName: t1, barsNumber: 20, time: 28800min/480.00h/20.00d, priceDiff: -211.1


};
#endif