@title Setting ......
@set PLATFORM_NAME=picoc
@set PLATFORM_PKG=%PLATFORM_NAME%
@cd ..

@if /I "%1"=="/?" (
  @goto ShowHelp
)
@if /I "%1"=="/h" (
  @goto ShowHelp
)
@if /I "%1"=="-help" (
  @goto ShowHelp
)

@set WORKSPACE=%cd%
@set WINDDK3790_PREFIX=%WORKSPACE%\Tools\
@set IASL_PREFIX=%WORKSPACE%\Tools\
@set NASM_PREFIX=%WORKSPACE%\Tools\
@set TOOL_CHAIN=VS2013x86
@call edksetup.bat
@set SOUCECODE_DIR=%PLATFORM_PKG%\

@cls
@if not defined NUMBER_OF_PROCESSORS (
  @set NUMBER_OF_PROCESSORS=2
)
@set MAX_CPUS=%NUMBER_OF_PROCESSORS%
@set TARGET_BUILD=RELEASE

@set ACTIVE_DSC=%PLATFORM_PKG%\picocpkg.dsc

::Build time1 start >>>
@set nSec=0
@set time1=%time%
@call :Time2Sec %time1%
@set t1=%nSec%
::Build time1 end <<<

@cls
@echo MyApp Building .......

@if not exist Build (
	@mkdir Build
)

@if /I "%1"=="DEBUG" (
    @set TARGET_BUILD=DEBUG
)

@title Building ......
@call build -p %ACTIVE_DSC% -a X64 -t %TOOL_CHAIN% -b %TARGET_BUILD% -n %MAX_CPUS%

@if %ERRORLEVEL% NEQ 0 goto ENDM

@copy /y Build\%PLATFORM_PKG%\%TARGET_BUILD%_%TOOL_CHAIN%\X64\*.efi %PLATFORM_PKG%

@goto ENDM

:Time2Sec
::  @set tt=%1
::  @set hh=%tt:~0,2%
::  @set mm=%tt:~3,2%
::  @set ss=%tt:~6,2%
::  @set /a nSec=(%hh%*60+%mm%)*60+%ss%
::  @goto :eof
	@set tt=%1
	@for /F "tokens=1-4 delims=:. " %%a in ("%tt%") do (
		@set hh=%%a
		@set mm=%%b
		@set ss=%%c
	)
	@set /a nSec=(%hh%*60+%mm%)*60+%ss%
	@goto :eof

:ShowHelp
  @echo ===============================================================================
  @echo BuildMyApp.bat [Arg1]:
  @echo    Arg1: Optional, if Arg2="DEBUG", build for debug;
  @echo          Default is release version.
  @echo ===============================================================================
 
:ENDM

::Build time2 start >>>
  @set time2=%time%
  @call :Time2Sec %time2%
  @set t2=%nSec%
  @set /a tdiff=%t2%-%t1%
  @echo [%time1% ~ %time2%]: total %tdiff% seconds.
::Build time1 end <<<

  @cd %WORKSPACE%
  @title MyApp build completed
  @cd %PLATFORM_PKG%
