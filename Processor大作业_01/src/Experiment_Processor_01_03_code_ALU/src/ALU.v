///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_ALU
// Description: It's TX-Leo's Experiment_Processor_01_03
// File Type: src(src/constrain/sim)
// Module Name: ALU
// Function:
//  (1) 输入ALUCtrl控制信号和Sign（1-有符号计算，0-无符号计算）
//  (2) 输入数据in1 in2
//  (3) 输出数据out zero(1-输出out为0 0-输出out不为0)
//////////////////////////////////////////////

`timescale 1ns/1ps
module ALU (input [4:0] ALUCtrl,
            input Sign,
            input [31:0] in1,
            input [31:0] in2,
            output [31:0] out,
            output zero
           );

    reg [31:0] out_temp;
    reg zero_temp;
    assign out  = out_temp;
    assign zero = zero_temp;

    always @(*) 
    begin
        case (ALUCtrl)
            0:out_temp <= in1+in2;
            1:out_temp <= in1-in2;
            2:out_temp <= in1&in2;
            3:out_temp <= in1|in2;
            4:out_temp <= in1^in2;
            5:out_temp <= ~(in1|in2);
            6:out_temp <= in1 << (in2[10:6]);
            7:out_temp <= in1 >> (in2[10:6]);
            8:out_temp <= $signed(in1) >>> (in2[10:6]);
            9:out_temp <= (in1 < in2);
            10:out_temp <= in1 << 16;
        endcase
        zero_temp <= (out_temp == 0);
    end

endmodule 
