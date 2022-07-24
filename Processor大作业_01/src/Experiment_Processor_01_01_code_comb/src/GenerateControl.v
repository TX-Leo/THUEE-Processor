///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: src(src/constrain/sim)
// Module Name: GenerateControl
// Function:
//  (1) 输入六位控制信号M2M1M0m2m1m0
//  (2) 生成八位控制信号control
//////////////////////////////////////////////

`timescale 1ns/1ps
module GenerateControl (input [5:0] Mm,
                        output [7:0] control
                       );
    
    reg [7:0] control_temp = 8'b0;
    assign control = control_temp;
    
    always @(*) begin
        control_temp[0] <= (Mm[2:0] == 0 || Mm[5:3] == 0);
        control_temp[1] <= (Mm[2:1] == 0 || Mm[5:4] == 0) && Mm != 0;
        control_temp[2] <= (Mm[5:3] == 2 || Mm[2:0] == 2) || (Mm[5:4] == 0 && Mm[2:1] != 0) || (Mm[2:1] == 0 && Mm[5:4] != 0);
        control_temp[3] <= (Mm[5:3] == 3 || Mm[2:0] == 3 || Mm[5]^Mm[2] != 0);
        control_temp[4] <= (Mm[5:3] == 4 || Mm[2:0] == 4 || Mm[5]^Mm[2] != 0);
        control_temp[5] <= (Mm[5:3] == 5 || Mm[2:0] == 5) || ({Mm[5], Mm[3:2]} == 6 || {Mm[5], Mm[2], Mm[0]} == 3) || ({Mm[5:4], Mm[2]} == 6 || {Mm[5], Mm[2:1]} == 3);
        control_temp[6] <= ({Mm[5:4], Mm[2:1]} == 11 || {Mm[5:4], Mm[2:1]} == 14) || (Mm[5:3] == 6 || Mm[2:0] == 6) || ({Mm[5:4], Mm[2]} == 6 || {Mm[5], Mm[2:1]} == 3);
        control_temp[7] <= (Mm[5:3] == 7 || Mm[2:0] == 7);
    end

endmodule
