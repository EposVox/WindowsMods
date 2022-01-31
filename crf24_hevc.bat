pushd "%1"

::Default variables
SET paths=paths.txt
::paths lets you put a bunch of folder paths in a text file and run this across those, instead of individually. I use this to run overnight on a LOT of footage folders at once. Thanks to Aayla for a lot of these upgrades
::Fun tip - select your folders (15 max at a time) and shift+right-click and click "copy as paths"
SET /A ffmpeg_qv=24
::change CQP value here so you only have to type it once. 22 is lossless for HEVC.

::for /R %%A in (*.mp4, *.avi, *.mov, *.wmv, *.ts, *.m2ts, *.mkv, *.mts) do (
::    echo Processing %%A
::    ffmpeg -hwaccel auto -i "%%A" -pix_fmt yuv420p -map 0:v -map 0:a -c:v hevc_nvenc -rc constqp -qp 21 -b:v 0K -c:a libfdk_aac -vbr 5 -movflags +faststart "%%~dpnA_CRF%ffmpeg_qv%_HEVC.mp4"
::    echo Processed %%A
::)
::pause
::Test if the paths file exists and iterate through it
if EXIST %paths% (
    for /f "tokens=*" %%a in (%paths%) do (
        echo Changing to directory %%a
        pushd "%%a"
        CALL :ffmpeg
    )
) else (
    ::It doesn't exist
    CALL :ffmpeg
)
pause
EXIT /B %ERRORLEVEL%
::Don't run the function when they're first defined because that's a thing Batch does for some reason???
:ffmpeg
    for /R %%A in (*.mp4, *.avi, *.mov, *.wmv, *.ts, *.m2ts, *.mkv, *.mts) do (
        echo Processing "%%A"
        ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "%%A" -map 0:v -map 0:a -map_metadata 0 -c:v hevc_nvenc -bf 0 -rc constqp -qp %ffmpeg_qv% -b:v 0K -c:a aac -b:a 384k -movflags +faststart -movflags use_metadata_tags "%%~dpnA_CRF%ffmpeg_qv%_HEVC.mp4"
		:: "-pix_fmt" can't be used together with "-hwaccel_output_format cuda"
		:: "-map_metadata 0" copies all metadata from source file
		:: "-movflags +faststart" helps with audio streaming
        echo Processed %%A
    )
GOTO :EOF
