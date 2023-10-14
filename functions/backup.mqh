#ifndef functions_backup
#define functions_backup

double getArrowVerticalOffset(double digit, bool isUpward){
    Print("CHART_SCALE: ",CHART_SCALE);
    int offset=0;
    switch(Period()){
        case 1:      offset= 6;     break;    
        case 5:      offset= 10;    break;
        case 15:     offset= 20;    break;
        case 30:     offset= 20;    break;
        case 60:     offset= 20;    break;
        case 240:    offset= 10;    break;
        case 1440:   offset= 50;;   break;
        case 10080:  offset= 100;   break;
        case 43200:  offset= 200;   break;
        default: offset= 0;   break;       
    }
    return offset*digit;
}


double YShiftToPriceShift(const int YShift)
{
    int oldestVisibleBar = WindowFirstVisibleBar();
    int XStart;
    int YStart;
    ChartTimePriceToXY(0, 0, Time[oldestVisibleBar], Close[oldestVisibleBar], XStart, YStart);

    int subWindow;
    datetime timeEnd;
    double priceEnd;
    ChartXYToTimePrice(0, XStart, YStart + YShift, subWindow, timeEnd, priceEnd);

    double priceShift = priceEnd - Close[oldestVisibleBar];
    return priceShift;
}


#endif