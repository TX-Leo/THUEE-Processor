///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: BCD7
// Function:
/////////////

`timescale 1ns / 1ps

module BCD7(reset,
            clk,
            i_data,
            o_data);
    
    input reset;
    input clk;
    input [31:0] i_data;
    output reg [11:0] o_data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_data <= 12'b111111111111;
        end
        else begin
            o_data <= i_data[11:0];
        end
    end
    
endmodule
