//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property description "Example of placing pending orders"
#property script_show_inputs
#include <Trade\trade.mqh>
#include <Trade\PositionInfo.mqh>
CTrade trade;



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ClassPack
{

public:
   int               buy_quantity(const double volume,const double how_many_orders);//現價買入函數 (手數,單數))
   int               sell_quantity(const double volume,const double how_many_orders);//現價賣出函數 (手數,單數))

   bool              isnewbar(const bool print_log=true);//新bar產生時回傳true
   
   string            current_time();
   string            current_time_date();
   string            current_time_seconds();
   

  








}; //class結束

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ClassPack::buy_quantity(const double volume,const double how_many_orders)//現價買入函數 (手數,單數))
{
   //持倉數小於設定數就現價買入
   if (PositionsTotal() < how_many_orders ){
    trade.Buy(volume);
   }

   return 0;
} //buy_quantityy完




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ClassPack::sell_quantity(const double volume,const double how_many_orders)//現價賣出函數 (手數,單數))
{
   //持倉數小於設定數就現價賣出
   if (PositionsTotal() < how_many_orders ){
    trade.Buy(volume);
   }

   return 0;

}//sell_quantityy完



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

bool ClassPack::isnewbar(const bool print_log=true)
{
   datetime lastbar_timeopen;//自定義

   static datetime bartime=0; //存??前柱形?的????
//--- ?得零柱的????
   datetime currbar_time=iTime(_Symbol,_Period,0);
//--- 如果????更改，?新柱形?出?
   if(bartime!=currbar_time)
   {
      bartime=currbar_time;
      lastbar_timeopen=bartime;
      //--- 在日志中?示新柱形?????的?据
      if(print_log && !(MQLInfoInteger(MQL_OPTIMIZATION)||MQLInfoInteger(MQL_TESTER)))
      {
         //--- ?示新柱形?????的信息
         PrintFormat("%s: new bar on %s %s opened at %s",__FUNCTION__,_Symbol,
                     StringSubstr(EnumToString(_Period),7),
                     TimeToString(TimeCurrent(),TIME_SECONDS));
         //--- ?取?于最后?价的?据
         MqlTick last_tick;
         if(!SymbolInfoTick(Symbol(),last_tick))
            Print("SymbolInfoTick() failed, error = ",GetLastError());
         //--- ?示最后?价的??，精确至毫秒
         PrintFormat("Last tick was at %s.%03d",
                     TimeToString(last_tick.time,TIME_SECONDS),last_tick.time_msc%1000);
      }
      //--- 我?有一?新柱形?
      return (true);
   }
//--- ?有新柱形?
   return (false);
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ClassPack::current_time()
{
   int a = 0;
   datetime dt1[1];
   if(CopyTime(_Symbol, PERIOD_CURRENT, 0, 1, dt1) == 1)
   {
      TimeToString(dt1 [0], TIME_DATE| TIME_SECONDS);
   }
   return TimeToString(dt1 [0], TIME_DATE| TIME_SECONDS);
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ClassPack::current_time_date()
{
   int a = 0;
   datetime dt1[1];
   if(CopyTime(_Symbol, PERIOD_D1, 0, 1, dt1) == 1)
   {
      TimeToString(dt1 [0], TIME_DATE);
   }

   return TimeToString(dt1 [0], TIME_DATE);
}



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ClassPack::current_time_seconds()
{
   int a = 0;
   datetime dt1[1];
   if(CopyTime(_Symbol, PERIOD_M1, 0, 1, dt1) == 1)
   {
      TimeToString(dt1 [0], TIME_SECONDS);
   }



   return TimeToString(dt1 [0], TIME_SECONDS);
}







//+------------------------------------------------------------------+
