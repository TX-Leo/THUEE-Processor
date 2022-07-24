///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: src(src/constrain/sim)
// Module Name: AdderTree
// Function:
//  (1) 确定每个输入MUX的控制信号
//  (2) 第一级：实现4个4bit加法
//  (3) 第二级：实现2个5bit加法
//  (4) 第四级：实现1个6bit加法
//////////////////////////////////////////////

`timescale 1ns/1ps
module AdderTree (input [31:0] input_data,
                  input [5:0] Mm,
                  output [6:0] result
                 );

    wire [4:0] result_4bit_1;
    wire [4:0] result_4bit_2;
    wire [4:0] result_4bit_3;
    wire [4:0] result_4bit_4;
    wire [5:0] result_5bit_1;
    wire [5:0] result_5bit_2;
    wire [7:0] control;

    //generate control signal
    GenerateControl generate_control(.Mm(Mm), .control(control));
    //4bit adder
    BitAdder #(4) bit_adder_4bit_1(.a(control[0] ? input_data[3:0]:4'b0),  .b(control[1] ? input_data[7:4]:4'b0),   .result(result_4bit_1));
    BitAdder #(4) bit_adder_4bit_2(.a(control[2] ? input_data[11:8]:4'b0), .b(control[3] ? input_data[15:12]:4'b0), .result(result_4bit_2));
    BitAdder #(4) bit_adder_4bit_3(.a(control[4] ? input_data[19:16]:4'b0),.b(control[5] ? input_data[23:20]:4'b0), .result(result_4bit_3));
    BitAdder #(4) bit_adder_4bit_4(.a(control[6] ? input_data[27:24]:4'b0),.b(control[7] ? input_data[31:28]:4'b0), .result(result_4bit_4)); 
    //5bit adder
    BitAdder #(5) bit_adder_5bit_1(.a(result_4bit_1),.b(result_4bit_2),.result(result_5bit_1));
    BitAdder #(5) bit_adder_5bit_2(.a(result_4bit_3),.b(result_4bit_4),.result(result_5bit_2));
    //6bit adder
    BitAdder #(6) bit_adder_6bit_1(.a(result_5bit_1),.b(result_5bit_2),.result(result));      

endmodule