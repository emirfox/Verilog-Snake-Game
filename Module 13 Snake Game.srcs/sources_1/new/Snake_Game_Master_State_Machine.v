`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module Snake_Game_Master_State_Machine(
   input BTNR,
   input BTNL,
   input BTND,
   input BTNU,
   input CLK,
   input RESET,
   input [3:0] Score,
   output [1:0] Play_State,
   input Body_hit,
   input time_is_up
    );
    
    //Tested, functionality seems correct
    
    reg [1:0] CurrState;
    reg [1:0] NextState;
    
    assign Play_State = CurrState;
    
        //Sequential logic
               always@(posedge CLK) begin
                 if(RESET)begin
                   CurrState <= 2'h0;
                 end
                 else begin
                     CurrState <= NextState;
                 end
              end

    
    
    
    always@(CurrState or BTNU or BTND or BTNL or BTNR or Score or Body_hit or time_is_up) begin
        case(CurrState)
        //idle state
            2'b00   : begin
                if(BTNU | BTNL | BTNR | BTND)
                    NextState <= 2'b01;
                else
                    NextState <= CurrState;
                end
            
            //play state
            2'b01   : begin
                    if(Score > 2)    //so that the game ends when score 3 is reached for question 1
                        NextState <= 2'b10;
                    else if(Body_hit || time_is_up)
                        NextState <= 2'b11;
                    else
                        NextState <= CurrState;
                    end 
                    
             //Win State       
            2'b10   : begin
                     NextState <= CurrState;
                end
           //Lose State
            2'b11   : begin
                    NextState <= CurrState;
                end
                                    
                 default : NextState <= 2'b00;
            endcase
         end      
            
            
    
endmodule
