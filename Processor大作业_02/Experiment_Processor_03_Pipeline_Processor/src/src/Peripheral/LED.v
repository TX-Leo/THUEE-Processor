///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: LED(don't use this module)
// Function:
/////////////

`timescale 1ns / 1ps

module LED(reset,
            clk,
            i_data,
            o_data);
    
    input reset;
    input clk;
    input [31:0] i_data;
    output reg [7:0] o_data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_data <= 7'b0000000;
        end
        else begin
            o_data <= i_data[7:0];
        end
    end
    
endmodule
