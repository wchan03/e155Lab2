// Wava Chan
// wchan@g.hmc.edu
// Sept. 8, 2025
// Testbench for the lab 2 demux module

module demux_testbench();
    logic clk, reset, select;
    logic [1:0] anode_out, anode_expected;
	logic [31:0] vectornum, errors;
	logic [2:0] testvectors[10000:0];
	
	// 0 selects switch 2, 1 selects switch 1
	//Instantiate device under test
	demux2_1 dut(select, anode_out); 
	
	// Generate clock 
	always 
		begin 
			clk = 1; #5; clk = 0; #5;
		end 
		
	initial
		begin
			$readmemb("demux.tv", testvectors);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
		end
	
	//apply test vectors at rising of clock
	always @(posedge clk)
		begin
			 #1;
			 {select, anode_out, anode_expected} = testvectors[vectornum];
			 #1; //TODO maybe change this
		end
		
	//check results on falling edge of clock
	always @(negedge clk)
		if (~reset) begin //skip during reset
			if(anode_out != anode_expected) begin
				//check result
				$display("error! inputs = %b", select);
				$display("outputs = %b (%b expected)", anode_out, anode_expected);
				errors = errors + 1;
			end 
			vectornum = vectornum + 1;
			if(testvectors[vectornum] === 3'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule