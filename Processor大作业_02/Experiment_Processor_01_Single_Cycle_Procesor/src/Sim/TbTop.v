///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
// Function:
//  (1) Instantiation a singal-cycle processor
//////////////////////////////////////////////

`timescale 1ns/1ps
`define PERIOD 10
module TbTop ();
    reg reset, clk;
    //clk
    initial begin
        clk = 1;
        forever begin
            #(`PERIOD/2) clk = ~clk;
        end
    end
    //initial parameter
    initial begin
        #(`PERIOD) reset = 1;
        #(`PERIOD) reset = 0;
        #(`PERIOD * 100) $finish;
    end
    //record data
    initial begin
        $dumpfile("single_cycle_processor.vcd");// create a vcd database to record data
        $dumpvars(0,TbTop);//"level=0" declare it will record all data in this TbTop module to .vcd file
    end
    
    Top top(.clk(clk), .reset(reset));
    
endmodule 