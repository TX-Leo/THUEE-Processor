///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
// Function:
//  (1) Instantiation multi-cycle processor
//////////////////////////////////////////////

`timescale 1ns / 1ps
module TpTop();
    
    reg reset;
    reg clk;
    
    Top top(reset, clk);
    
    initial begin
        reset = 1;
        clk = 1;
        #100 reset = 0;
        #40000 $finish;
    end

    initial begin
        $dumpfile("multi_cycle_processor.vcd");// create a vcd database to record data
        $dumpvars(0,TbTop);//"level=0" declare it will record all data in this TbTop module to .vcd file
    end
    
    always #50 clk = ~clk;
    
endmodule
