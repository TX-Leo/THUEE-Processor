///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_comb
// Description: It's TX-Leo's Experiment_Processor_01_01
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
// Function:
//  (1) M2M1M0 = m2m1m0 的情况
//  (2) M2M1M0 > m2m1m0 的情况
//  (3) M2M1M0 < m2m1m0 的情况
//////////////////////////////////////////////

`timescale 1ns/1ps
module TbTop ();
    reg sysclk = 0;
    reg [31:0] data;
    reg [5:0] Mm;
    wire [7:0] result;

    initial begin
        forever begin
            #(5)
            sysclk = ~sysclk;
        end
    end

    Top top(.sysclk(sysclk), .data(data), .Mm(Mm), .result(result));

    initial begin
        sysclk = 1;
        data = 32'b0111_0110_0101_0100_0011_0010_0001_0000;
        Mm = 6'b0;
        
        #(25)
        Mm = 6'b001001;     
        #(10)
        Mm = 6'b011011;  
        #(10)
        Mm = 6'b101101;     // 前后相等的情况

        #(10)
        Mm = 6'b111000;
        #(10)
        Mm = 6'b110001;
        #(10)
        Mm = 6'b101010;     // 前大于后的情况

        #(10)
        Mm = 6'b000111;
        #(10)
        Mm = 6'b001110;
        #(10)
        Mm = 6'b010101;     // 后大于前的情况

        #(20)
        $finish;
    end

endmodule