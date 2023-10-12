#property strict
#include "definitions/constants.mqh"
#include "functions/drawing.mqh"
#include "functions/clock.mqh"


int OnInit(){
   //Clear(); // Clear the terminal output
   //SetTerminalColors(CLR_WHITE, CLR_BLACK);
   ObjectsDeleteAll(ChartID());
   DrawHLines();
   DrawTrendLines();
   //A. create a timer with a 60 seconds period
   EventSetTimer(60);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
   //A. destroy the timer after completing the work
   EventKillTimer();
   ObjectsDeleteAll(ChartID());
}

void OnTick(){
   Comment("simi test");
}

void OnTimer(){
  
}