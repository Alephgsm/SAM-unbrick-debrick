@echo off

setlocal EnableDelayedExpansion

if "%1" EQU "" goto _getdevice

:_flash
if "%1" EQU "List" goto _exit

title %1

color 0b

set /a n=%random%%%3+1
echo %n%

ping 127.0.0.1 -n %n% >nul

rem 命令
QSaharaServer.exe -s 13:.\prog_firehose_ddr.elf -p \\.\%1
echo y |.\fh_loader.exe --port=\\.\%1  --sendxml=.\rawprogram1.xml --sendxml=.\rawprogram2.xml --sendxml=.\rawprogram3.xml --sendxml=.\rawprogram4.xml --sendxml=.\rawprogram5.xml  --memoryname=UFS --reset
exit


:_getdevice
echo  查看连接设备数,等待5秒......
rem adb kill-server
.\emmcdl.exe -l >.\devices.txt
ping 127.0.0.1 -n 1 >nul

rem 文本处理
.\fr ".\devices.txt" -s -f:"Version 2.10" -t
.\fr ".\devices.txt" -s -f:"Finding all devices in emergency download mode..." -t
.\fr ".\devices.txt" -s -f:"Finding all disks on computer ..." -t
.\fr ".\devices.txt" -s -f:"Status: 0 The operation completed successfully." -t
.\fr ".\devices.txt" -s -f:"(" -t
.\fr ".\devices.txt" -s -f:")" -t -frc >.\info.txt
for /f "tokens=5" %%a in (.\devices.txt) do echo %%a
for /f "tokens=2" %%a in (.\info.txt) do echo 一共%%a台
pause

for /f "tokens=5" %%a in ('findstr "Qualcomm HS-USB QDLoader 9008" .\devices.txt') do (

	echo %%a 
	rem 获取并运行当前的批处理文件名
	start cmd /c %~n0 %%a

)
echo %~n0
:_exit
DEL /Q port_trace.txt
exit