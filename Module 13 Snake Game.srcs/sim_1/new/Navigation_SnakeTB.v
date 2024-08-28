`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// // Create Date: 25.11.2023 15:00:57
// Design Name: 
// Module Name: Navigation_SnakeTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Navigation_SnakeTB(

    );
    
   reg CLK, RESET, BTNR, BTNU, BTND, BTNL;
   wire [1:0] Direction_State;
    
    Snake_Game_Navigation_State_Machine uut4(
           .BTNR(BTNR),
           .BTNL(BTNL),
           .BTND(BTND),
           .BTNU(BTNU),
           .CLK(CLK),
           .RESET(RESET),
           .Direction_State(Direction_State)
        );
        
                initial begin
                    CLK = 0;
                    #100 
                    forever #10 CLK = ~CLK;
                 end
                
                initial begin
                         RESET = 0;
                         BTNL = 0;
                         BTNU = 0;
                         BTND = 0;
                         BTNR = 0;
                         #100
                         BTNL = 1;
                         #100
                         BTNL = 0;
                         BTNU = 1;
                         #100
                         BTNU = 0;
                         BTNR = 1;
                         #100
                         BTNR = 0;
                         BTND = 1;
                         #100
                         BTND = 0;
                     end        
        
    
    
    
endmodule
