#input buttons
set_property PACKAGE_PIN T17 [get_ports BTNR]
              set_property IOSTANDARD LVCMOS33 [get_ports BTNR]
set_property PACKAGE_PIN W19 [get_ports BTNL]
              set_property IOSTANDARD LVCMOS33 [get_ports BTNL]
set_property PACKAGE_PIN T18 [get_ports BTNU]
             set_property IOSTANDARD LVCMOS33 [get_ports BTNU]
set_property PACKAGE_PIN U17 [get_ports BTND]
             set_property IOSTANDARD LVCMOS33 [get_ports BTND]


             
#input CLOCK             
set_property PACKAGE_PIN W5 [get_ports CLK]
             set_property IOSTANDARD LVCMOS33 [get_ports CLK]                                    

#input RESET
set_property PACKAGE_PIN U18 [get_ports RESET]
             set_property IOSTANDARD LVCMOS33 [get_ports RESET]

              
#output seven seg display                         
set_property PACKAGE_PIN W7 [get_ports {HEX_OUT[0]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[0]}] 
set_property PACKAGE_PIN W6 [get_ports {HEX_OUT[1]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[1]}]
set_property PACKAGE_PIN U8 [get_ports {HEX_OUT[2]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[2]}]
set_property PACKAGE_PIN V8 [get_ports {HEX_OUT[3]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[3]}]
set_property PACKAGE_PIN U5 [get_ports {HEX_OUT[4]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[4]}]
set_property PACKAGE_PIN V5 [get_ports {HEX_OUT[5]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[5]}]
set_property PACKAGE_PIN U7 [get_ports {HEX_OUT[6]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[6]}] 
set_property PACKAGE_PIN V7 [get_ports {HEX_OUT[7]}]
               set_property IOSTANDARD LVCMOS33 [get_ports {HEX_OUT[7]}]              

#output selecting one of the 4 segments               
set_property PACKAGE_PIN U2 [get_ports {SEG_SELECT[0]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[0]}] 
set_property PACKAGE_PIN U4 [get_ports {SEG_SELECT[1]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[1]}]
set_property PACKAGE_PIN V4 [get_ports {SEG_SELECT[2]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[2]}]
set_property PACKAGE_PIN W4 [get_ports {SEG_SELECT[3]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[3]}]
                
                
                
#Vsync and Hsync 
set_property PACKAGE_PIN P19 [get_ports HS]
                set_property IOSTANDARD LVCMOS33 [get_ports HS]
set_property PACKAGE_PIN R19 [get_ports VS]
                set_property IOSTANDARD LVCMOS33 [get_ports VS]
                             
#VGA Colour Output
set_property PACKAGE_PIN G19 [get_ports {COLOUR_OUT[0]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[0]}]
set_property PACKAGE_PIN H19 [get_ports {COLOUR_OUT[1]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[1]}]
set_property PACKAGE_PIN J19 [get_ports {COLOUR_OUT[2]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[2]}]
set_property PACKAGE_PIN N19 [get_ports {COLOUR_OUT[3]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[3]}]
set_property PACKAGE_PIN J17 [get_ports {COLOUR_OUT[4]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[4]}]
set_property PACKAGE_PIN H17 [get_ports {COLOUR_OUT[5]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[5]}]
set_property PACKAGE_PIN G17 [get_ports {COLOUR_OUT[6]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[6]}]
set_property PACKAGE_PIN D17 [get_ports {COLOUR_OUT[7]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[7]}]
set_property PACKAGE_PIN N18 [get_ports {COLOUR_OUT[8]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[8]}]
set_property PACKAGE_PIN L18 [get_ports {COLOUR_OUT[9]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[9]}]
set_property PACKAGE_PIN K18 [get_ports {COLOUR_OUT[10]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[10]}]
set_property PACKAGE_PIN J18 [get_ports {COLOUR_OUT[11]}]
                set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[11]}]
                
#LEDs
set_property PACKAGE_PIN U16 [get_ports {LED_OUT[0]}]
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED_OUT[1]}]
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED_OUT[2]}]
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED_OUT[3]}]
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[3]}]      
