:Date 2012-5-25
:Author rainssong
@echo off
rd bin /s /q
md bin
xcopy src bin /s /i /q /y /exclude:bat\ExcludeFiles.txt
echo Full Copy Finished!
echo Project Cleared!
