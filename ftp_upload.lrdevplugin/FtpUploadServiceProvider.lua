--[[----------------------------------------------------------------------------

FtpUploadExportServiceProvider.lua
Export service provider description for Lightroom FtpUpload uploader

--------------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2007 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

------------------------------------------------------------------------------]]

-- FtpUpload plug-in
require "FtpUploadExportDialogSections"
require "FtpUploadTask"


--============================================================================--

return {
	
	hideSections = { 'video', 'exportLocation', 'fileSettings', 'watermarking', 'metadata', 'outputSharpening', 'fileNaming', "imageSettings" },

	allowFileFormats = {'JPEG'}, -- nil equates to all available formats
	canExportVideo = false,
	allowColorSpaces = {'AdobeRGB'}, -- nil equates to all color spaces

	exportPresetFields = {
		{ key = 'WX_exportPrefix', default = '/Users/robertblackwell/LrPlugins/TestExports' },
		{ key = 'WX_exportFolder', default = 'photos2'},
		{ key = 'putInSubfolder', default = false },
		{ key = 'path', default = 'photos' },
		{ key = "ftpPreset", default = nil },
		{ key = "fullPath", default = nil },
	},
	updateExportSettings = FtpUploadExportDialogSections.updateExportSettings,
	startDialog = FtpUploadExportDialogSections.startDialog,
	sectionsForTopOfDialog = FtpUploadExportDialogSections.sectionsForTopOfDialog,
	
	processRenderedPhotos = FtpUploadTask.processRenderedPhotos,
	
}
