@echo off
echo "**************************************************************************************"
%2\scripts\pip3 install pyserial
%2\scripts\pip3 install requests


%~d1
cd %1
cd hardware
mkdir Maixduino > nul
cd Maixduino

rem ***** Pobranie aktualnego arduino core *****

echo "**************************************************************************************"
git clone https://github.com/sipeed/Maixduino.git k210

echo "**************************************************************************************"
cd %1\hardware\Maixduino\k210\cores\arduino
git clone https://github.com/sipeed/kendryte-standalone-sdk.git
cd %1\hardware\Maixduino\k210\cores\arduino\kendryte-standalone-sdk\src\hello_world\
del main.c > nul

echo "**************************************************************************************"
cd %1\hardware\Maixduino\k210
mkdir package > nul
copy %~d0%~p0package\*.* %1\hardware\Maixduino\k210\package\ /Y > nul

mkdir Tools > nul
copy %~d0%~p0get.py %1\hardware\Maixduino\k210\Tools /Y > nul
cd Tools
%2\python.exe get.py
copy %1\hardware\Maixduino\k210\Tools\8.2.0\bin\*.dll %2\ /Y > nul
echo "**************************************************************************************"
cd %1\hardware\Maixduino\k210\Tools
git clone https://github.com/sipeed/kflash.py.git
%2\python.exe %~d0%~p0strreplace.py "%1\hardware\Maixduino\k210\tools\kflash.py\kflash.py" "os.get_terminal_size()" "80,40"

copy %~d0%~p0boards.txt %1\hardware\Maixduino\k210\ /Y > nul
%2\python.exe %~d0%~p0strreplace.py "%1\hardware\Maixduino\k210\boards.txt" "#compiler#" "%1/hardware/Maixduino/k210/Tools/8.2.0/bin/"
copy %~d0%~p0platform.txt %1\hardware\Maixduino\k210\ /Y > nul
%2\python.exe %~d0%~p0strreplace.py "%1\hardware\Maixduino\k210\platform.txt" "#python#" "%2"
copy %~d0%~p0programmers.txt %1\hardware\Maixduino\k210\ /Y > nul

echo "**************************************************************************************"
echo "KONIEC INSTALACJI"
pause