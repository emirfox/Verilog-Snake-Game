`timescale 1ns / 1ps



module Snake_Game_Top_wrapperTB(

    );
    
    reg CLK, RESET, BTNU, BTND, BTNL, BTNR;
    wire [11:0] COLOUR_OUT;
    wire [3:0] SEG_SELECT;
    wire [7:0] HEX_OUT;
    
    Snake_Game_Top_wrapper uut5(
        .CLK(CLK),
        .RESET(RESET),
        .BTNU(BTNU),
        .BTND(BTND),
        .BTNL(BTNL),
        .BTNR(BTNR),
        .COLOUR_OUT(COLOUR_OUT),
        .SEG_SELECT(SEG_SELECT),
        .HEX_OUT(HEX_OUT)
        );
        
    initial begin
           CLK = 0;
           forever #10 CLK = ~CLK;
           end
           
    initial begin
        RESET = 0;
        BTNU = 0;
        BTND = 0;
        BTNL = 0;
        BTNR = 0;
        #100
        BTNU = 1;
        #100
        BTNU = 0;
        BTNL = 1;
        #100
        BTNL = 0;
        BTND = 1;
        #100
        BTND = 0;
        BTNR = 1;
        #100
        BTNR = 0;
        end           
                   
    
endmodule
