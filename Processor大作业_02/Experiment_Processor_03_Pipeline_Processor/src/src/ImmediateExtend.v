///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: ImmediateExtend
// Function:
//  (1)
//////////////////////////////////////////////

`timescale 1ns / 1ps

module ImmediateExtend
(
    input wire [15:0] i_in,       //Input data
    input wire i_LuiOp,           //
    input wire i_SignedOp,
    output wire [31:0] o_out_ext  //Output data
);

    assign o_out_ext = i_LuiOp ? {i_in, 16'h0} :i_SignedOp ? {{16{i_in[15]}}, i_in} :{16'h0, i_in};

endmodule
