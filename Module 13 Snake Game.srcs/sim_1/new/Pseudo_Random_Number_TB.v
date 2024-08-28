`timescale 1ns / 1ps

module Pseudo_Random_Number_TB(

    );
    
    reg CLK;
    reg RESET;
    reg Reached_Target;
    wire [6:0] Random_Target_Y;
    wire [7:0] Random_Target_X;
    
    Pseudo_Random_Number_Generator uut(
        .RESET(RESET),
        .CLK(CLK),
        .Reached_Target(Reached_Target),
        .Random_Target_Y(Random_Target_Y),
        .Random_Target_X(Random_Target_X)
        );
    
    initial begin
    CLK = 0;
    forever #10 CLK = ~CLK;
    end
    
    initial begin
    RESET = 1;
    Reached_Target = 0;
    #100
    RESET = 0;
    #100
    RESET = 0;
    Reached_Target = 1;
    #100
    Reached_Target = 0;
    #100
    RESET = 1;
    #100
    RESET = 0;
    Reached_Target = 1;
    forever #100 Reached_Target = ~Reached_Target;
    end 
    
    
endmodule
