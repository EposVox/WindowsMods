pushd "%2"

for /R %%A in (*.mp4, *.avi, *.mov, *.wmv, *.ts, *.m2ts, *.mkv, *.mts) do (
    echo Processing %%A
    ffmpeg -hwaccel auto -i "%%A" -map 0:v -map 0:a -c:v hevc_nvenc -rc constqp -qp 24 -b:v 0K -c:a aac -b:a 384k "%%~dnpA_CRF24_HEVC.mp4"
    echo Processed %%A
)
pause