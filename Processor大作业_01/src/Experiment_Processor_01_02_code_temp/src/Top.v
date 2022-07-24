///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_temp
// Description: It's TX-Leo's Experiment_Processor_01_02
// File Type: src(src/constrain/sim)
// Module Name: Top
// Function:
//  (1) 输入32位数据I0-I7和6为控制信号Mm
//  (2) 经过八输入加法数输出结果result
//////////////////////////////////////////////

`timescale 1ns/1ps
module Top (input sysclk,
            input wire [3:0] I0, I1, I2, I3, I4, I5, I6, I7,
            input wire [5:0] Mm,
            output wire [7:0] result
           );

    wire [7:0] control;
    wire [63:0] data = {4'b0, I7, 4'b0, I6, 4'b0, I5, 4'b0, I4, 4'b0, I3, 4'b0, I2, 4'b0, I1, 4'b0, I0};
    
    GenerateControl generate_control(.M(Mm[5:3]),.m(Mm[2:0]),.control(control));
    Adder adder(.clk(sysclk),.data(data),.control(control),.result(result));

endmodule