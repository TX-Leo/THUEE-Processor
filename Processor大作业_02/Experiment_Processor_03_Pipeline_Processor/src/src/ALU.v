///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: ALU
// Function:
//  (1) Arithmetic and Logic Unit that supports algorithms such as addition and subtraction
//      add
//      sub
//      and
//      or
//      xor
//      nor
//      unsigned cmp
//      signed cmp
//      sll
//      srl
//      sra
//      gtz, greater than o_zero
//////////////////////////////////////////////

`timescale 1ns / 1ps

module ALU
(
    input wire [31:0] i_In1,   // Input Data Signals
    input wire [31:0] i_In2,
    input wire [3:0] i_ALUOp,  // Control Signals
    output reg [31:0] o_Result,// Output
    output wire o_Zero
);
    assign o_Zero = o_Result == 0;

    always @(*) begin
        case (i_ALUOp)
            4'h0      : o_Result <= i_In1 + i_In2;
            4'h1      : o_Result <= i_In1 - i_In2;
            4'h3      : o_Result <= i_In1 & i_In2;
            4'h4      : o_Result <= i_In1 | i_In2;
            4'h5      : o_Result <= i_In1 ^ i_In2;
            4'h6      : o_Result <= ~(i_In1 | i_In2);
            4'h7      : o_Result <= i_In1 < i_In2;
            4'h8      : o_Result <= (i_In1[31] == i_In2[31] ? (i_In1[30:0] < i_In2[30:0]) : i_In1[31] ? 1 : 0);
            4'h9      : o_Result <= (i_In2 << i_In1[4:0]);
            4'hA      : o_Result <= (i_In2 >> i_In1[4:0]);
            4'hB      : o_Result <= ({{2{i_In2[31]}}, i_In2} >> i_In1[4:0]);
            4'hC      : o_Result <= (i_In1[31] == 0 && i_In1 != 0);
            default   : o_Result <= 0;
        endcase
    end

endmodule
