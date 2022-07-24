///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_temp
// Description: It's TX-Leo's Experiment_Processor_01_02
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
// Function:
//  (1) 输入32位数据为1 2 3 4 5 6 7 8
//  (2) M2M1M0m2m1m0 = 6'b001001
//  (3) M2M1M0m2m1m0 = 6'b010010
//  (4) M2M1M0m2m1m0 = 6'b110110
//  (5) M2M1M0m2m1m0 = 6'b001110
//  (6) M2M1M0m2m1m0 = 6'b000111
//  (7) M2M1M0m2m1m0 = 6'b110111
//  (8) M2M1M0m2m1m0 = 6'b110001
//  (9) M2M1M0m2m1m0 = 6'b111000
//  (10) M2M1M0m2m1m0 = 6'b111110
//////////////////////////////////////////////

`timescale 1ns/1ps
module TbTop ();
    reg sysclk;
    reg [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
    reg [5:0] Mm;
    wire [7:0] result;

    initial 
    begin
        forever 
        begin
            #(5)
            sysclk = ~sysclk;       
        end
    end

    Top top(.sysclk(sysclk), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .Mm(Mm), .result(result));

    initial 
    begin
        sysclk = 1;

        I0 = 1;
        I1 = 2;
        I2 = 3;
        I3 = 4;
        I4 = 5;
        I5 = 6;
        I6 = 7;
        I7 = 8;

        Mm = 6'b001001;

        #(100)
        Mm = 6'b010010;

        #(100)
        Mm = 6'b110110;

        #(100)
        Mm = 6'b001110;

        #(100)
        Mm = 6'b000111;

        #(100)
        Mm = 6'b110111;

        #(100)
        Mm = 6'b110001;

        #(100)
        Mm = 6'b111000;

        #(100)
        Mm = 6'b111110;

        #(100)
        $finish;
    end

endmodule 