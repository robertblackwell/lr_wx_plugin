require "ExportDialogSections"
require "ExportTask"
require "UpdateLrExportSettings"
require "Constants"

return {
	-- hide or restrict sections of the standard Lightroom export dialog
	hideSections = { 'video', 'exportLocation', 'fileSettings', 'watermarking', 'metadata', 'outputSharpening', 'fileNaming', "imageSettings" },
	-- hideSections = { 'video', 'fileSettings', 'watermarking', 'metadata', 'outputSharpening', 'fileNaming', "imageSettings" },
	allowFileFormats = {'JPEG'}, -- nil equates to all available formats
	canExportVideo = false,
	allowColorSpaces = {'AdobeRGB'}, -- nil equates to all color 
	
	-- define the keys that represent plugin parameters that will be used in an export operation
	-- initiated by this plugin
	exportPresetFields = {
		{ key = 'WX_outputDir', default = nil},
		{ key = 'WX_exportPrefix', default = '/Users/robertblackwell/LrPlugins/TestExports' },
		{ key = 'WX_exportFolder', default = 'photos2'},
		{ key = 'WX_synopsis', default = 'Export photo albums for whiteacorn.com website'},
		{ key = 'WX_albumType', default = Constants.AlbumTypes.journal },
		{ key = 'WX_imageType', default = Constants.ImageTypes.large},
		{ key = 'WX_slug', default = "SLUG"},
		{ key = 'WX_journal_album_name', default = Constants.default_journal_album_name},
		{ key = "WX_addToExisting", default = false},

		-- derived export parameters
		{ key = 'WX_require_album_name_field', default = false},
		{ key = 'WX_is_journal', default = true},
		{ key = 'WX_is_not_journal', default = false},
	},
	startDialog = ExportDialogSections.startDialog,
	sectionsForTopOfDialog = ExportDialogSections.sectionsForTopOfDialog,
	updateExportSettings = UpdateLrExportSettings.update,
	processRenderedPhotos = ExportTask.processRenderedPhotos,
}
