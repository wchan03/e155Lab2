//Wava Chan
//wchan@g.hmc.edu
//Sept. 7, 2025
//Overall testing of top-level module

`timescale 1ns/1ps

//`define ASSERT() assert else $error

module lab2_testbench();'

    logic clk, reset;
    logic [3:0] switch1, switch2;
    logic [6:0] seg_out;
    logic [4:0] leds;
    logic [1:0] anodes;
 

    //Instantiate dut. Operates at 46.2Hz
    lab2_wc dut(switch1, switch2, seg_out, leds, anodes);

    // check assertions
    // switch 1 = 0101, switch 2 = 1000, seg_out
    //check if only one or the other is high
    assert 
        property ((@posedge clk) anodes[0] |-> (anodes[1] == 0))
        else $error ("not toggling");


endmodule