put images into the images folder (not too many it's slow).
then run the demo code in matlab.

To extract images from a video with ffmpeg you can use this code

$ ffmpeg -i GH010107.mp4 -vf fps=5 images/thumb%04d.jpg -hide_banner
