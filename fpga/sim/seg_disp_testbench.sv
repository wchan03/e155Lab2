// Wava Chan
// wchan@g.hmc.edu
// Sept. 5, 2025
// Testbench for the segment display module

module seg_disp_testbench();
	logic clk, reset;
	logic [3:0] s;
	logic [6:0] seg; 
	logic [6:0] expected;
	logic [31:0] vectornum, errors;
	logic [11:0] testvectors[10000:0];
	
	//Instantiate device under test
	seg_disp sd(s, seg); 
	
	// Generate clock 
	always 
		begin 
			clk = 1; #5; clk = 0; #5;
		end 
		
	initial
		begin
			$readmemb("seg_disp.tv", testvectors);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
		end
	
	//apply test vectors at rising of clock
	always @(posedge clk)
		begin
			#1; {s, expected} = testvectors[vectornum - 1]; // check previous output
		end
		
	//check results on falling edge of clock
	always @(negedge clk)
		if (~reset) begin //skip during reset
			if(seg != expected) begin
				//check result
				$display("error! inputs = %b", s);
				$display("outputs = %b (%b expected", seg, expected);
				errors = errors + 1;
			end 
			vectornum = vectornum + 1;
			if(testvectors[vectornum] === 8'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule