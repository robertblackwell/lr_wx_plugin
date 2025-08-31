# Lightroom Classic Export plugins

This project has 3 Lightroom Classic plugins whose purpose is to assist in the export 
of photo albums for one of my web sites.

## website background and objective

The website in question is a blog and photos are used extensively in individual blog posts,
and in addition the site includes photo galleries that are independent of posts.

For both posts and photo galleries photos are required in two formats:

-   thumbnail images small enough to be displyed in a grid
-   larger images to be dispayed individually as a viewer moves from one image to another.

In each case these images must be exported from lightroom with specific sizing, format, quality and sequential 
naming in order that they appear "right, and in the right order".

In each case the all the requirements for the images can be elaborated as a Lightroom Export Preset
except for the the destination folder which typically changes for each post and album. 

The path to the destination folder is derived from specific features of the blog site and must, currently,
be manually entered for every export operation.

The goal of this project is to have a LrClassic plugin that:

-   automatically confgures export preset values to get the right image sizing, format, quality and renaming scheme 
in a way that it cannot be accidentally modified by a LR user.

-   caculates the destination folder path from the `slug` for a blog post or photo album combined with whether the export is 
for __thumbnails__ or __larger images__ and a small number of other things that are not "Lightroom things".

An additional wrinkle is that photo albums require a third type of image called a __mascot__ which is displayed as a 
representative of a photo gallery on a page the presents all photo galleries. This image has sizing, format and naming requirements 
that are different to __thumbnails__ or __larger_images__.

## whiteacorn_export_service

Based on what I read on the internet my first effort to build a lrplugin to meet my goals followed the 
path of building a LrClassic Export Service Provider. That is the solution contained in the folder
__whiteacorn_export_service.lrdevplugin__.

It is invoked as part of the normal Lightroom export work flow.

I was somewhat disatisfied with this solution as it required invoking the export process 2 times for a photo album without 
a mascot photo and 3 times when mascots were involved. Thats because an Export Service Provider does the actual export processing
"behind the scenes".

## whiteacorn_export_plugin

During my reading of the LrClassic SDK I came across LrExportSession which promised the possibility of having direct control
over the export process; and so it turned out.

This plugin adds an entry to the __File -> Plug-in Extras__ menu, shows a form to gather enough parameters to specify the
export requirements of both large images and thumbnails and then exports both sets of images in a single step.

For my purposes this is a much better solution.

## export_dump_service

The development of the previous 2 plugins require working out what properties and keys were present on the Lightroom export settings
table and moreover what values those propserties had to have. To investigate that question I developed __export_dump_service/lrdevplugin__.
This plugin, which follows the patter of a Lightroom Export Service Provider, lets you set the various sections 
of the Export Dialog to whatever values you want and then dumps the export settings table to the file 

```
$HOME/Library/Logs/Lightroom/LrClassic/ExportDumpService.log 
```

Its a very useful tools for working oout how to programatically give the desired parameters to an export operation.