@echo off
setlocal EnableDelayedExpansion

REM Define relative folder paths
set "source_folder=C:\Downloads\git_auto\source"
set "destination_folder=C:\Downloads\git_auto\target"

REM Define the original and temporary user name and email
set "temp_name=NewName"
set "temp_email=newemail@example.com"
REM -----------------------------------------------------------------------

echo ********************************************
echo *                                          *
echo *                auto_git.bat              *
echo *                                          *
echo ********************************************

REM Count the total number of folders in the source directory
set /a total_folders=0
for /D %%F in ("%source_folder%\*") do (
    set /a total_folders+=1
)

REM Welcome message
@echo:
@echo This script will copy all folders from 
@echo      !source_folder! (containing !total_folders! folders)
@echo over to 
@echo      !destination_folder!
@echo and commit to the Repository. The folders MUST be on the local harddrive. 
@echo Make sure the git repository is initiated in advance and .gitignore is configured.

REM Save git config user.name to a variable
for /f "delims=" %%A in ('git config user.name') do set "original_name=%%A"
for /f "delims=" %%A in ('git config user.email') do set "original_email=%%A"

REM Display the saved git user name
@echo: 
@echo Temporarily changign the Git user.name and user.email from
@echo      Git user name: !original_name!
@echo      Git user email: !original_email!
@echo to 
@echo      Git user name: !temp_name!
@echo      Git user email: !temp_email!

REM Set temporary git credentials
git config --global user.name "!temp_name!"
git config --global user.email "!temp_email!"


@echo Continue by Pressing ANY button.
@echo:

pause

echo ********************************************
echo *                                          *
echo *           Starting main part             *
echo *                                          *
echo ********************************************

REM Loop through each folder in the source directory
set /a iteration=0
for /D %%F in ("%source_folder%\*") do (
    set "folder_name=%%~nxF"
	
	REM Echo the folder name with a tab and a newline
	echo: 
	set /a iteration+=1
    echo [!iteration!/!total_folders!] Processing folder: !folder_name! 
    
    
    REM Copy the contents of the folder to the destination
    xcopy "%%F\*" "%destination_folder%" /s /e /i /y >NUL
    
    REM Change directory to the destination folder
    cd /d "%destination_folder%"
    
    REM Git add all files (>nul 2>&1 for silent)
    git add . >nul 2>&1
    
    REM Git commit with the folder name as the commit message
    git commit -m "folder !folder_name!"
    
    REM Display a message and wait for user input before proceeding
    REM echo Commit for folder "!folder_name!" completed. Press any key to continue...
    REM pause >nul
	
    
)


REM Restore original user name and email
git config --global user.name "!original_name!"
git config --global user.email "!original_email!"

@echo:
@echo User name and email restored to original values:
@echo Name: !original_name!
@echo Email: !original_email!
@echo:

@echo End of script auto_git.bat
pause


REM NOTES
REM	@echo %cd% gets current folder
REM	@echo %~dp0 gets current folder in absolute path