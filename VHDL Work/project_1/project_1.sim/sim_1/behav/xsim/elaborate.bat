@echo off
REM ****************************************************************************
REM Vivado (TM) v2021.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Mon Oct 25 16:01:24 +0800 2021
REM SW Build 3247384 on Thu Jun 10 19:36:33 MDT 2021
REM
REM IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab -wto cbc7b9c83b2e4c5692bd264fb8a92134 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Processor_TB_behav xil_defaultlib.Processor_TB -log elaborate.log"
call xelab  -wto cbc7b9c83b2e4c5692bd264fb8a92134 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Processor_TB_behav xil_defaultlib.Processor_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
