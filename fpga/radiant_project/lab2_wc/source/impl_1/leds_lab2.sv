// Wava Chan
// wchan@g.hmc.edu
// Sept. 5, 2025
// Calculate sum of two switch values and write to LEDs

module leds_lab2(input logic [3:0] switch1, switch2, 
				output logic [4:0] leds);
	logic [4:0] total; // Values from two switches added together
	
	//Calculate total 
	assign total = switch1 + switch2; 
	
	// Assign LEDs appropriately
	assign leds = total;
				
endmodule