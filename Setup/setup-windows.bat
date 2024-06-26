@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib install flixel-addons 2.11.0
haxelib install flixel 4.11.0
haxelib git hscript-improved https://github.com/FNF-CNE-Devs/hscript-improved
haxelib git scriptless-polymod https://github.com/SrtHero278/scriptless-polymod
echo Finished!
pause
