@echo off
setlocal
title MSM8998 Boot Recovery Program
mode con cols=110 lines=40

set port=

:RETRY
color a
cls
echo 忙式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式忖
echo 弛                                                                            弛
echo 弛                        MSM8998 Boot Recovery                               弛
echo 弛                                                                            弛
echo 弛                                                                            弛
echo 戌式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式式戎
echo.
mode
echo.
echo ㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑㏑
set /p port=Input Port Number[1~300,x:Exit]:
if "%port%" == "x" goto EXIT
for /L %%a in (1,1,300) do (
           IF "%port%" == "%%a" (
           		goto ChoiceOK
           )           
)
echo %port% is BAD!!
goto RETRY

goto ChoiceOK

:ChoiceOK

echo %port%

echo Start Recovery.
echo emmcdl.exe -p COM%port% -f prog_firehose_ddr.elf -MemoryName ufs -SetActivePartition 1 -x rawprogram0.xml -x rawprogram1.xml -x rawprogram2.xml -x rawprogram3.xml
emmcdl.exe -p COM%port% -f prog_firehose_ddr.elf -MemoryName ufs -SetActivePartition 1 -x rawprogram0.xml -x rawprogram1.xml -x rawprogram2.xml -x rawprogram3.xml

:EXIT
set /p str=Finish!!
)