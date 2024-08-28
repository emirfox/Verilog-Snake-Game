`timescale 1ns / 1ps


module Pseudo_Random_Number_Generator(
    input RESET,
    input CLK,
    input Reached_Target,
    output reg [6:0] Random_Target_Y,
    output reg [7:0] Random_Target_X,
    output reg [6:0] D_Random_Target_Y,
    output reg [7:0] D_Random_Target_X,
    input [1:0] Play_State    
    );
    
    //two linear feedback registers, 8 bit and 7 bit
    // 7bit, xnor form  7,6
    // 8bit, xnor form  8,6,5,4
    
    //the linear feedback registers
    reg [6:0] LFSR_7;
    reg [7:0] LFSR_8;  
    reg [6:0] D_LFSR_7;
    reg [7:0] D_LFSR_8;  
    
    
    
    
    wire feedback; //Feedback for 7 bit linear shift register
    wire feedback_2; //Feedback for 8 bit linear shift register
   
    assign feedback = LFSR_7[6] ~^ LFSR_7[5]; //assign the feedback to the xnor of the 6 and 5 entry of the linear shift register
    assign feedback_2 = LFSR_8[7] ^ ~LFSR_8[5] ^ ~LFSR_8[4] ^ ~LFSR_8[3]; // similar to assiging feedback
    
    
    //Death generator uses the exact same logic as the normal target generator
    wire D_feedback;
    wire D_feedback_2;
   
    assign D_feedback = D_LFSR_7[6] ~^ D_LFSR_7[5];
    assign D_feedback_2 = D_LFSR_8[7] ^ ~D_LFSR_8[5] ^ ~D_LFSR_8[4] ^ ~D_LFSR_8[3];
    
    
    
    
        parameter MaxX = 79;
        parameter MaxY = 59;
        


    always@(posedge CLK) begin
        if(RESET || Play_State == 2'b00) begin
           LFSR_7 <= 20; //set the initial positions
           LFSR_8 <= 50;
           Random_Target_Y <= 20;
           Random_Target_X <= 50;
           D_LFSR_7 <= 30; 
           D_LFSR_8 <= 30; 
           D_Random_Target_Y <= 30;
           D_Random_Target_X <= 30;
           
           end 
        else begin
           LFSR_7 <= {LFSR_7[5:0], feedback};
           LFSR_8 <= {LFSR_8[6:0], feedback_2};
           D_LFSR_7 <= {D_LFSR_7[5:0], feedback};
           D_LFSR_8 <= {D_LFSR_8[6:0], feedback_2};           
           if(Reached_Target) begin 
               Random_Target_Y <= LFSR_7;
               Random_Target_X <= LFSR_8;
               D_Random_Target_Y <= D_LFSR_7;
               D_Random_Target_X <= D_LFSR_8;                                                            
               end               
           else begin
                Random_Target_Y <= Random_Target_Y;
                Random_Target_X <= Random_Target_X;
                D_Random_Target_Y <= D_Random_Target_Y;
                D_Random_Target_X <= D_Random_Target_X;
                if(Random_Target_Y > MaxY) begin //whenever the y random target generator has a value greater than the maximum y value set it to maximum y -10
                    Random_Target_Y <= MaxY - 10;
                    end
                else if(Random_Target_X > MaxX) begin //whenever the x random target generator has a value greater than the maximum x value set it to maximum x -20
                    Random_Target_X <= MaxX - 20;
                    end
                else if(Random_Target_X == 0) begin //whenever the x random target generator has a value equal set it to itself + 20
                        Random_Target_X <= Random_Target_X + 20;
                        end
                else if(Random_Target_Y == 0) begin //whenever the y random target generator has a value equal set it to itself + 10
                                Random_Target_Y <= Random_Target_Y + 10;
                                end         
               else if(D_Random_Target_Y > MaxY) begin //similar apply to death target as for normal target
                    D_Random_Target_Y <= MaxY - 20;
                    end
               else if(D_Random_Target_X > MaxX) begin
                    D_Random_Target_X <= MaxX - 30;
                    end
               else if(D_Random_Target_X == 0) begin
                        D_Random_Target_X <= D_Random_Target_X + 30;
                   end
               else if(D_Random_Target_Y == 0) begin
                            D_Random_Target_Y <= D_Random_Target_Y + 20;
                       end
               else if(D_Random_Target_X == Random_Target_X) begin
                                D_Random_Target_X <= D_Random_Target_X + 50;
                           end
               else if(D_Random_Target_Y == Random_Target_Y) begin
                                D_Random_Target_Y <= D_Random_Target_Y + 50;
                            end
                                              
           end           
       end
    end
            
                    
    
    
    
endmodule
