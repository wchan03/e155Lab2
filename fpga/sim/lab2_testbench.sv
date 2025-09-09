//Wava Chan
//wchan@g.hmc.edu
//Sept. 7, 2025
//Overall testing of top-level module

`timescale 1ns/1ps

//`define ASSERT() assert else $error

module lab2_testbench();

    logic clk, reset;
    logic [3:0] switch1, switch2;
    logic [6:0] seg_out;
    logic [4:0] leds;
    logic [1:0] anodes;
 

    //Instantiate dut. Operates at 46.2Hz
    lab2_wc dut(switch1, switch2, seg_out, leds, anodes);

	// Generate clock 
	always 
		begin 
			clk = 1; #43290045; clk = 0; #43290045;
		end 
		
    initial begin
        dut.counter = 0;
        // check assertions
        switch1 = 4'b0101
        switch2 = 4'b1000
        //seg_out = 1110001, leds = 01111
        //check if only one or the other is high
        assert 
            property (@(posedge clk) anodes[0] |-> (anodes[1] == 0))
            else $error ("not toggling");
        $finish
    end


endmodule