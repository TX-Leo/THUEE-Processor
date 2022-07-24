///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_temp
// Description: It's TX-Leo's Experiment_Processor_01_02
// File Type: src(src/constrain/sim)
// Module Name: GenerateControl
// Function:
//  (1) 输入六位控制信号Mm
//  (2) 输出8位控制信号control
//////////////////////////////////////////////

`timescale 1ns/1ps
module GenerateControl (input [2:0] M,
                        input [2:0] m, 
                        output [7:0] control
                       );

    assign max = (M > m) ? M : m;
    assign min = (M > m) ? M : m;

    wire [7:0] temp1;
    wire [7:0] temp2 ;

    assign temp1[0] = 1;
    assign temp1[1] = max > 0;
    assign temp1[2] = max > 1;
    assign temp1[3] = max > 2;
    assign temp1[4] = max > 3;
    assign temp1[5] = max > 4;
    assign temp1[6] = max > 5;
    assign temp1[7] = max > 6;

    assign temp2[0] = 1;
    assign temp2[1] = max > 0;
    assign temp2[2] = max > 1;
    assign temp2[3] = max > 2;
    assign temp2[4] = max > 3;
    assign temp2[5] = max > 4;
    assign temp2[6] = max > 5;
    assign temp2[7] = max > 6;

    assign control = temp1 ^ (temp2 >> 1);

endmodule