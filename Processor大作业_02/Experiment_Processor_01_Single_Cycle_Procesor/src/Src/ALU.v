///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: src(src/constrain/sim)
// Module Name: ALU
// Function:
//  (1) Arithmetic and Logic Unit that supports algorithms such as addition and subtraction
//////////////////////////////////////////////

module ALU(in1, in2, ALUCtrl, Sign, out, zero);
	input [31:0] in1, in2;
	input [4:0] ALUCtrl;
	input Sign;
	output [31:0] out;
	output zero;
	
    reg [31:0] out_temp;
    reg zero_temp;
    assign out  = out_temp;
    assign zero = zero_temp;
    //algorithms
    always @(*) begin
        case (ALUCtrl)
            0:out_temp <= in1+in2;
            1:out_temp <= in1-in2;
            2:out_temp <= in1&in2;
            3:out_temp <= in1|in2;
            4:out_temp <= in1^in2;
            5:out_temp <= ~(in1|in2);
            6:out_temp <= in2 << in1;
            7:out_temp <= in2 >> in1;
            8:out_temp <= $signed(in2) >>> (in1);
            9:begin
                if (Sign) out_temp <= ($signed(in1) < $signed(in2));
                else out_temp <= (in1 < in2);
            end
            10:out_temp <= in1 << 16;
        endcase
        zero_temp <= (out_temp == 0);
    end
	
endmodule