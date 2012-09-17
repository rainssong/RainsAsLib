:Date 2012-5-25
:Author rainssong
@echo off
xcopy src bin-debug /d /s /i /q /y /exclude:ExcludeFiles.txt
echo Resource Updated!