@echo off
echo Setting up KameGMS (Git)
echo.

:: Check TortoiseGit 
<NUL set /p ".=Checking TortoiseGit... "
where TortoiseGitProc >NUL 2>NUL || goto :failed_tortoise
where TortoiseGitMerge >NUL 2>NUL || goto :failed_tortoise
echo OK

:: Check GameMaker Studio Early Access
<NUL set /p ".=Checking GameMaker Studio Early Access... "
reg query "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v Directory >NUL 2>NUL || goto :failed_gmsea
echo OK

:: Add registry entries
<NUL set /p ".=Adding registry entries... "
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v 5tudioSCMConfigFile /t REG_SZ /d "%~dp0kamegit.scmconfig.xml" /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SVNExeLocation /t REG_SZ /d "%~dp0kamegit.bat" /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SVNExeChoice /t REG_DWORD /d 2 /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SCMAdvancedOptions /t REG_DWORD /d 1 /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SCMColours /t REG_DWORD /d 1 /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SCMDisable /t REG_DWORD /d 0 /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SCMLogging /t REG_DWORD /d 1 /f >NUL 2>NUL || goto :failed_registry
reg add "HKCU\Software\GMStudio_EA\Version 1.0\Preferences" /v SCMNoFolderCommits /t REG_DWORD /d 0 /f >NUL 2>NUL || goto :failed_registry
echo OK

:: Setup complete
goto :done

:: OK
:done
echo.
echo Installation complete. Thank you for choosing KameGMS.
pause
exit /b

:: Failed - No TortoiseGit
:failed_tortoise
echo FAIL
echo .
echo Installation failed. Please install TortoiseGit, then try again.
pause
exit /b

:: Failed - No GameMaker Studio Early Access
:failed_gmsea
echo FAIL
echo .
echo Installation failed. Please install GameMaker Studio Early Access, then try again.
pause
exit /b

:: Failed - Cannot add registry entries
:failed_registry
echo FAIL
echo .
echo Installation failed. Please check your user permissions, then try again.
pause
exit /b