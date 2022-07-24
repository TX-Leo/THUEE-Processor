///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: ControlHazard
// Function:
/////////////

`timescale 1ns / 1ps

module Control_Hazard
(
    input wire i_Jump,
    input wire i_no_branch,
    output wire o_IF_ID_Flush,
    output wire o_ID_EX_Flush
);

    assign o_IF_ID_Flush = i_Jump || !i_no_branch;
    assign o_ID_EX_Flush = !i_no_branch;

endmodule
