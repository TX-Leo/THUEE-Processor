///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: src(src/constrain/sim)
// Module Name: BitAdder
// Function:
//  (1) 实现4bit加法，5bit加法，6bit加法
//////////////////////////////////////////////

`timescale 1ns/1ps
module BitAdder #(parameter SIZE = 4)
                (input [SIZE - 1:0] a,
                 input [SIZE - 1:0] b,
                 output [SIZE:0] result
                );
    
    wire carry_bit;
    wire [SIZE - 1:0] sum;
    assign {carry_bit,sum} = a + b;
    assign result = {carry_bit, sum};

endmodule
