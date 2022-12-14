# Ticket-Vending-Machine

## 開發平台
Windows10

## 開發環境
ModelSim-Altera 10.1d (Quartus II 13.1)

## 使用流程
1. 以ModelSim開啟vending_machine.n以及stimulus.v並編譯
2. 對stimulus.v進行模擬

## 說明
利用有限狀態機(FSM)的方法模擬出車站的自動售票販賣機，含有選站、選張數、付款、吐票與找零等4種狀態
![image](https://github.com/YunTing-Lee/Ticket-Vending-Machine/blob/main/Picture/status.png)
- 首先要輸入兩個站（起站與終站）                                     // 初始狀態(S0)
- 接著輸入張數                                                        // 選擇張數的狀態(S1)
- 開始投錢 （此時要顯示已投入多少錢以及還欠缺多少錢）               // 付款狀態(S2)
- 當錢的數量足夠時輸出找零和票數（此時要顯示須找多少錢以及票數）   // 結帳狀態(S3)
- 當退幣(reset)時  必須退出所有已輸入的零錢 回到初始的狀態（選站)   // 取消買票(S0)
- 可以投入零錢種類為1元、5元、10元、50元 ( 不可同時投入多個硬幣，例如: 一次投入2個1元 )
- 票數的選擇為 1～5張 
- 車站為 S1, S2, S3, S4 , S5 共五站
- 選站時必須選擇 起點站 與 終點站
- 當起站與終站相同時則為月台票
- 票價 : 
![image](https://github.com/YunTing-Lee/Ticket-Vending-Machine/blob/main/Picture/ticket%20price.png)
---
## 程式運行結果
### 文字輸出部分 : 
![image](https://github.com/YunTing-Lee/Ticket-Vending-Machine/blob/main/Picture/result.PNG)
### 波型圖 : 
![image](https://github.com/YunTing-Lee/Ticket-Vending-Machine/blob/main/Picture/waveform.PNG)