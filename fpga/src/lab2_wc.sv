// Wava Chan
// wchan@g.hmc.edu
// Sept. 4, 2025
// Top Level Module for Lab 2: Mutiplexed 7-Seg Display
// This module TODO: FINISH THIS

module lab2_wc(//input logic clk, reset //TODO: is reset necessary?
                input logic [3:0] switch_1, switch_2, // Two DIP switches
                output logic [6:0] seg_out,
				output logic [4:0] leds, 
				output logic [2:0] anodes); // Writing to the anodes
				
				logic select; //0 for display 0, 1 for display 1
				logic [3:0] switch; // Selected switch data
				logic int_osc; // internal clock
                logic [19:0] counter;
			
				//Create clock 
				// Internal high-speed oscillator
				HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

				// Counter
				always_ff @(posedge int_osc) begin  
					counter <= counter + 19'd2; //operates at ~91.5Hz
				end
                // Google AI says the human eye can detect up to 80Hz of flickering so started there
				// Select is based on the clock, i think
				//TODO: select from strobe using counter?
                assign select = counter[19];
				
				
				// Select input
				mux2 (#4) in(switch1, switch2, select, switch); 

                // Segment Display Module
				seg_disp sd(switch, seg_out); // Calculate segments 
				
				// Select output 
				//write HIGH to common anode 1 or common anode 2, depending on select
				demux2_1 dm(select, anodes); 
				
				// LEDs calculation from switch 1 and switch 2 and LED assignment
				leds_lab2 sum(switch1, switch2, leds);


 endmodule 