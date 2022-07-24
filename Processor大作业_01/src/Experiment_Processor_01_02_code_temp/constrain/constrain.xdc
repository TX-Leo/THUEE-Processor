###############################################
## Author:TX-Leo
## Target Devices: XILINX xc7A35TCSG324-1
## Tool Versions: Vivado 2019.2
## Create Date: 2022/05/20
## Project Name: code_temp
## Description: It's TX-Leo's Experiment_Processor_01_02
## File Type: constrain(src/constrain/sim)
##############################################
# create_clock -period 10.000 -name clk1 [get_ports sysclk]

create_clock -period 10.000 -name sysclk -waveform {0.000 5.000}