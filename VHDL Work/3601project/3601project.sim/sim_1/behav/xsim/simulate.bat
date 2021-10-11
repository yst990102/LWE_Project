@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Tue Oct 12 00:10:49 +0800 2021
REM SW Build 3118627 on Tue Feb  9 05:14:06 MST 2021
REM
REM Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim Processor_TB_behav -key {Behavioral:sim_1:Functional:Processor_TB} -tclbatch Processor_TB.tcl -view E:/Github_repository/COMP3601/VHDL Work/3601project/Processor_TB_behav 10-09.wcfg -log simulate.log"
call xsim  Processor_TB_behav -key {Behavioral:sim_1:Functional:Processor_TB} -tclbatch Processor_TB.tcl -view E:/Github_repository/COMP3601/VHDL Work/3601project/Processor_TB_behav 10-09.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
