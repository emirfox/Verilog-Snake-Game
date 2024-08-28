`timescale 1ns / 1ps


module Snake_controller_2(
    input CLK,
    input RESET,
    input [9:0] ADDRH, 
    input [8:0] ADDRV, 
    input [6:0] Random_Target_Y,
    input [7:0] Random_Target_X,
    input [6:0] D_Random_Target_Y,
    input [7:0] D_Random_Target_X,        
    output reg Reached_Target,
    input [1:0] Play_State,
    input [1:0] Direction_State,
    output reg [11:0] Colour,
    output  reg Body_hit
    );
    
    
    
    parameter MaxX = 79; //159
    parameter MaxY = 59; //119
    parameter SnakeLength = 40;
    parameter Snake_Start_X = 40;
    parameter Snake_Start_Y = 40;
    
    
    reg [26:0] Counter;
    reg [26:0] Counter_Max;
    
    parameter INITIAL_COUNTER_MAX = 10000000;  // Set this to your desired initial value
    
    initial begin
       Counter_Max <= 10000000;
      end
      
    //How to increase the speed of the snake after it eats a target
  //  always@(posedge CLK) begin
    //    if(RESET)
      //    Counter_Max <= 10000000;
       // else if(Reached_Target)
         // Counter_Max <= Counter_Max - 500000;  //whenever a target is reached subtract the max counter, since there is less to count, Counter == 0 will happen quicker thus increasing snake speed 
        //else
        //  Counter_Max <= Counter_Max;
       // end
       
       // Modify the Counter_Max logic to double the speed    for question 3
       always@(posedge CLK) begin
           if(RESET)
               Counter_Max <= INITIAL_COUNTER_MAX; // Define this constant at the top of your module
           else if(Reached_Target)
               Counter_Max <= Counter_Max >> 1;  // Right shift by 1 (equivalent to dividing by 2)
           else
               Counter_Max <= Counter_Max;
       end
          
    always@(posedge CLK) begin
        if(RESET)
            Counter <= 0;
        else begin
            if(Play_State == 2'b01) begin
                if(Counter == Counter_Max)
                    Counter <= 0;
                else
                    Counter <= Counter + 1;
                end
            end
        end
        
    //Snake is a 2 dimensional shift register, 1 dimension representing x, 1 dimension representing y
    //Snake_X * Snakelength and Snake_Y * Snakelength. Where 15 bits are split between X and Y, 8 and 7 bits respectively * the snake length
    //Making 2 2 dimensional shift registers
    reg [7:0] SnakeState_X [0: SnakeLength -1];
    reg [6:0] SnakeState_Y [0: SnakeLength -1];
    
    reg Body_hit_side;
    initial begin
        Body_hit_side <= 0;
        end
       
     
//How to represent a snake     
 //Replace top snake state with new one based on direction
         always@(posedge CLK) begin
           if(RESET || Play_State == 2'b00) begin
           //set the initial state of the snake
               SnakeState_X[0] <= Snake_Start_X;
               SnakeState_Y[0] <= Snake_Start_Y;
               Body_hit_side <= 0;                    
           end
           else if (Counter == 0) begin
               case(Direction_State)
                   2'b00   :begin //up
                       if(SnakeState_Y[0] == 0)
                           Body_hit_side <= 1; // for snake going through walls SnakeState_Y[0] <= MaxY;  , for side hit Body_hit_side <= 1;
                       else
                           SnakeState_Y[0] <= SnakeState_Y[0] -1;
                       end
   
                   2'b01   :begin //left
                       if(SnakeState_X[0] == 0)
                           Body_hit_side <= 1; // for snake going through walls SnakeState_X[0] <= MaxX; , for side hit Body_hit_side <= 1;
                       else
                           SnakeState_X[0] <= SnakeState_X[0] -1;
                       end
   
                   2'b10   :begin //right
                       if(SnakeState_X[0] == MaxX)  
                           Body_hit_side <= 1; // for snake going through walls SnakeState_X[0] <= 0; , for side hit Body_hit_side <= 1;
                       else
                           SnakeState_X[0] <= SnakeState_X[0] +1;
                       end
   
                   2'b11   :begin //down
                       if(SnakeState_Y[0] == MaxY)
                           Body_hit_side <= 1; // for snake going through walls SnakeState_Y[0] <= 0; , for side hit Body_hit_side <= 1;
                       else
                           SnakeState_Y[0] <= SnakeState_Y[0] +1;
                       end
                       
                    default: SnakeState_X[0] <= SnakeState_X[0];                       
               endcase
             end
          end     
    

    //Changing the position of the snake registers
    //Shift the SnakeState X and Y
    genvar PixNo;
    generate
        for (PixNo = 0; PixNo < SnakeLength-1; PixNo = PixNo+1)
        begin: PixShift
            always@(posedge CLK) begin
                if(RESET) begin
                    SnakeState_X[PixNo+1] <= 80;
                    SnakeState_Y[PixNo+1] <= 100;
                end
                else if(Counter == 0) begin
                    SnakeState_X[PixNo+1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo+1] <= SnakeState_Y[PixNo];
                end
             end
          end
      endgenerate
    
    //How to display a snake    
    
   //if the pixel address belongs to the target display red, if it belongs to the snake display yellow and the background is blue
   //hF00 is blue, h00F is red and h0F0 is green

           

       reg [3:0] target_size = 1;  // Starts at 1, increment when a target is eaten. for question 3
       reg target_found; // A new signal to capture the target found event
   
   always @(posedge CLK) begin
           if(RESET) begin
               Reached_Target <= 0;
               target_size <= 1; // Reset target size on reset
               target_found <= 0;
               Body_increment <= SnakeStartValue; // Reset body size on reset
           end else begin
               // Check if the snake head has reached the target
               if((SnakeState_X[0] == Random_Target_X) && (SnakeState_Y[0] == Random_Target_Y)) begin
                   // If counter is 0, it ensures one update per movement cycle
                   if (Counter == 0) begin
                       target_found <= 1;
                       Reached_Target <= 1;
                       Body_increment <= Body_increment + 1; // Grow the snake
                       target_size <= target_size + 1; // Increase target size if needed
                   end
               end else begin
                   target_found <= 0; // Clear the target found event
                   // Only reset Reached_Target if snake has grown
                   if (Body_increment == SnakeLength) begin
                       Reached_Target <= 0;
                   end
               end
           end
       end

    



    
    
    integer s;  // Declare the loop variable outside of the always block
    
    always @(posedge CLK) begin
        // Reset colour to background first
        Colour <= 12'hF00; // Assuming blue is the background colour
    
        // Head of the snake
        if ((SnakeState_X[0] == ADDRH[9:3]) && (SnakeState_Y[0] == ADDRV[8:3])) begin
            Colour <= 12'h00F; // Colour of the snake head
        end
        else if (ADDRH >= (Random_Target_X - target_size) && ADDRH < (Random_Target_X + target_size) &&
                 ADDRV >= (Random_Target_Y - target_size) && ADDRV < (Random_Target_Y + target_size)) begin
            Colour <= 12'h00F; // Colour for the target
        end
        // Death target rendering
        else if (ADDRH[9:3] == D_Random_Target_X && ADDRV[8:3] == D_Random_Target_Y) begin
            Colour <= 12'hFFF; // Colour for the death target
        end
        // Snake body rendering
        else if (ADDRH[9:3] == D_Random_Target_X && ADDRV[8:3] == D_Random_Target_Y) begin
            Colour <= 12'hFFF; // Colour for the death target
        end
        // Snake body rendering
        else if ((SnakeState_X[1] == ADDRH[9:3]) && (SnakeState_Y[1] == ADDRV[8:3]) && Body_increment > 1) begin
            Colour <= 12'h0F0; // Colour for the snake body part 1
        end
        else if ((SnakeState_X[2] == ADDRH[9:3]) && (SnakeState_Y[2] == ADDRV[8:3]) && Body_increment > 2) begin
            Colour <= 12'h0F0; // Colour for the snake body part 2
        end
        else if ((SnakeState_X[3] == ADDRH[9:3]) && (SnakeState_Y[3] == ADDRV[8:3]) && Body_increment > 3) begin
            Colour <= 12'h0F0; // Colour for the snake body part 3
        end
    end


    
   //How to determine if death target is hit
    reg D_Target; 

    initial begin
        D_Target <= 0;
    end  

    always@(posedge CLK) begin
    if(RESET)
        D_Target <=0;
    else if((SnakeState_X[0] == D_Random_Target_X) && (SnakeState_Y[0] == D_Random_Target_Y) && (Counter == 0)) //ezact same logic as normal target
        D_Target <= 1;
    else
        D_Target <= 0;
    end
   
   
    //Body hit detection (has the body hit something it should not)
    integer bh;
    initial begin
      Body_hit <= 0;
      end
      
    always@(posedge CLK) begin
        if(RESET)
            Body_hit = 0;
        else if(Body_hit_side) begin
            Body_hit <= 1;
          end             
       else if(D_Target) begin
            Body_hit <= 1;
        end   
       else if(pixshiftamount) begin //At the start when the snake comes out it is like it is hitting itself. To preven instant death this condition is usesd
        for(bh = 1; bh<Body_increment; bh = bh+1) begin //put SnakeLength if using normal snake
            if((SnakeState_X[0] == SnakeState_X[bh]) && (SnakeState_Y[0] == SnakeState_Y[bh])) //iterate throughout the whole body of the snake in order to see if the head has hit the body
                Body_hit <= 1;
                end
            end
         end     
  
  
  
  //This indicates when the snake moves from its initial position, to make sure body hit does not go off instantly
  reg pixshiftamount;
  initial begin
    pixshiftamount = 0;
    end
    
  always@(posedge CLK) begin
    if(RESET)
        pixshiftamount <= 0;
    else if(SnakeState_X[SnakeStartValue] != Snake_Start_X || SnakeState_Y[SnakeStartValue] != Snake_Start_X) //making sure that only whenever the last bit of the snake is moved that body detection is valid
        pixshiftamount <= 1;
    else
        pixshiftamount <= pixshiftamount;
  end
  
  //body increment after eating target
  parameter SnakeStartValue = 1; //Make sure to make the starting snake value less than Snakemaxlength -10 or 40 - 10 = 30.
  reg [4:0] Body_increment;
  initial begin
  Body_increment <= SnakeStartValue;
  end
  
  always@(posedge CLK) begin
    if(RESET)
      Body_increment <= SnakeStartValue;  
    else if(Reached_Target) //increment body whenever a target is reached
        Body_increment <= Body_increment+1;           
     else 
        Body_increment <= Body_increment;
        end
    
endmodule
