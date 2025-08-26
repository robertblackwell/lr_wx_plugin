require "ExportDialogSections"
require "ExportTask"
require "UpdateLrExportSettings"

return {
	
	hideSections = { 'video', 'exportLocation', 'fileSettings', 'watermarking', 'metadata', 'outputSharpening', 'fileNaming', "imageSettings" },

	allowFileFormats = {'JPEG'}, -- nil equates to all available formats
	canExportVideo = false,
	allowColorSpaces = {'AdobeRGB'}, -- nil equates to all color spaces

	exportPresetFields = {
		{ key = 'WX_exportPrefix', default = '/Users/robertblackwell/LrPlugins/TestExports' },
		{ key = 'WX_exportFolder', default = 'photos2'},
		{ key = 'WX_synopsis', default = 'Export photos for whiteacorn.com website'},
		{ key = 'putInSubfolder', default = false },
		{ key = 'path', default = 'photos' },
		{ key = "ftpPreset", default = nil },
		{ key = "fullPath", default = nil },
	},
	startDialog = ExportDialogSections.startDialog,
	sectionsForTopOfDialog = ExportDialogSections.sectionsForTopOfDialog,
	updateExportSettings = UpdateLrExportSettings.update,
	processRenderedPhotos = ExportTask.processRenderedPhotos,
	
}
