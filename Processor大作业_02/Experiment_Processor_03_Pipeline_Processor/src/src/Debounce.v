///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: debounce
// Function:
/////////////

`timescale 1ns / 1ps

module Debounce
(
        input clk,
        input key_i,
        output key_o
);

    parameter NUMBER = 24'd10_000_000;
    parameter NBITS = 24;

    reg [NBITS-1:0] count;
    reg key_o_temp;

    reg key_m;
	reg key_i_t1,key_i_t2;

    assign key_o = key_o_temp;

	always @ (posedge clk) begin
		key_i_t1 <= key_i;
		key_i_t2 <= key_i_t1;
	end

    always @ (posedge clk) begin
        if (key_m!=key_i_t2) begin
            key_m <= key_i_t2;
            count <= 0;
        end
        else if (count == NUMBER) begin
            key_o_temp <= key_m;
        end
        else count <= count+1;
    end
endmodule
