@echo off
color 0b
title  ��ͨ���� 
mode con cols=80 lines=40
:RETRY
:setup
cls
lsusb
set /p port=����9008�˿ں�[1~3000,x:Exit]:
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

rem �ж� rawprogram5.xml ����
dir /a-d /tc .\rawprogram5.xml | findstr /b %date:~,10%>nul&& goto :R2 ||goto :R1


:R1
rem R1-R3
echo Start Recovery.
QSaharaServer.exe -s 13:.\prog_firehose_ddr.elf -p \\.\COM%port%
echo y |.\fh_loader.exe --port=\\.\COM%port%  --sendxml=.\rawprogram1.xml --sendxml=.\rawprogram2.xml --sendxml=.\rawprogram3.xml --memoryname=UFS --reset
del /Q port_trace.txt
goto :setup

:R2
rem R1-R5
echo Start Recovery.
QSaharaServer.exe -s 13:.\prog_firehose_ddr.elf -p \\.\COM%port%
echo y |.\fh_loader.exe --port=\\.\COM%port%  --sendxml=.\rawprogram1.xml --sendxml=.\rawprogram2.xml --sendxml=.\rawprogram3.xml --sendxml=.\rawprogram4.xml --sendxml=.\rawprogram5.xml  --memoryname=UFS --reset
del /Q port_trace.txt
goto :setup




