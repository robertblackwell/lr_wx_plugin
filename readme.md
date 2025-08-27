# Lightroom Classic Export plugin

This project is Lightroom Classic plugin in the form of an __Export Service Provider__ 
to make it easier to export photos from LrClassic for one of my web sites.

The website in question is a blog and photos are used extensively in individual blog posts,
and in addition the site includes photo galleries that are independent of posts.

For both posts and photo galleries photos are required in two formats:

-   thumbnail images small enough to be displyed in a grid
-   larger images to be dispayed individually as a viewer moves from one image to another.

In each case these images must be exported from lightroom with specific sizing, format and quality and sequential 
naming in order that they appear "in the right order".

In each case the all the requirements for the images can be elaborated as a Lightroom Export Preset
except for the the destination folder. 

The path to the destination folder is derived from specific features of the blog site and must, currently,
be manually entered for every export operation.

The goal of this project is to have a LrClassic plugin that:

-   automatically confgures export preset values to get the right image sizing, format, quality and renaming scheme 
in a way that it cannot be accidentally modified by a LR user.

-   caculates the destination folder path from the `slug` for a blog post or photo album combined with whether the export is 
for __thumbnails__ or __larger images__.

An additional wrinkle is that photo albums require a third type of image called a __mascot__ which is displayed as a 
representative of a photo gallery on a page the presents all photo galleries. This image has sizing, format and naming requirements 
that are different to __thumbnails__ or __larger_images__.