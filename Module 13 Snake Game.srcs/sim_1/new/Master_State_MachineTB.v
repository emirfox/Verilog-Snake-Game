`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: // Create Date: 25.11.2023 15:00:57
// Design Name: 
// Module Name: Master_State_MachineTB
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



    
    
`timescale 1ns / 1ps

`timescale 1ns / 1ps

module Master_State_MachineTB;
    
    reg CLK, RESET, BTNR, BTNU, BTND, BTNL, Body_hit, time_is_up;
    wire [1:0] Play_State;
    reg [3:0] Score;

    // Instantiate the Unit Under Test (UUT)
    Snake_Game_Master_State_Machine uut2(
       .BTNR(BTNR),
       .BTNL(BTNL),
       .BTND(BTND),
       .BTNU(BTNU),
       .CLK(CLK),
       .RESET(RESET),
       .Play_State(Play_State),
       .Score(Score),
       .Body_hit(Body_hit),
       .time_is_up(time_is_up)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        RESET = 1; // Start with a reset to ensure we're in the initial state
        #20;
        RESET = 0;
        Score = 0;
        BTNL = 0;
        BTNU = 0;
        BTND = 0;
        BTNR = 0;
        Body_hit = 0;
        time_is_up = 0;

        // Wait for a moment before starting the simulation
        #100;
        
        // Scenario 1: Transition to PLAY state
        BTNR = 1; // Simulate right button press to start the game
        #20;
        BTNR = 0; // Release right button
        #20; // Check if the game is in PLAY state
        
        // Scenario 2: Score increment and transition to WIN state
        Score = 1; // Increment score
        #20;
        Score = 2; // Increment score
        #20;
        Score = 3; // Increment score to transition to WIN state
        #20; // Verify WIN state

        // Scenario 3: Transition to LOSE state due to Body_hit
        RESET = 1; // Reset the game first
        #20;
        RESET = 0;
        #20;
        BTNR = 1; // Start the game again
        #20;
        BTNR = 0;
        #20;
        Body_hit = 1; // Trigger body hit
        #20; // Verify LOSE state due to Body_hit
        
        // Scenario 4: Transition to LOSE state due to time_is_up
        RESET = 1; // Reset the game first
        #20;
        RESET = 0;
        #20;
        BTNU = 1; // Start the game again
        #20;
        BTNU = 0;
        #20;
        time_is_up = 1; // Trigger time up
        #20; // Verify LOSE state due to time_is_up
        

         // End the simulation
    end
    
endmodule

