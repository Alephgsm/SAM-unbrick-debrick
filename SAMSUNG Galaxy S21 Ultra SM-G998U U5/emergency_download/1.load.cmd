@echo off
color 0b
title  高通工具 
mode con cols=80 lines=40
:RETRY
:setup
cls
lsusb
set /p port=输入9008端口号[1~3000,x:Exit]:
if "%port%" == "x" goto EXIT
for /L %%a in (1,1,3000) do (
           IF "%port%" == "%%a" (
           		goto ChoiceOK
           )           
)
echo %port% is BAD!!
goto RETRY

goto ChoiceOK

:ChoiceOK


echo Start Recovery.
QSaharaServer.exe -s 13:.\prog_firehose_ddr.elf -p \\.\COM%port%
echo y |.\fh_loader.exe --port=\\.\COM%port%  --sendxml=.\rawprogram1.xml --sendxml=.\rawprogram2.xml --sendxml=.\rawprogram3.xml --sendxml=.\rawprogram4.xml --sendxml=.\rawprogram5.xml  --memoryname=UFS --reset
del /Q port_trace.txt


goto :setup




