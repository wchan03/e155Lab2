// Wava Chan
// wchan@g.hmc.edu
// Sept. 5, 2025
// Calculate sum of two switch values and write to LEDs

module leds_lab2(input logic [3:0] switch1, switch2, 
				output logic [4:0] leds);
	logic [4:0] total; // Values from two switches added together
	
	//Calculate total 
	assign total = switch1 + switch2; //TODO: does this work?
	
	// Assign LEDs appropriatley 
	//TODO: double-check endiannesss
	assign leds[0] = total[0];
	assign leds[1] = total[1];
	assign leds[2] = total[2];
	assign leds[3] = total[3];
	assign leds[4] = total[4];
				
endmodule