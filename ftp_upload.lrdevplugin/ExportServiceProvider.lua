require "ExportDialogSections"
require "ExportTask"
require "UpdateLrExportSettings"
require "Constants"

return {
	hideSections = { 'video', 'exportLocation', 'fileSettings', 'watermarking', 'metadata', 'outputSharpening', 'fileNaming', "imageSettings" },
	allowFileFormats = {'JPEG'}, -- nil equates to all available formats
	canExportVideo = false,
	allowColorSpaces = {'AdobeRGB'}, -- nil equates to all color spaces
	exportPresetFields = {
		{ key = 'WX_outputDir', default = nil},
		{ key = 'WX_exportPrefix', default = '/Users/robertblackwell/LrPlugins/TestExports' },
		{ key = 'WX_exportFolder', default = 'photos2'},
		{ key = 'WX_synopsis', default = 'Export photo albums for whiteacorn.com website'},
		{ key = 'WX_albumType', default = Constants.AlbumTypes.journal },
		{ key = 'WX_imageType', default = Constants.ImageTypes.large},
		{ key = 'WX_slug', default = "SLUG"},
		{ key = 'WX_journal_album_name', default = Constants.default_journal_album_name},

		-- derived export parameters
		{ key = 'WX_require_album_name_field', default = false},
		{ key = 'WX_is_journal', default = true},
		{ key = 'WX_is_not_journal', default = false},

		-- { key = 'putInSubfolder', default = false },
		-- { key = 'path', default = 'photos' },
		-- { key = "ftpPreset", default = nil },
		-- { key = "fullPath", default = nil },
	},
	startDialog = ExportDialogSections.startDialog,
	sectionsForTopOfDialog = ExportDialogSections.sectionsForTopOfDialog,
	updateExportSettings = UpdateLrExportSettings.update,
	processRenderedPhotos = ExportTask.processRenderedPhotos,
}
