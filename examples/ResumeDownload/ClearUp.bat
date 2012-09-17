:Date 2012-5-25
:Author rainssong
@echo off
rd bin-debug /s /q
md bin-debug
xcopy src bin-debug /s /i /q /y /exclude:ExcludeFiles.txt
echo Full Copy Finished!
echo Project Cleared!
