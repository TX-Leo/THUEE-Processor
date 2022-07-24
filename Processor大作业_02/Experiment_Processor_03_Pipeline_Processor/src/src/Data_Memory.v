///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: DataMemory
// Function:
//  (1) update PC according to PCWrite signal
//////////////////////////////////////////////

`timescale 1ns / 1ps

module Data_Memory
(
    input wire clk,
    input wire reset,
    input wire [31:0] i_addr,
    input wire [31:0] i_WriteData,
    input wire i_MemRead,
    input wire i_MemWrite,
    output wire [31:0] o_ReadData,
    output reg [7:0] o_leds,
    output reg [3:0] o_an,
    output reg [7:0] o_bcd7
);

    parameter MEM_SIZE = 512;
    wire [29:0] word_i_addr;
    reg [31:0] data [MEM_SIZE - 1:0];
    assign word_i_addr = i_addr[31:2];
    assign o_ReadData = i_MemRead == 0 ? 0 :word_i_addr < MEM_SIZE ? data[word_i_addr] :word_i_addr == 30'b0100_0000_0000_0000_0000_0000_0000_11 ? {24'h0, o_leds} :word_i_addr == 30'b0100_0000_0000_0000_0000_0000_0001_00 ? {20'h0, o_an, o_bcd7} :0;
    integer j;

    initial begin
        o_leds <= 0;
        o_an <= 0;
        o_bcd7 <= 0;

        for (j = 0; j < MEM_SIZE; j = j + 1) begin
            data[j] <= 0;
        end
    end

    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_leds <= 0;
            o_an <= 0;
            o_bcd7 <= 0;

            for (i = 0; i < MEM_SIZE; i = i + 1) begin
                data[i] <= 0;
            end
        end
        else begin
            if (i_MemWrite) begin
                if (word_i_addr < MEM_SIZE) begin
                    data[word_i_addr] <= i_WriteData;
                end
                else begin
                    case (word_i_addr)
                    30'b0100_0000_0000_0000_0000_0000_0000_11: begin
                        o_leds <= i_WriteData[7:0];
                    end
                    30'b0100_0000_0000_0000_0000_0000_0001_00: begin
                        o_bcd7 <= i_WriteData[7:0];
                        o_an <= i_WriteData[11:8];
                    end
                    endcase
                end
            end
        end
    end

endmodule
