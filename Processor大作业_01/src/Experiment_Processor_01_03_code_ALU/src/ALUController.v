///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_ALU
// Description: It's TX-Leo's Experiment_Processor_01_03
// File Type: src(src/constrain/sim)
// Module Name: ALUController
// Function:
//  (1) 输入OpCode和Funct字段
//  (2) 输出ALUCtrl控制信号和Sign（1-有符号计算，0-无符号计算）
//////////////////////////////////////////////

`timescale 1ns/1ps
module ALUController (input [5:0] OpCode,
                      input [5:0] Funct,
                      output [4:0] ALUCtrl,
                      output Sign
                     );

    reg [4:0] ALUCtrl_temp;
    reg Sign_temp;
    assign ALUALUCtrl_temp = ALUCtrl_temp;
    assign Sign = Sign_temp;

    always @(*) begin
        case (OpCode)
            0:
            begin
                case (Funct)
                    32:{Sign_temp, ALUCtrl_temp} <= 6'b100000;   // signed-add
                    33:{Sign_temp, ALUCtrl_temp} <= 6'b000000;   // unsigned-add
                    34:{Sign_temp, ALUCtrl_temp} <= 6'b100001;   // signed-sub
                    35:{Sign_temp, ALUCtrl_temp} <= 6'b000001;   // unsigned-sub
                    36:{Sign_temp, ALUCtrl_temp} <= 6'b100010;   // andi
                    37:{Sign_temp, ALUCtrl_temp} <= 6'b100011;   // or
                    38:{Sign_temp, ALUCtrl_temp} <= 6'b100100;   // xor
                    39:{Sign_temp, ALUCtrl_temp} <= 6'b100101;   // nor
                    0:{Sign_temp, ALUCtrl_temp}  <= 6'b100110;   // sll
                    2:{Sign_temp, ALUCtrl_temp}  <= 6'b100111;   // srl
                    3:{Sign_temp, ALUCtrl_temp}  <= 6'b101000;   // sra
                    42:{Sign_temp, ALUCtrl_temp} <= 6'b101001;   // slt
                    43:{Sign_temp, ALUCtrl_temp} <= 6'b001001;   // sltu
                endcase
            end
            35:{Sign_temp, ALUCtrl_temp} <= 6'b100000;           // lw(signed-add)
            43:{Sign_temp, ALUCtrl_temp} <= 6'b100000;           // sw(signed-add)
            15:{Sign_temp, ALUCtrl_temp} <= 6'b101010;           // lui
            8:{Sign_temp, ALUCtrl_temp}  <= 6'b100000;           // addi
            9:{Sign_temp, ALUCtrl_temp}  <= 6'b000000;           // addiu
            12:{Sign_temp, ALUCtrl_temp} <= 6'b000010;           // andi
            10:{Sign_temp, ALUCtrl_temp} <= 6'b101001;           // slti
            11:{Sign_temp, ALUCtrl_temp} <= 6'b001001;           // sltiu
            4:{Sign_temp, ALUCtrl_temp}  <= 6'b100001;            // beq
        endcase
    end

endmodule 
