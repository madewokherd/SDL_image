@echo off
setlocal

if "%1"=="clean" goto :clean
if "%1"=="noclean" (
	set __NOCLEAN__=true
	shift)

nuget restore SDL_image\SDL_image.sln

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
call :build x64 v140
call :build Win32 v140
call :build x64 v120
call :build Win32 v120
endlocal

if "__NOCLEAN__"=="true" goto :eof

goto :clean

:build
msbuild /P:Platform=%1 /P:Configuration=Debug /P:PlatformToolset=%2 SDL_image\SDL_image.sln
msbuild /P:Platform=%1 /P:Configuration=Release /P:PlatformToolset=%2 SDL_image\SDL_image.sln
)
goto :eof

:clean
rd /s /q SDL_image\SDL_image\Debug
rd /s /q SDL_image\SDL_image\Release

:eof

