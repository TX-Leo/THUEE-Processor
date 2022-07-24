///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: ALU
// Function:
//  (1) Arithmetic and Logic Unit that supports algorithms such as addition and subtraction
//////////////////////////////////////////////

`timescale 1ns / 1ps
module ALU(ALUConf, Sign, In1, In2, Zero, Result);
    // Control Signals
    input [4:0] ALUConf;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // Output 
    output Zero;
    output reg [31:0] Result;

    reg zero_temp;
    assign Zero = zero_temp;

        always @(*) begin
            case (ALUConf)
                2:Result <= In1+In2;
                6:Result <= In1-In2;
                0:Result <= In1&In2;
                1:Result <= In1|In2;
                9:Result <= In1^In2;
                8:Result <= ~(In1|In2);
                10:Result <= In2 << In1;
                16:Result <= In2 >> In1;
                17:Result <= $signed(In2) >>> (In1);
                7:begin
                    if (Sign) Result <= ($signed(In1) < $signed(In2));
                    else Result <= (In1 < In2);
                end
            endcase
            zero_temp <= (Result == 0);
        end

endmodule
