///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: RegisterFile
// Function:
//  (1) generate Register File which can write and read
//////////////////////////////////////////////

`timescale 1ns / 1ps

module RegisterFile
(
    input wire clk,                    //Input Clock Signals
    input wire reset,
    input wire i_RegWrite,               //Input Control Signals
    input wire [4:0] i_Read_register1,   //Input RF_data Signals
    input wire [4:0] i_Read_register2,
    input wire [4:0] i_Write_register,
    input wire [31:0] i_Write_data,
    output wire [31:0] o_Read_data1,     //Output RF_data Signals
    output wire [31:0] o_Read_data2
);



    reg [31:0] RF_data [31:1];
    //read data
    assign o_Read_data1 =i_Read_register1 == 0 ? 32'h0 :i_RegWrite && i_Write_register == i_Read_register1 ? i_Write_data :RF_data[i_Read_register1];
    assign o_Read_data2 =i_Read_register2 == 0 ? 32'h0 :i_RegWrite && i_Write_register == i_Read_register2 ? i_Write_data :RF_data[i_Read_register2];

    integer j;
    initial begin
        for (j = 1; j < 29; j = j + 1) begin
            RF_data[j] <= 0;
        end
        RF_data[29] <= 32'h000007fc;   // $sp
        for (j = 30; j < 32; j = j + 1) begin
            RF_data[j] <= 0;
        end
    end
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 1; i < 29; i = i + 1) begin
                RF_data[i] <= 0;
            end
            RF_data[29] <= 32'h000007fc;   // $sp
            for (i = 30; i < 32; i = i + 1) begin
                RF_data[i] <= 0;
            end
        end
        else begin
            if (i_RegWrite && i_Write_register != 0) begin
                RF_data[i_Write_register] <= i_Write_data;
            end
        end
    end

endmodule
