// Wava Chan
// wchan@g.hmc.edu
// Sept. 5, 2025
// Testbench for the lab 2 LED calculation module

module leds_testbench();
	logic clk, reset;
	logic [3:0] switch1, switch2;
	logic [4:0] leds, leds_expected;
	logic [31:0] vectornum, errors;
	logic [12:0] testvectors[10000:0];
	
	//Instantiate device under test
	leds_lab2 dut(switch1, switch2, leds); 
	
	// Generate clock 
	always 
		begin 
			clk = 1; #5; clk = 0; #5;
		end 
		
	initial
		begin
			$readmemb("leds.tv", testvectors);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
		end
	
	//apply test vectors at rising of clock
	always @(posedge clk)
		begin
			 #1;
			 {switch1, switch2, leds_expected} = testvectors[vectornum];
			 #1; //TODO maybe change this
		end
		
	//check results on falling edge of clock
	always @(negedge clk)
		if (~reset) begin //skip during reset
			if(leds != leds_expected) begin
				//check result
				$display("error! inputs = %b, %b", switch1, switch2);
				$display("outputs = %b (%b expected", leds, leds_expected);
				errors = errors + 1;
			end 
			vectornum = vectornum + 1;
			if(testvectors[vectornum] === 13'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule