`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//  Create Date: 25.11.2023 15:00:57
// Design Name: 
// Module Name: Snake_Game_Top_wrapper
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


module Snake_Game_Top_wrapper(
    input CLK,
    input RESET,
    input BTNU,
    input BTND,
    input BTNL,
    input BTNR,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS,
    output [3:0] SEG_SELECT,
    output [7:0] HEX_OUT
    );
    
    wire [1:0] MSM_State;
    wire [1:0] Direction_State;
    wire Reached_Target;
    wire [11:0] Colour;
    wire [6:0] Random_Target_Y;
    wire [7:0] Random_Target_X;
    wire [6:0] D_Random_Target_Y;
    wire [7:0] D_Random_Target_X;    
    wire [9:0] ADDRH; 
    wire [8:0] ADDRV;
    wire [3:0] Score;
    wire Body_hit;
    wire time_is_up;
    
    Snake_Game_Master_State_Machine Master_State_Machin(
      .BTNR(BTNR),
      .BTNL(BTNL),
      .BTND(BTND),
      .BTNU(BTNU),
      .CLK(CLK),
      .RESET(RESET),
      .Score(Score), //w
      .Play_State(MSM_State), //w
      .Body_hit(Body_hit), //w
      .time_is_up(time_is_up) //w
      );
    
    Snake_Game_Navigation_State_Machine Navigation_State_Machine(
          .BTNR(BTNR),
          .BTNL(BTNL),
          .BTND(BTND),
          .BTNU(BTNU),
          .CLK(CLK),
          .RESET(RESET),
          .Direction_State(Direction_State) //w
          );  
          
     Snake_controller_2 Snake_Control(
              .CLK(CLK),
              .RESET(RESET),
              .ADDRH(ADDRH),
              .ADDRV(ADDRV),
              .Random_Target_Y(Random_Target_Y),
              .Random_Target_X(Random_Target_X),           
              .Reached_Target(Reached_Target),
              .Play_State(MSM_State),
              .Direction_State(Direction_State),
              .Colour(Colour),
              .Body_hit(Body_hit),
              .D_Random_Target_Y(D_Random_Target_Y),
              .D_Random_Target_X(D_Random_Target_X)                                        
              
              );     
      
     Pseudo_Random_Number_Generator Target_Generator(
                  .CLK(CLK),
                  .RESET(RESET),
                  .Reached_Target(Reached_Target),
                  .Random_Target_Y(Random_Target_Y),
                  .Random_Target_X(Random_Target_X),
                  .D_Random_Target_Y(D_Random_Target_Y),
                  .D_Random_Target_X(D_Random_Target_X),
                  .Play_State(MSM_State)                                        
                  ); 
                  
     Wrapper_VGA VGA_interface(                      
                      .CLK(CLK),
                      .COLOUR_OUT(COLOUR_OUT),
                      .HS(HS),
                      .Play_State(MSM_State),
                      .VS(VS),
                      .ADDRH(ADDRH),
                      .ADDRV(ADDRV),
                      .COLOUR_IN(Colour)
                      );            
                            
    Snake_Game_Timing_the_World_in_Decimal Score_Counter(
                          .CLK(CLK),
                          .RESET(RESET),
                          .SEG_SELECT(SEG_SELECT),
                          .DEC_OUT(HEX_OUT),
                          .Score(Score),
                          .Reached_Target(Reached_Target),
                          .Play_State(MSM_State),
                          .time_is_up(time_is_up) 
                          );
                          
    LED_state_machine LED(
                          .CLK(CLK),
                          .RESET(RESET),
                          .Play_State(CurrState),
                          .LED_OUT(LED_OUT),
                          .LED_Display_SM_Out(LED_STATE_Out)
                           );
    
    
endmodule
