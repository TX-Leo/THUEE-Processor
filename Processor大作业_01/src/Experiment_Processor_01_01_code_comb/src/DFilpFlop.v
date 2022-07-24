///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: src(src/constrain/sim)
// Module Name: DFilpFlop
// Function:
//  (1) realize DFF
//////////////////////////////////////////////

`timescale 1ns/1ps
module DFilpFlop #(parameter SIZE = 32)
                (input clk,
                 input [SIZE - 1:0] data,
                 output [SIZE - 1:0] q
                );

    reg [SIZE - 1:0] q;
    always @(posedge clk) begin
        q <= data;
    end
    
endmodule
