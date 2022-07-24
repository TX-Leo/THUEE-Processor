###############################################
## Author:TX-Leo
## Target Devices: XILINX xc7A35TCSG324-1
## Tool Versions: Vivado 2019.2
## Create Date: 2022/06/13
## Project Name: single-cycle processor
## Description: It's TX-Leo's Experiment_Processor_02_01
## File Type: constrain(src/constrain/sim)
##############################################
create_clock -period 20.000 -name CLK -waveform {0.000 10.000} [get_ports clk]