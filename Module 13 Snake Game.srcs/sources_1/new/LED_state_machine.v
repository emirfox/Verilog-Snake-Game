`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2023 08:52:39
// Design Name: 
// Module Name: LED_state_machine
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


module LED_state_machine(
    input CLK,
    input RESET,
    input [1:0] Play_State,
    output [3:0] LED_OUT,
    output [3:0] LED_Display_SM_Out
    );
    wire one_sec;
        
        simple_generic_counter # (.COUNTER_WIDTH(27),
                                  .COUNTER_MAX(99999999)
                                  )
                               Bit27_one_sec_Counter(
                                        .CLK(CLK),
                                        .RESET(RESET),
                                        .ENABLE(1'b1),
                                        .TRIG_OUT(one_sec)
                                                  );
                                                  
        //State Machine Code
        reg [3:0] Curr_State;
        reg [3:0] Next_State;
        
        reg [3:0] Curr_LEDs;
        reg [3:0] Next_LEDs;
        
        assign LED_Display_SM_Out = Curr_State;
        assign LED_OUT = Curr_LEDs;
        
        //Sequential logic
            always@(posedge CLK) begin
              if(RESET)begin
                Curr_State <= 4'h0;
                Curr_LEDs <= 4'h00;
              end
              else begin
                  Curr_State <= Next_State;
                  Curr_LEDs <= Next_LEDs;
              end
           end
            
            //Combinational Logic
            always@(Curr_State or Play_State) begin
                case(Curr_State)
                    4'd0    : begin
                        if(Play_State == 2'b00)
                            Next_State <= 4'd1;
                        else
                            Next_State <= 4'd0;
                            Next_LEDs <= 8'b00000000;
                        end
                        
                    4'd1    : begin
                        if(one_sec) begin
                            Next_State <= 4'd2;
                        end    
                        else begin
                            Next_State <= Curr_State;
                        end
                        Next_LEDs <= 8'b00000001;
                     end
        
                    4'd2    : begin
                        if(one_sec) begin
                            Next_State <= 4'd3;
                        end    
                        else begin
                            Next_State <= Curr_State;
                        end
                        Next_LEDs <= 8'b00000010;
                     end                
                     
                    4'd3    : begin
                         if(one_sec) begin
                             Next_State <= 4'd4;
                         end    
                         else begin
                             Next_State <= Curr_State;
                         end
                    Next_LEDs <= 8'b00000100;     
                    end
                     
                    4'd4   :  begin
                         if(one_sec) begin
                             Next_State <= 2'b01;       //play state triggered
                         end    
                         else begin
                             Next_State <= Curr_State;
                         end
                    Next_LEDs <= 8'b00000100;     
                    end

                    default : Next_State <= 4'd0;
                  endcase
                end
endmodule
