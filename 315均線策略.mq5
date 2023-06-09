//+------------------------------------------------------------------+
//|                                                      315均線策略.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"


#include  <classpack.mqh>
ClassPack CPack ;


double day3_ma_values[];  //裝3日iMA值的陣列
double day3_ma_handle;  //3日iMA指標的句柄

double day15_ma_values[];  //裝15日iMA值的陣列
double day15_ma_handle;  //15日iMA指標的句柄

int position_type = 0;  //long position(多頭) = 1      short position(空頭) = -1   

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
//---

//--- 创建iMA指标
day3_ma_handle = iMA(NULL,PERIOD_CURRENT,3,0,MODE_EMA,PRICE_OPEN);


//--- 创建iMA指标
day15_ma_handle = iMA(NULL,PERIOD_CURRENT,15,0,MODE_EMA,PRICE_OPEN);

   
//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

//--- 用当前iMA的值填充day3_ma_values[]数组
//--- 复制1个元素
CopyBuffer(day3_ma_handle,0,0,1,day3_ma_values);   //day3_ma_values[0]為當前bar的MA值

//--- 用当前iMA的值填充day15_ma_values[]数组
//--- 复制1个元素
CopyBuffer(day15_ma_handle,0,0,1,day15_ma_values); //day15_ma_values[0]為當前bar的MA值


if (position_type == 0){   //沒有空頭或是多頭的狀態，就賦予它現在事空頭還是多頭
   if(day3_ma_values[0] > day15_ma_values[0]){
   position_type = 1;
   }
   if(day3_ma_values[0] < day15_ma_values[0]){
   position_type = -1;
   }
}


//--- 如果3日均線大於15日均線
if(day3_ma_values[0] > day15_ma_values[0]){
   if (position_type != 0){   //有空頭或是多頭的狀態
      if(position_type == -1){   // 如果之前是空頭
         if(PositionsTotal() > 0){  //如果有持倉
            trade.PositionClose(_Symbol);
            position_type = 1;
         }
            
         if(PositionsTotal() < 1){  //沒有持倉就開倉
            trade.Buy(0.01);
            position_type = 1;   //轉換狀態為空頭
         }
      }  
   }
}


if(day15_ma_values[0] > day3_ma_values[0]){
   if (position_type != 0){   //有空頭或是多頭的狀態
      if(position_type == 1){ // 如果之前是多頭
         if(PositionsTotal() > 0){  //如果有持倉
            trade.PositionClose(_Symbol);
            position_type = -1;
         }
            
         if(PositionsTotal() < 1){  //沒有持倉就開倉
            trade.Sell(0.01);
            position_type = -1;  //轉換狀態為空頭
         }
      }  
   }
}


   
}
//+------------------------------------------------------------------+
