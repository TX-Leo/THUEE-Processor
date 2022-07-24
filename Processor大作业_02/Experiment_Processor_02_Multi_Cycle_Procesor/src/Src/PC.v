///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: PC
// Function:
//  (1) update PC according to PCWrite signal
//////////////////////////////////////////////

`timescale 1ns / 1ps
module PC(reset, clk, PCWrite, PC_i, PC_o);
    //Input Clock Signals
    input reset;             
    input clk;
    //Input Control Signals             
    input PCWrite;
    //Input PC             
    input [31:0] PC_i;
    //Output PC  
    output reg [31:0] PC_o; 


    always@(posedge reset or posedge clk)
    begin
        if(reset) begin
            PC_o <= 0;
        end else if (PCWrite) begin
            PC_o <= PC_i;
        end else begin
            PC_o <= PC_o;
        end
    end
endmodule