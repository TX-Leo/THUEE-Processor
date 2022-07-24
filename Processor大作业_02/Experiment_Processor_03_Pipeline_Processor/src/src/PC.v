///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: PC
// Function:
//  (1) update PC according to i_PCWrite signal
//////////////////////////////////////////////

`timescale 1ns / 1ps

module PC
(
    input wire clk,         //Input Clock Signals
    input wire reset,
    input wire i_PCWrite,     //Input Control Signals
    input wire [31:0] i_PC, //Input PC
    output reg [31:0] o_PC  //Output PC
);

    initial begin
        o_PC <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_PC <= 0;
        end
        else if (i_PCWrite) begin
                o_PC <= o_PC;
        end
        else begin
            o_PC <= i_PC;
        end
    end

endmodule
