:Date 2012-5-25
:Author rainssong
@echo off
xcopy src bin /d /s /i /q /y /exclude:bat\ExcludeFiles.txt
echo Resource Updated!