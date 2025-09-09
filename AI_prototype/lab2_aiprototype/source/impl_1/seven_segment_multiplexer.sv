module seven_segment_multiplexer (
    input logic clk,
    input logic rst,
    input logic [3:0] in0,
    input logic [3:0] in1,
    output logic [6:0] seg0,
    output logic [6:0] seg1
);

    // Internal signals
    logic [3:0] current_input;
    logic [6:0] decoded_output;
    logic toggle;

    // Toggle between inputs every clock cycle
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            toggle <= 0;
        else
            toggle <= ~toggle;
    end

    // Select input based on toggle
    always_comb begin
        current_input = toggle ? in1 : in0;
    end

    // Instantiate decoder
    seven_segment_decoder decoder_inst (
        .bin(current_input),
        .seg(decoded_output)
    );

    // Store decoded output into appropriate register
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            seg0 <= 7'b1111111;
            seg1 <= 7'b1111111;
        end else begin
            if (toggle)
                seg1 <= decoded_output;
            else
                seg0 <= decoded_output;
        end
    end

endmodule

// 4-bit to 7-segment decoder (common anode)
module seven_segment_decoder (
    input logic [3:0] bin,
    output logic [6:0] seg
);
    always_comb begin
        case (bin)
            4'h0: seg = 7'b0000001;
            4'h1: seg = 7'b1001111;
            4'h2: seg = 7'b0010010;
            4'h3: seg = 7'b0000110;
            4'h4: seg = 7'b1001100;
            4'h5: seg = 7'b0100100;
            4'h6: seg = 7'b0100000;
            4'h7: seg = 7'b0001111;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0000100;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b1100000;
            4'hC: seg = 7'b0110001;
            4'hD: seg = 7'b1000010;
            4'hE: seg = 7'b0110000;
            4'hF: seg = 7'b0111000;
            default: seg = 7'b1111111; // All segments off
        endcase
    end
endmodule