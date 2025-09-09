// Wava Chan
// wchan@g.hmc.edu
// Sept. 5, 2025
// Testbench for the lab 2 mux module

module mux2_testbench();
    logic clk, reset, select;
	logic [3:0] switch1, switch2;
    logic [3:0] switch_out, switch_expected;
	logic [31:0] vectornum, errors;
	logic [12:0] testvectors[10000:0];
	
	// 0 selects switch 2, 1 selects switch 1
	//Instantiate device under test
	mux2 dut(switch1, switch2, select, switch_out); 
	
	// Generate clock 
	always 
		begin 
			clk = 1; #5; clk = 0; #5;
		end 
		
	initial
		begin
			$readmemb("mux.tv", testvectors);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
		end
	
	//apply test vectors at rising of clock
	always @(posedge clk)
		begin
			 #1;
			 {switch1, switch2, select, switch_expected} = testvectors[vectornum];
			 #1; //TODO maybe change this
		end
		
	//check results on falling edge of clock
	always @(negedge clk)
		if (~reset) begin //skip during reset
			if(switch_out != switch_expected) begin
				//check result
				$display("error! inputs = %b, %b, %b", switch1, switch2, select);
				$display("outputs = %b (%b expected)", switch_out, switch_expected);
				errors = errors + 1;
			end 
			vectornum = vectornum + 1;
			if(testvectors[vectornum] === 13'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule