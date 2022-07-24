///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_temp
// Description: It's TX-Leo's Experiment_Processor_01_02
// File Type: src(src/constrain/sim)
// Module Name: Adder
// Function:
//  (1) 输入data和八位控制信号control
//  (2) 输出加法器的结果result
//////////////////////////////////////////////

`timescale 1ns/1ps
module Adder (input clk,
              input wire [63:0] data,
              input wire [7:0] control,
              output wire [7:0] result
             );

    reg [7:0] result_temp = 8'b0;
    assign result = result_temp;
    reg flag = 1'b1; // the flag of continue adding
    integer digit = 0; //the number of digits being added

    always @(control)
    begin
        flag <= 1'b1;
    end

    always @(posedge clk) 
    begin
        if (flag) 
        begin          
            case (digit) //choose which digit
                0:
                begin
                    if (control[0])
                        result_temp <= result_temp + data[7:0];
                end
                1:
                begin
                    if (control[1])
                        result_temp <= result_temp + data[15:8];
                end
                2:
                begin
                    if (control[2])
                        result_temp <= result_temp + data[23:16];
                end
                3:
                begin
                    if (control[3])
                        result_temp <= result_temp + data[31:24];
                end
                4:
                begin
                    if (control[4])
                        result_temp <= result_temp + data[39:32];
                end
                5:
                begin
                    if (control[5])
                        result_temp <= result_temp + data[47:40];
                end
                6:
                begin
                    if (control[6])
                        result_temp <= result_temp + data[55:48];
                end
                7:
                begin
                    if (control[7])
                        result_temp <= result_temp + data[63:56];
                end
            endcase
            if (digit == 8) //the end of adding
            begin         
                digit <= 0;
                result_temp <= 0;
                flag <= 0;
            end
            else //continue the next digit
            begin
                digit = digit + 1;   
            end
        end
    end

endmodule 
