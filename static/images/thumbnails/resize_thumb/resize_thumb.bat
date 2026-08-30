REM magick mogrify  -adaptive-resize 140 *.jpg
REM magick mogrify -adaptive-resize 140 -filter LanczosSharp -unsharp 0x0.5+0.5+0.008 -colorspace sRGB -quality 85 -strip *.jpg
magick mogrify -thumbnail 140 *.jpg
