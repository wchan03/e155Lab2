// Wava Chan 
// wchan@g.hmc.edu 
// Aug. 29, 2025 
// seg_disp determines which segments must be turned on for each hexidec digit

module seg_disp(input logic [3:0] s, 
				output logic [6:0] seg ); 
				
	logic [6:0] seg_intm;
	
	always_comb begin 
		// seg[0] is A 
		// seg[6] is G 
		case(s)
			4'b0000: seg_intm <= 7'b0111111; //0
			4'b0001: seg_intm <= 7'b0000110; //1 
			4'b0010: seg_intm <= 7'b1011011; //2 
			4'b0011: seg_intm <= 7'b1001111; //3 
			4'b0100: seg_intm <= 7'b1100110; //4 
			4'b0101: seg_intm <= 7'b1101101; //5 
			4'b0110: seg_intm <= 7'b1111101; //6 
			4'b0111: seg_intm <= 7'b0000111; //7 
			4'b1000: seg_intm <= 7'b1111111; //8 
			4'b1001: seg_intm <= 7'b1101111; //9 
			4'b1010: seg_intm <= 7'b1110111; //A 
			4'b1011: seg_intm <= 7'b1111100; //B 
			4'b1100: seg_intm <= 7'b1011000; //C 
			4'b1101: seg_intm <= 7'b1011110; //D 
			4'b1110: seg_intm <= 7'b1111001; //E 
			4'b1111: seg_intm <= 7'b1110001; //F 
			default: seg_intm <= 7'b1111111;
		endcase 
		
		seg <= ~seg_intm; // Flip all bits to pull segments DOWN to turn them on 
	end
endmodule