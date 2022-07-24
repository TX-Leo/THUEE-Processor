///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: RegTemp
// Function:
//  (1) update data according to reset signal
//////////////////////////////////////////////

`timescale 1ns / 1ps
module RegTemp(reset, clk, Data_i, Data_o);
    //Input Clock Signals
    input reset;
    input clk;
    //Input Data
    input [31:0] Data_i;
    //Output Data
    output reg [31:0] Data_o;
    
    always@(posedge reset or posedge clk) begin
        if (reset) begin
            Data_o <= 32'h00000000;
        end else begin
            Data_o <= Data_i;
        end
    end
endmodule
