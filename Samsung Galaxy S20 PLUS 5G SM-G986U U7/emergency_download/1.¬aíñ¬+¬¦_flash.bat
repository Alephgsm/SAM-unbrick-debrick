@echo off

setlocal EnableDelayedExpansion

if "%1" EQU "" goto _getdevice

:_flash
if "%1" EQU "List" goto _exit

title %1

color 0b

ping 127.0.0.1 -n 3 >nul

rem ����
QSaharaServer.exe -s 13:.\prog_firehose_ddr.elf -p \\.\%1
echo y |.\fh_loader.exe --port=\\.\%1  --sendxml=.\rawprogram1.xml --sendxml=.\rawprogram2.xml --sendxml=.\rawprogram3.xml  --memoryname=UFS --reset
ping 127.0.0.1 -n 3 >nul
exit


:_getdevice
echo  �鿴�����豸��,�ȴ�5��......
rem adb kill-server
.\emmcdl.exe -l >.\devices.txt
ping 127.0.0.1 -n 1 >nul

rem �ı�����
.\fr ".\devices.txt" -s -f:"Version 2.10" -t
.\fr ".\devices.txt" -s -f:"Finding all devices in emergency download mode..." -t
.\fr ".\devices.txt" -s -f:"Finding all disks on computer ..." -t
.\fr ".\devices.txt" -s -f:"Status: 0 The operation completed successfully." -t
.\fr ".\devices.txt" -s -f:"(" -t
.\fr ".\devices.txt" -s -f:")" -t -frc >.\info.txt
for /f "tokens=5" %%a in (.\devices.txt) do echo %%a
for /f "tokens=2" %%a in (.\info.txt) do echo һ��%%ą
pause

for /f "tokens=5" %%a in ('findstr "Qualcomm HS-USB QDLoader 9008" .\devices.txt') do (

	echo %%a 
	rem ��ȡ�����е�ǰ���������ļ���
	start cmd /c %~n0 %%a

)
echo %~n0
:_exit
DEL /Q port_trace.txt
exit