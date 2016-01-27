@echo off
setlocal EnableDelayedExpansion

set verb=%1

::Do nothing if %1 starts with none
if "%verb:~0,4%" EQU "none" (
	exit /b
) else (
	if "%verb:~0,5%" EQU "menu-" (
		set pathfile_path="%temp%\kamesvn.tmp"
		call :menu_%verb:~5,-1%%verb:~-1% "%~2"
		goto :end_menu
		:menu_blame
			if exist "%~dpnx1" (
				if not exist "%~dpnx1\" (
					TortoiseGitProc /command:blame /path:"%~dpnx1"
				)
			)
			goto end_menu
		:menu_diff
			if exist "%~dpnx1" (
				if not exist "%~dpnx1\" (
					TortoiseGitProc /command:diff /path:"%~dpnx1"
				)
			)
			goto end_menu
		:menu_console
			start cmd /k "echo This working directory is versioned using Git."
			goto end_menu
		:menu_repobrowser
			if exist "%~dpnx1" (
				TortoiseGitProc /command:repobrowser /path:"%~dpnx1"
			)
			goto end_menu
		:menu_pull
			TortoiseGitProc /command:pull /path:"%cd%"
			goto end_menu
		:menu_push
			TortoiseGitProc /command:push /path:"%cd%"
			goto end_menu
		:menu_switch
			TortoiseGitProc /command:switch /path:"%cd%"
			goto end_menu
		:menu_branch
			TortoiseGitProc /command:branch /path:"%cd%"
			goto end_menu
		:menu_tag
			TortoiseGitProc /command:tag /path:"%cd%"
			goto end_menu
		:menu_merge
			TortoiseGitProc /command:merge /path:"%cd%"
			goto end_menu
		:menu_revgraph
			if exist "%~dpnx1" (
				TortoiseGitProc /command:revisiongraph /path:"%~dpnx1"
			)
			goto end_menu
		:menu_gitk
			call gitk
			goto end_menu
		:menu_clean
			TortoiseGitProc /command:cleanup /path:"%cd%"
			goto end_menu
		:menu_stash
			TortoiseGitProc /command:stashsave /path:"%cd%"
			goto end_menu
		:menu_unstash
			TortoiseGitProc /command:stashpop /path:"%cd%"
			goto end_menu
		:menu_createpatch
			TortoiseGitProc /command:formatpatch /path:"%cd%"
			goto end_menu
		:menu_applypatch
			TortoiseGitProc /command:importpatch /path:"%cd%"
			goto end_menu
		:end_menu
		goto :eof
	) else (
		if "%1" EQU "postimport" (
			if "%~2" EQU "file:///./" (
				echo Setting up local repository, no remote origin.
			) else (
				echo Adding origin: %2
				for /f "usebackq tokens=*" %%i in (`git remote add origin "%~2"`) do echo %%i
			)
			echo.
			echo Ignoring SCIfile.txt...
			echo SCIfile.txt>.gitignore
			echo.
		) else (
			for /f "usebackq tokens=*" %%i in (`git %*`) do echo %%i
		)
	)
)
exit /b