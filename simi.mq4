#property strict
#include "functions/drawing.mqh"
#include "definitions/constants.mqh"

int OnInit(){
   Print("simi Init");
   ObjectsDeleteAll(ChartID());
   AutoCreateHlines();
   AutoCreateTrendlines();
   return(INIT_SUCCEEDED);
}


void OnDeinit(const int reason){
   ObjectsDeleteAll(ChartID());
   Print("simi Deinit");
}


void OnTick(){
   Comment("simi test");
   
     /*
      if (TimeHour(TimeCurrent()) <= 24){
   if (TimeHour(TimeCurrent()) >= 0){
   
  {
   //ObjectCreate("Horizontal line",OBJ_HLINE,0, datetime time1, double price1, datetime time2=0, double price2=0, datetime time3=0, double price3=0);
   ObjectCreate("Horizontal line",OBJ_HLINE,0,D'2004.02.20 12:30', Close[1] 1.0045 
   );}
  }}
   */
}