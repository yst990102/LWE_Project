@echo off
REM ****************************************************************************
REM Vivado (TM) v2021.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Sat Nov 06 08:50:57 +0800 2021
REM SW Build 3247384 on Thu Jun 10 19:36:33 MDT 2021
REM
REM IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim Processor_TB_behav -key {Behavioral:sim_1:Functional:Processor_TB} -tclbatch Processor_TB.tcl -view E:/Github_repository/COMP3601/VHDL Work/project_1/Processor_TB_behav.wcfg -log simulate.log"
call xsim  Processor_TB_behav -key {Behavioral:sim_1:Functional:Processor_TB} -tclbatch Processor_TB.tcl -view E:/Github_repository/COMP3601/VHDL Work/project_1/Processor_TB_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
