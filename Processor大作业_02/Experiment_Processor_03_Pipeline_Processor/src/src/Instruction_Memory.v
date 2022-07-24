///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: InstructionMemory
// Function:
//  (1) generate data memory which can write and read
//  (2) instruction Fetch
//  (3) MIPS Assembly:Src/asm/string_matching.asm
//////////////////////////////////////////////

`timescale 1ns / 1ps

module Instruction_Memory
(
    input wire [31:0] i_address, //Input Control Signals
    output wire [31:0] o_instruction //Output Data
);

    parameter MEM_SIZE = 512;
    reg [31:0] data [MEM_SIZE:0];

    assign o_instruction = data[i_address[10:2]];
    integer i;
    initial begin;
        data[9'h0] <= 32'h20100000;
        data[9'h1] <= 32'h20050000;
        data[9'h2] <= 32'h20060001;
        data[9'h3] <= 32'h8ca80000;
        data[9'h4] <= 32'h2009000a;
        data[9'h5] <= 32'h11090003;
        data[9'h6] <= 32'h20a50004;
        data[9'h7] <= 32'h22100001;
        data[9'h8] <= 32'h08000003;
        data[9'h9] <= 32'h20b20000;
        data[9'hA] <= 32'h20060001;
        data[9'hB] <= 32'h20110000;
        data[9'hC] <= 32'h8ca80000;
        data[9'hD] <= 32'h2009000a;
        data[9'hE] <= 32'h11090003;
        data[9'hF] <= 32'h20a50004;
        data[9'h10] <= 32'h22310001;
        data[9'h11] <= 32'h0800000c;
        data[9'h12] <= 32'h22040000;
        data[9'h13] <= 32'h20050000;
        data[9'h14] <= 32'h22260000;
        data[9'h15] <= 32'h00123820;
        data[9'h16] <= 32'h0c00003d;
        data[9'h17] <= 32'h20500000;
        data[9'h18] <= 32'h00108f00;
        data[9'h19] <= 32'h00118f02;
        data[9'h1A] <= 32'h00109600;
        data[9'h1B] <= 32'h00129702;
        data[9'h1C] <= 32'h00109d00;
        data[9'h1D] <= 32'h00139f02;
        data[9'h1E] <= 32'h0010a400;
        data[9'h1F] <= 32'h0014a702;
        data[9'h20] <= 32'h3c164000;
        data[9'h21] <= 32'h20160014;
        data[9'h22] <= 32'h20082710;
        data[9'h23] <= 32'h20094e20;
        data[9'h24] <= 32'h200a7530;
        data[9'h25] <= 32'h22240000;
        data[9'h26] <= 32'h0c00009d;
        data[9'h27] <= 32'h8ed70000;
        data[9'h28] <= 32'h02e8b822;
        data[9'h29] <= 32'h1ee00001;
        data[9'h2A] <= 32'h08000025;
        data[9'h2B] <= 32'h22440000;
        data[9'h2C] <= 32'h0c00009d;
        data[9'h2D] <= 32'h8ed70000;
        data[9'h2E] <= 32'h02e9b822;
        data[9'h2F] <= 32'h1ee00001;
        data[9'h30] <= 32'h0800002b;
        data[9'h31] <= 32'h22640000;
        data[9'h32] <= 32'h0c00009d;
        data[9'h33] <= 32'h8ed70000;
        data[9'h34] <= 32'h02eab822;
        data[9'h35] <= 32'h1ee00001;
        data[9'h36] <= 32'h08000031;
        data[9'h37] <= 32'h22840000;
        data[9'h38] <= 32'h0c00009d;
        data[9'h39] <= 32'h8ed70000;
        data[9'h3A] <= 32'h02e8b822;
        data[9'h3B] <= 32'h06e0ffe9;
        data[9'h3C] <= 32'h08000037;
        data[9'h3D] <= 32'h23bdfffc;
        data[9'h3E] <= 32'hafbf0000;
        data[9'h3F] <= 32'h20940000;
        data[9'h40] <= 32'h20d50000;
        data[9'h41] <= 32'h20b60000;
        data[9'h42] <= 32'h20f70000;
        data[9'h43] <= 32'h20100300;
        data[9'h44] <= 32'h22040000;
        data[9'h45] <= 32'h20c50000;
        data[9'h46] <= 32'h20e60000;
        data[9'h47] <= 32'h0c00006c;
        data[9'h48] <= 32'h20100000;
        data[9'h49] <= 32'h20110000;
        data[9'h4A] <= 32'h20120000;
        data[9'h4B] <= 32'h1214001c;
        data[9'h4C] <= 32'h00104080;
        data[9'h4D] <= 32'h00114880;
        data[9'h4E] <= 32'h02e96020;
        data[9'h4F] <= 32'h02c86820;
        data[9'h50] <= 32'h8d8e0000;
        data[9'h51] <= 32'h8daf0000;
        data[9'h52] <= 32'h15cf000c;
        data[9'h53] <= 32'h22abffff;
        data[9'h54] <= 32'h162b0007;
        data[9'h55] <= 32'h22520001;
        data[9'h56] <= 32'h22b8ffff;
        data[9'h57] <= 32'h0018c080;
        data[9'h58] <= 32'h0313c020;
        data[9'h59] <= 32'h8f110000;
        data[9'h5A] <= 32'h22100001;
        data[9'h5B] <= 32'h08000067;
        data[9'h5C] <= 32'h22310001;
        data[9'h5D] <= 32'h22100001;
        data[9'h5E] <= 32'h08000067;
        data[9'h5F] <= 32'h0011c82a;
        data[9'h60] <= 32'h13200005;
        data[9'h61] <= 32'h2238ffff;
        data[9'h62] <= 32'h0018c080;
        data[9'h63] <= 32'h0313c020;
        data[9'h64] <= 32'h8f110000;
        data[9'h65] <= 32'h08000067;
        data[9'h66] <= 32'h22100001;
        data[9'h67] <= 32'h0800004b;
        data[9'h68] <= 32'h22420000;
        data[9'h69] <= 32'h8fbf0000;
        data[9'h6A] <= 32'h23bd0004;
        data[9'h6B] <= 32'h03e00008;
        data[9'h6C] <= 32'h23bdfff4;
        data[9'h6D] <= 32'hafb00008;
        data[9'h6E] <= 32'hafb10004;
        data[9'h6F] <= 32'hafb20000;
        data[9'h70] <= 32'h20110001;
        data[9'h71] <= 32'h20120000;
        data[9'h72] <= 32'h20010000;
        data[9'h73] <= 32'h1025001d;
        data[9'h74] <= 32'h20d00000;
        data[9'h75] <= 32'h20930000;
        data[9'h76] <= 32'hae600000;
        data[9'h77] <= 32'h1225001f;
        data[9'h78] <= 32'h00115080;
        data[9'h79] <= 32'h00124080;
        data[9'h7A] <= 32'h020a6020;
        data[9'h7B] <= 32'h02086820;
        data[9'h7C] <= 32'h8d8c0000;
        data[9'h7D] <= 32'h8dad0000;
        data[9'h7E] <= 32'h158d0006;
        data[9'h7F] <= 32'h22480001;
        data[9'h80] <= 32'h026a7820;
        data[9'h81] <= 32'hade80000;
        data[9'h82] <= 32'h22520001;
        data[9'h83] <= 32'h22310001;
        data[9'h84] <= 32'h08000090;
        data[9'h85] <= 32'h0012702a;
        data[9'h86] <= 32'h11c00005;
        data[9'h87] <= 32'h224fffff;
        data[9'h88] <= 32'h000f5080;
        data[9'h89] <= 32'h026a7820;
        data[9'h8A] <= 32'h8df20000;
        data[9'h8B] <= 32'h08000090;
        data[9'h8C] <= 32'h00115080;
        data[9'h8D] <= 32'h026a7820;
        data[9'h8E] <= 32'hade00000;
        data[9'h8F] <= 32'h22310001;
        data[9'h90] <= 32'h08000077;
        data[9'h91] <= 32'h20020001;
        data[9'h92] <= 32'h8fb00008;
        data[9'h93] <= 32'h8fb10004;
        data[9'h94] <= 32'h8fb20000;
        data[9'h95] <= 32'h23bd000c;
        data[9'h96] <= 32'h03e00008;
        data[9'h97] <= 32'h20020000;
        data[9'h98] <= 32'h8fb00008;
        data[9'h99] <= 32'h8fb10004;
        data[9'h9A] <= 32'h8fb20000;
        data[9'h9B] <= 32'h23bd000c;
        data[9'h9C] <= 32'h03e00008;
        data[9'h9D] <= 32'h20080000;
        data[9'h9E] <= 32'h1088001e;
        data[9'h9F] <= 32'h20080001;
        data[9'hA0] <= 32'h1088001e;
        data[9'hA1] <= 32'h20080002;
        data[9'hA2] <= 32'h1088001e;
        data[9'hA3] <= 32'h20080003;
        data[9'hA4] <= 32'h1088001e;
        data[9'hA5] <= 32'h20080004;
        data[9'hA6] <= 32'h1088001e;
        data[9'hA7] <= 32'h20080005;
        data[9'hA8] <= 32'h1088001e;
        data[9'hA9] <= 32'h20080006;
        data[9'hAA] <= 32'h1088001e;
        data[9'hAB] <= 32'h20080007;
        data[9'hAC] <= 32'h1088001e;
        data[9'hAD] <= 32'h20080008;
        data[9'hAE] <= 32'h1088001e;
        data[9'hAF] <= 32'h20080009;
        data[9'hB0] <= 32'h1088001e;
        data[9'hB1] <= 32'h2008000a;
        data[9'hB2] <= 32'h1088001e;
        data[9'hB3] <= 32'h2008000b;
        data[9'hB4] <= 32'h1088001e;
        data[9'hB5] <= 32'h2008000c;
        data[9'hB6] <= 32'h1088001e;
        data[9'hB7] <= 32'h2008000d;
        data[9'hB8] <= 32'h1088001e;
        data[9'hB9] <= 32'h2008000e;
        data[9'hBA] <= 32'h1088001e;
        data[9'hBB] <= 32'h2008000f;
        data[9'hBC] <= 32'h1088001e;
        data[9'hBD] <= 32'h2009003f;
        data[9'hBE] <= 32'h080000dd;
        data[9'hBF] <= 32'h20090006;
        data[9'hC0] <= 32'h080000dd;
        data[9'hC1] <= 32'h2009005b;
        data[9'hC2] <= 32'h080000dd;
        data[9'hC3] <= 32'h2009004f;
        data[9'hC4] <= 32'h080000dd;
        data[9'hC5] <= 32'h20090066;
        data[9'hC6] <= 32'h080000dd;
        data[9'hC7] <= 32'h2009006d;
        data[9'hC8] <= 32'h080000dd;
        data[9'hC9] <= 32'h2009007d;
        data[9'hCA] <= 32'h080000dd;
        data[9'hCB] <= 32'h20090007;
        data[9'hCC] <= 32'h080000dd;
        data[9'hCD] <= 32'h2009007f;
        data[9'hCE] <= 32'h080000dd;
        data[9'hCF] <= 32'h2009006f;
        data[9'hD0] <= 32'h080000dd;
        data[9'hD1] <= 32'h20090077;
        data[9'hD2] <= 32'h080000dd;
        data[9'hD3] <= 32'h2009007c;
        data[9'hD4] <= 32'h080000dd;
        data[9'hD5] <= 32'h20090039;
        data[9'hD6] <= 32'h080000dd;
        data[9'hD7] <= 32'h2009005e;
        data[9'hD8] <= 32'h080000dd;
        data[9'hD9] <= 32'h20090079;
        data[9'hDA] <= 32'h080000dd;
        data[9'hDB] <= 32'h20090071;
        data[9'hDC] <= 32'h080000dd;
        data[9'hDD] <= 32'h3c154000;
        data[9'hDE] <= 32'h20150010;
        data[9'hDF] <= 32'haea90000;


        for (i = 9'hB5; i < MEM_SIZE; i = i + 1)
        begin
            data[i] <= 0;
        end
    end

endmodule