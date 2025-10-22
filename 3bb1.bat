
��@echo off
setlocal enabledelayedexpansion
set policy="# DO NOT DELETE OR RENAME OR CHANGE ANY FILES AND FOLDER"
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
if not exist "Backup" md "Backup" 2>nul
if not exist %policy% echo. > %policy% 2>nul
cd  /d "%cd%"\bin\ 2>nul
for /r %%f in (%policy%) do @if not exist %%f @echo. > %%f 2>nul
cd .. 2>nul
mode con:lines=28 cols=98
chcp 65001>nul
color 00
cls
title MULTI TOOLS AX810 - POWERED BY AJR
:main
echo ┌───────────────────────────────────────────────────────────────────────────┐
echo │ Custom Firmware      : 3BB GIGATV /  TBBTV01    ATV12                     │
echo │ Base Firmware        : Base Original Ota 3BB                              │
echo │ Hailstorm Versi      : 4.1.2 / 4.1.3                                      │                     
echo │ Versi OS Android TV  : BossOddy_RTT0.210829.002.20220325_release-keys     │
echo │ Custom Firmware By   : @pat_stb                                           │  
echo ├───────────────────────────────────────────────────────────────────────────┤ 
echo │ Catatan :                                                                 │   
echo │ Firmware ini menggunakan partisi A, sebelum menggunakan firmware ini,     │   
echo │ harap beralih slot aktif ke A. Jika tdk, STB anda akan stuck di logo boot.│             
echo └───────────────────────────────────────────────────────────────────────────┘
echo          TOMBOL PILIHAN FLASH : 1 - 2 - 5 - 6 - 4 - 7 - 3 - 8 - 9 - 0
echo.
echo.
echo      SILAHKAN PILIH MENU :
echo.
echo      [1]  - Scan Device
echo      [2]  - Reboot Bootloader         UBT  
echo      [3]  - Reboot Fastboot_D         FB  
echo      [4]  - Chek Bootloader Status    BL
echo      [5]  - Unlock Bootloader         UBT
echo      [6]  - Reboot UBT PORT           BL/FB 
echo      [7]  - Open UBT Port             BL
echo      [8]  - Flash Custom ROM          FB
echo      [9]  - Reboot system             BL/FB
echo      [0]  - Exit
echo.
set /p main=Silahkan Tekan Tombol Pilihan Flash : 
if %main% == 1 goto Scan Device
if %main% == 2 goto Bootloader
if %main% == 3 goto Fastboot
if %main% == 4 goto Status Bootloader/Fastboot
if %main% == 5 goto Unlock Bootloader
if %main% == 6 goto Switch the active slot A
if %main% == 7 goto Erase Data/Cache
if %main% == 8 goto AX810
if %main% == 9 goto System
if %main% == 0 goto exit
echo Please select [1..0]
timeout 2 >nul
cls
goto main
:Scan Device
fastboot.exe devices
echo.
pause
cls
goto main
:Bootloader
update bulkcmd fastboot
echo.
cls
goto main
:Fastboot
fastboot.exe reboot fastboot
echo.
cls
goto main
:Status Bootloader/Fastboot
fastboot.exe getvar all
echo.
pause
cls
goto main
:Unlock Bootloader
update bulkcmd "setenv -f EnableSelinux permissive"
update bulkcmd "env set lock 0"
update bulkcmd "env set avb2 0"
update bulkcmd "env set oem_lock unlock"
update bulkcmd "store rom_protect off"
update bulkcmd "saveenv"
echo.
pause
cls
goto main
:Erase Data/Cache
update bulkcmd update
echo.
pause
cls
goto main
:Switch the active slot A
fastboot.exe oem update
echo.
pause
cls
goto main
:AX810
fastboot flash boot boot.img
fastboot flash logo logo.img
fastboot flash dtbo dtbo.img
fastboot flash super super.img 
fastboot --disable-verification --disable-verity flash vbmeta vbmeta.img
echo.
pause
cls
goto main
:system
fastboot.exe reboot
echo.
pause
cls
goto main
:exit
exit
