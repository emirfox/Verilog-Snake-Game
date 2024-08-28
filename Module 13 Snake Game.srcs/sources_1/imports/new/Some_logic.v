`timescale 1ns / 1ps


module Some_logic(
    input [9:0] X,
    input [8:0] Y,
    input [1:0] Play_State,
    output reg [11:0] Colour,
    input CLK,
    input [11:0] Colour_in
        );

  //State Machine Pattern
    reg[15:0] FrameCount; //needs to count to 1120 for including X and Y pixels
    
    always@(posedge CLK) begin
        if(Y == 479) begin
            FrameCount <= FrameCount + 1;
        end
     end
    
        always@(posedge CLK) begin
                case(Play_State)
                    //Idle state is blue
                    2'b00    : begin
                        Colour <= 12'hF00;
                        end
                    //Play state is the input from the snake control
                    2'b01    : begin
                            Colour <= Colour_in;
                        end
                    //Win state is a pattern
                    2'b10    : begin
                        if(Y[8:0] > 240) begin
                            if(X[9:0] > 320)
                                Colour <= FrameCount[15:8] + Y[7:0] + X[7:0] - 240 - 320;
                            else
                                Colour <= FrameCount[15:8] + Y[7:0] - X[7:0] - 240 + 320;
                        end
                        else begin
                            if(X[9:0] > 320)
                                Colour <= FrameCount[15:8] - Y[7:0] + X[7:0] + 240 - 320;
                            else
                                Colour <= FrameCount[15:8] - Y[7:0] - X[7:0] + 240 + 320;
                            end
                        end
                      //Lose state display red screen
                      2'b11     :begin
                        Colour <= 12'h00F;
                        end
                endcase
            end

       
endmodule