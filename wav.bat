@echo off
setlocal EnableDelayedExpansion

set /a count = 0
for /F "tokens=* USEBACKQ" %%F in (`ffprobe -v error -show_entries stream^=codec_type -of default^=noprint_wrappers^=1:nokey^=1 "%~1"`) DO (
    echo %%F
    echo !count!
    if "%%F"=="audio" (
        echo I'm in
        ffmpeg -i "%~1" -map 0:!count! -c:a copy "%~dnp1-Track!count!.wav"
    )
    set /a count += 1
)
pause