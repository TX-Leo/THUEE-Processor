///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: src(src/constrain/sim)
// Module Name: Top
// Function:
//  (1) 输入32位数据和6为控制信号
//  (2) 经过八输入加法数输出结果result
//////////////////////////////////////////////

`timescale 1ns/1ps
module Top (input sysclk,
            input [31:0] data,
            input [5:0] Mm,
            output [7:0] result
           );

    wire [31:0] data_input;
    wire [6:0] data_output;
    wire [6:0] final_result;
    assign result = final_result | 8'b0;

    DFilpFlop #(32) d_filp_flop_1(.clk(sysclk), .data(data), .q(data_input));
    AdderTree adder_tree(.input_data(data_input), .Mm(Mm), .result(data_output));
    DFilpFlop #(7) d_filp_flop_2(.clk(sysclk), .data(data_output), .q(final_result));

endmodule