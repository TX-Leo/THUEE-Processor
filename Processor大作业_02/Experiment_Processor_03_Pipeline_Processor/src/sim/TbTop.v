///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
//////////////////////////////////////////////

`timescale 1ns / 1ps

module TbTop();
    reg sysclk;
    reg reset;
    reg clk;
    wire [7:0] leds;
    wire [3:0] an;
    wire [7:0] bcd7;

    parameter PERIOD = 100;
    Top_Pipeline_Processor my_top_pipeline_processor
    (
        .sysclk(sysclk),
        .reset(reset),
        .i_clk(clk),
        .leds(leds),
        .an(an),
        .bcd7(bcd7)
    );
    initial begin
        clk = 0;
        reset = 1;
        #(PERIOD * 10) reset = 0;
        #(PERIOD * 30000) $finish;
    end

    initial begin
        forever begin
            #(PERIOD / 2) clk = ~clk;
        end
    end

endmodule
