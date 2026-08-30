+++
title = 'Image Optimization for this Website'
date = 2026-06-04
draft = false
tags = ["Web"] #Delete the ones that don't apply
imagecode = 'image_optimization'
+++

This website will likely hold lots of images. Image rendering drove loading times on my [old portfolio website](https://nathnkim.github.io/PortfolioWebsite/), so I know this is something I need to think about if I want my webpages to have respectable loading times. Even if I didn't care about page speed, Github Pages, which hosts this website, restricts sites to [less than 1GB](https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits). At 3MB per image, I'd be capped at <300 total images in the site.

My approach here is to reduce image file size by resizing the images to better fit the site layout (literally make them smaller dimensions), and to eliminate "excess" data via lossy compression. These two things can be done with a lightweight workflow using [ImageMagick](https://imagemagick.org/#gsc.tab=0). The following command, placed in a batch script in the same directory as the images I wish to resize, leverages ImageMagick's [adaptive resizer](https://usage.imagemagick.org/resize/) to compress and overwrite the entire batch of .jpgs:

~~~
magick mogrify  -adaptive-resize WIDTHxHEIGHT *.jpg
~~~

`WIDTH` can be specified as can `HEIGHT` per ImageMagick's [geometry arguments](https://imagemagick.org/command-line-processing/#geometry&gsc.tab=0). In my case, since I want to style images to have consistent width, I can leave off the `xHEIGHT`, and ImageMagick will preserve the aspect ratio while resizing the width.

Here is a raw test image I took near [San Pedro de Atacama](https://en.wikipedia.org/wiki/San_Pedro_de_Atacama), uploaded straight from my Google Photos:

![san_pedro_raw](/images/2026/image_optimization/san_pedro.jpg)

Feels bad to burn the 2.9MB of the above photo just for this example, but hopefully it provides a good comparison to dial in the resizing script.

At its biggest, the CSS styling limits width to 780 pixels, compared to the original photo's 1780 pixels. By running:

~~~
magick mogrify  -adaptive-resize 780 *.jpg
~~~

I get the following:

![san_pedro_780](/images/2026/image_optimization/san_pedro_780.jpg)

The above image is, astonishingly, 0.26MB. An order of magnitude reduction in file size for almost no perceivable quality loss! Compression artifacts are really only noticeable upon zoom in.

Can do the same trick to get the thumbnail for this entry, which renders at max 140 pixels wide:

~~~
magick mogrify  -adaptive-resize 140 *.jpg
~~~

![san_pedro_140](/images/2026/image_optimization/san_pedro_140.jpg)

0.07MB, that'll do.

## Update 8/29/2026
I don't like the thumbnail resize from above. Found out ImageMagick actually has a thumbnail function, so switched out a bunch of thumbnails using:

~~~
magick mogrify  -thumbnail 140 *.jpg
~~~

It's a slight improvement, less visible pixel artifacts.