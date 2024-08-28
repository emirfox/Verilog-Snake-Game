`timescale 1ns / 1ps


module Score_CountTB(

    );
    
    reg CLK, RESET, Reached_Target;
    wire [3:0] Score, SEG_SELECT;
    wire [7:0] DEC_OUT;
    
    Snake_Game_Timing_the_World_in_Decimal uut3(
        .CLK(CLK),
        .RESET(RESET),
        .Score(Score),
        .SEG_SELECT(SEG_SELECT),
        .DEC_OUT(DEC_OUT),
        .Reached_Target(Reached_Target)
        );
    
    initial begin
        CLK = 0;
        forever #100 CLK = ~CLK;
     end
    
    //for testing score is incrementing properly
    initial begin
        Reached_Target = 0;
        RESET = 0;
        #100
        RESET = 1;
        #100
        RESET = 0;
        forever #100 Reached_Target = ~Reached_Target;
     end
    
    
    
    
endmodule
