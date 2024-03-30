# auto_git.bat
Dominic Gerber, 28.3.2024

## Purpose
Convert a version control system with folders (each folder 
contains a copy of the whole project, the folder name is the version number)
to a git controlled version history (without file redundancy).

## Working priniciple
Copies content from the version folders one after the other into a target folder (overwriting in the process)
and commits after each copy step with the foldername as commit message. 


## Usage
- copy everything to the local harddisk. put all folders of the version history into one
  (e.g. "source") folder
- prepare a "target" folder
- initialize a repository in the target folder with `git init`
- (optional) configure a .gitignore file in the target folder (e.g. to exclude /bin/ folders from version control)
- adjust .bat file with a text editor
	- paths (in absolute, local machine paths)
	- User credentials which should be used for the commit (REM if not used)


## Caution
The script has no way of knowing if any of the steps were succesfull, so do check the result!
