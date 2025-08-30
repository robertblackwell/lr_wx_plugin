local LrDialogs = import 'LrDialogs'
local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'
local LrExportSession = import 'LrExportSession'
local LrView = import 'LrView'
local LrPrefs = import 'LrPrefs'
local LrFileUtils = import 'LrFileUtils'

require "Utils"
require "Constants"
require "ExportSettings"
require "UI"

local WX_prefs = LrPrefs and LrPrefs.prefsForPlugin()

local function assignIfNil(key, value)
	Utils.message("assignIfNil key: " .. (key and 1 or 0) .. " value: " .. (value and 1 or 0) )
	if WX_prefs[key] == nil then 
		WX_prefs[key] = value
	end
end

--Initialises the prefs table only if a key does not already have a value. 
local function initPrefs()
	if WX_prefs.WX_exportPrefix ~= nil then
		return
	end
	WX_prefs.WX_exportPrefix = "/Volumes/current_trip"
	WX_prefs.WX_tab_id = Constants.TabId.journalTab
	WX_prefs.WX_slug = "SLUG"
	WX_prefs.WX_journal_album_type = Constants.AlbumTypes.journal
	WX_prefs.WX_journal_album_name = "JNAME"
	WX_prefs.WX_require_journal_album_name = false
	WX_prefs.WX_renaming_start_number = 1

	-- assignIfNil(WX_prefs.WX_exportPrefix, "/Volumes/current_trip")
	-- assignIfNil(WX_prefs.WX_tab_id, Constants.TabId.journalTab)
	-- assignIfNil(WX_prefs.WX_slug, "SLUG")
	-- assignIfNil(WX_prefs.WX_journal_album_type, Constants.AlbumTypes.journal)
	-- assignIfNil(WX_prefs.WX_journal_album_name, "JNAME")
	-- assignIfNil(WX_prefs.WX_require_journal_album_name, false)
	-- assignIfNil(WX_prefs.WX_naming_start_number, 1)
end

-- local function setSession1(propertyTable)

--     propertyTable.LR_DNG_compatibility_v13_0 = 268435456
--     propertyTable.LR_DNG_lossyCompression = false
--     propertyTable.LR_DNG_previewSize = "medium"
--     propertyTable.LR_DNG_conversionMethod = "preserveRAW"
--     propertyTable.LR_DNG_compressed = true
--     propertyTable.LR_DNG_embedRAW = false
--     propertyTable.LR_DNG_embedCache = true

--     propertyTable.LR_tiff_compressionMethod = "compressionMethod_None"
--     propertyTable.LR_tiff_preserveTransparency = false

--     --propertyTable.WX_require_album_name_field = false
--     propertyTable.LR_canExportVideo = false
--     propertyTable.LR_avif_quality = 0.7
--     propertyTable.LR_export_videoPreset = "original"
--     propertyTable.LR_includeVideoFiles = true
--     propertyTable.LR_includeFaceTagsInIptc = true
--     propertyTable.LR_exportServiceProviderTitle = "Whiteacorn Export"
--     propertyTable.LR_jxl_losslessQuality = false
--     propertyTable.LR_jxl_quality = 0.7
--     propertyTable.LR_export_videoFormat = "4e49434b-4832-3634-fbfb-fbfbfbfbfbfb"
--     propertyTable.LR_export_videoFileHandling = "exclude"

--     propertyTable.LR_ui_enableResolution = true
--     propertyTable.LR_includeFaceTagsAsKeywords = true

--     ------------------------------------------------------------------------------
--     -- Must have
--     propertyTable.hasError = false
--     propertyTable.LR_canExport = true

--     -- Location
--     propertyTable.LR_export_destinationType = "specificFolder"
--     propertyTable.LR_export_useSubfolder = true
--     propertyTable.LR_export_destinationPathSuffix = "TestImage01"
--     propertyTable.LR_export_destinationPathPrefix = "/Users/robertblackwell/LrPlugins"
--     propertyTable.LR_collisionHandling = "ask"
--     propertyTable.LR_extensionCase = "lowercase"
--     propertyTable.LR_reimportExportedPhoto = false
--     propertyTable.LR_reimport_stackWithOriginal_position = "below"
--     propertyTable.LR_reimport_stackWithOriginal = false

--     -- File naming
--     propertyTable.LR_renamingTokensOn = true
--     propertyTable.LR_tokenCustomString = "pict"
--     propertyTable.LR_initialSequenceNumber = 50
--     propertyTable.LR_tokens = "xpict-{{naming_sequenceNumber_4Digits}}"

--     -- Video

--     -- File Settings
--     propertyTable.LR_format = "JPEG"
--     propertyTable.LR_jpeg_useLimitSize = false
--     propertyTable.LR_jpeg_limitSize = 100
--     propertyTable.LR_export_colorSpace = "AdobeRGB"
--     propertyTable.LR_jpeg_quality = 0.9
--     propertyTable.LR_enableHDRDisplay = false
--     propertyTable.LR_maximumCompatibility = false
--     propertyTable.LR_ui_enableBitDepth = true
--     propertyTable.LR_export_bitDepth = 8

--     -- Image sizing
--     propertyTable.LR_size_doConstrain = true
--     propertyTable.LR_ui_enableConstrain = true
--     propertyTable.LR_size_megapixels = 5
--     propertyTable.LR_size_resizeType = "longEdge"
--     propertyTable.LR_size_doNotEnlarge = false
--     propertyTable.LR_ui_enableSizeDontEnlarge = true
--     propertyTable.LR_size_maxWidth = 100
--     propertyTable.LR_size_maxHeight = 150
--     propertyTable.LR_size_resolution = 240
--     propertyTable.LR_size_units = "pixels"
--     propertyTable.LR_size_resolutionUnits = "inch"

--     -- Output sharpening
--     propertyTable.LR_outputSharpeningOn = true
--     propertyTable.LR_outputSharpeningLevel = 2
--     propertyTable.LR_outputSharpeningMedia = "screen"

--     -- Metadata
--     propertyTable.LR_removeLocationMetadata = true
--     propertyTable.LR_metadata_keywordOptions = "flat"
--     propertyTable.LR_removeFaceMetadata = true
--     propertyTable.LR_ui_enableEmbeddedMetadataOption = true
--     propertyTable.LR_embeddedMetadataOption = "all"

--     -- Watermarking
--     propertyTable.LR_ui_enableWatermark = true
--     propertyTable.LR_useWatermark = false
--     propertyTable.LR_watermarking_id = "<simpleCopyrightWatermark>"

--     -- Post processing
--     propertyTable.LR_export_postProcessing = "doNothing"

-- end
-- local function setSession2(propertyTable)

--     propertyTable.LR_DNG_compatibility_v13_0 = 268435456
--     propertyTable.LR_DNG_lossyCompression = false
--     propertyTable.LR_DNG_previewSize = "medium"
--     propertyTable.LR_DNG_conversionMethod = "preserveRAW"
--     propertyTable.LR_DNG_compressed = true
--     propertyTable.LR_DNG_embedRAW = false
--     propertyTable.LR_DNG_embedCache = true

--     propertyTable.LR_tiff_compressionMethod = "compressionMethod_None"
--     propertyTable.LR_tiff_preserveTransparency = false

--     --propertyTable.WX_require_album_name_field = false
--     propertyTable.LR_canExportVideo = false
--     propertyTable.LR_avif_quality = 0.7
--     propertyTable.LR_export_videoPreset = "original"
--     propertyTable.LR_includeVideoFiles = true
--     propertyTable.LR_includeFaceTagsInIptc = true
--     propertyTable.LR_exportServiceProviderTitle = "Whiteacorn Export"
--     propertyTable.LR_jxl_losslessQuality = false
--     propertyTable.LR_jxl_quality = 0.7
--     propertyTable.LR_export_videoFormat = "4e49434b-4832-3634-fbfb-fbfbfbfbfbfb"
--     propertyTable.LR_export_videoFileHandling = "exclude"

--     propertyTable.LR_ui_enableResolution = true
--     propertyTable.LR_includeFaceTagsAsKeywords = true

--     ------------------------------------------------------------------------------
--     -- Must have
--     propertyTable.hasError = false
--     propertyTable.LR_canExport = true

--     -- Location
--     propertyTable.LR_export_destinationType = "specificFolder"
--     propertyTable.LR_export_useSubfolder = true
--     propertyTable.LR_export_destinationPathSuffix = "TestImage02"
--     propertyTable.LR_export_destinationPathPrefix = "/Users/robertblackwell/LrPlugins"
--     propertyTable.LR_collisionHandling = "ask"
--     propertyTable.LR_extensionCase = "lowercase"
--     propertyTable.LR_reimportExportedPhoto = false
--     propertyTable.LR_reimport_stackWithOriginal_position = "below"
--     propertyTable.LR_reimport_stackWithOriginal = false

--     -- File naming
--     propertyTable.LR_renamingTokensOn = true
--     propertyTable.LR_tokenCustomString = "pict"
--     propertyTable.LR_initialSequenceNumber = 50
--     propertyTable.LR_tokens = "xpict-{{naming_sequenceNumber_4Digits}}"

--     -- Video

--     -- File Settings
--     propertyTable.LR_format = "JPEG"
--     propertyTable.LR_jpeg_useLimitSize = false
--     propertyTable.LR_jpeg_limitSize = 100
--     propertyTable.LR_export_colorSpace = "AdobeRGB"
--     propertyTable.LR_jpeg_quality = 0.9
--     propertyTable.LR_enableHDRDisplay = false
--     propertyTable.LR_maximumCompatibility = false
--     propertyTable.LR_ui_enableBitDepth = true
--     propertyTable.LR_export_bitDepth = 8

--     -- Image sizing
--     propertyTable.LR_size_doConstrain = true
--     propertyTable.LR_ui_enableConstrain = true
--     propertyTable.LR_size_megapixels = 5
--     propertyTable.LR_size_resizeType = "longEdge"
--     propertyTable.LR_size_doNotEnlarge = false
--     propertyTable.LR_ui_enableSizeDontEnlarge = true
--     propertyTable.LR_size_maxWidth = 100
--     propertyTable.LR_size_maxHeight = 150
--     propertyTable.LR_size_resolution = 240
--     propertyTable.LR_size_units = "pixels"
--     propertyTable.LR_size_resolutionUnits = "inch"

--     -- Output sharpening
--     propertyTable.LR_outputSharpeningOn = true
--     propertyTable.LR_outputSharpeningLevel = 2
--     propertyTable.LR_outputSharpeningMedia = "screen"

--     -- Metadata
--     propertyTable.LR_removeLocationMetadata = true
--     propertyTable.LR_metadata_keywordOptions = "flat"
--     propertyTable.LR_removeFaceMetadata = true
--     propertyTable.LR_ui_enableEmbeddedMetadataOption = true
--     propertyTable.LR_embeddedMetadataOption = "all"

--     -- Watermarking
--     propertyTable.LR_ui_enableWatermark = true
--     propertyTable.LR_useWatermark = false
--     propertyTable.LR_watermarking_id = "<simpleCopyrightWatermark>"

--     -- Post processing
--     propertyTable.LR_export_postProcessing = "doNothing"

-- end
local function handleUIUpdate(wxPropertyTable, key, value)
	Utils.message("this is handleUIUpdate key: " .. key .. " WX_tab_id: " .. WX_prefs.WX_tab_id)
	Utils.message("handleUIUpdate WX_journal_album_name: " .. WX_prefs.WX_journal_album_name)
	Utils.message("handleUIUpdate WX_require_journal_album_name: " .. (WX_prefs.WX_require_journal_album_name and 1 or 0) )

	WX_prefs.WX_require_journal_album_name = (WX_prefs.WX_journal_album_type == Constants.AlbumTypes.named_journal)
	if WX_prefs.WX_tab_id == Constants.TabId.journalTab then
		if WX_prefs.WX_journal_album_type == Constants.AlbumTypes.named_journal then
			WX_prefs.WX_imagesOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "content", WX_prefs.WX_slug, WX_prefs.WX_journal_album_name, "Images")
			WX_prefs.WX_thumbnailsOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "content", WX_prefs.WX_slug, WX_prefs.WX_journal_album_name, "Thumbnails")
		else
			WX_prefs.WX_imagesOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "content", WX_prefs.WX_slug, "Images")
			WX_prefs.WX_thumbnailsOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "content", WX_prefs.WX_slug, "Thumbnails")
		end
	elseif WX_prefs.WX_tab_id == Constants.TabId.photoTab then
		WX_prefs.WX_imagesOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "photos", "galleries", WX_prefs.WX_slug, "Images")
		WX_prefs.WX_thumbnailsOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "photos", "galleries", WX_prefs.WX_slug, "Thumbnails")
	elseif WX_prefs.WX_tab_id == Constants.TabId.mascotTab then
		WX_prefs.WX_mascotsOutputDir = Utils.pathJoin(WX_prefs.WX_exportPrefix, "photos", "galleries", WX_prefs.WX_slug)
	end
	Utils.message("handleUIUpdate WX_imagesOutputDir: " .. WX_prefs.WX_imagesOutputDir)
	Utils.message("handleUIUpdate WX_imagesOutputDir: " .. WX_prefs.WX_thumbnailsOutputDir)
end
local function addObserverToUI()
	WX_prefs:addObserver('WX_tab_id', handleUIUpdate)
	WX_prefs:addObserver('WX_exportPrefix', handleUIUpdate)
	WX_prefs:addObserver('WX_slug', handleUIUpdate)
	WX_prefs:addObserver('WX_journal_album_type', handleUIUpdate)
	WX_prefs:addObserver('WX_journal_album_name', handleUIUpdate)
	WX_prefs:addObserver('WX_require_journal_album_name', handleUIUpdate)
	WX_prefs:addObserver('WX_exportPrefix', handleUIUpdate)
	WX_prefs:addObserver('WX_renaming_start_number', handleUIUpdate)
end
local function ensure_dir_exists(dpath)
	if not LrFileUtils.exists(dpath) then 
		LrFileUtils.createAllDirectories(dpath)
	end
end
local function wx_main( exportContext )
    LrTasks.startAsyncTask(function()
		initPrefs()
		addObserverToUI()
        Utils.message("before dialog box")
        LrDialogs.message( "Hello World!", "Your first Lightroom Classic plugin is working!" )
        local result = LrDialogs.presentModalDialog(UI.form(WX_prefs))
        if result == "cancel" then
            LrDialogs.message( "Form cancelled" )
            return
        end
        Utils.message("after dialog box")
		-- got here so we have an export to do for one of journals, photoalbum or mascots
		-- 1. get the selected photos
        local catalog = LrApplication.activeCatalog()
        Utils.message("after get catalog")
        if not catalog then
            Utils.message("catalog is nil")
            return true
        end
        Utils.dumpTable(catalog, 4)
        local selectedPhotos = catalog:getAllPhotos()
        local p = selectedPhotos[1]
        local pname = p:getFormattedMetadata('fileName')
        Utils.message("after selected photos - got " .. #selectedPhotos .. 'first one: ' .. pname)
        
        for index, photo in ipairs(selectedPhotos) do
            Utils.message("Element at index " .. index .. ": " .. photo:getFormattedMetadata('fileName'))
        end
		-- now process the export depending on whether its a journal, photo album or mascot
        -- local large_image_settings = {}
        -- local thumbnail_settings = {}
		-- local mascot_settings = {}
		if WX_prefs.WX_tab_id == Constants.TabId.journalTab then
			ensure_dir_exists(WX_prefs.WX_imagesOutputDir)
			ensure_dir_exists(WX_prefs.WX_thumbnailsOutputDir)
	        local large_image_settings = ExportSettings.setLargeImages(WX_prefs)
    	    local thumbnail_settings = ExportSettings.setThumbnails(WX_prefs)
	        local large_image_session = LrExportSession({photosToExport = selectedPhotos, exportSettings = large_image_settings})
    	    local thumbnail_session = LrExportSession({photosToExport = selectedPhotos, exportSettings = thumbnail_settings})
        	large_image_session:doExportOnNewTask()
        	thumbnail_session:doExportOnCurrentTask()

		elseif WX_prefs.WX_tab_id == Constants.TabId.photoTab then
			ensure_dir_exists(WX_prefs.WX_imagesOutputDir)
			ensure_dir_exists(WX_prefs.WX_thumbnailsOutputDir)
	        local large_image_settings = ExportSettings.setLargeImages(WX_prefs)
    	    local thumbnail_settings = ExportSettings.setThumbnails(WX_prefs)
	        local large_image_session = LrExportSession({photosToExport = selectedPhotos, exportSettings = large_image_settings})
    	    local thumbnail_session = LrExportSession({photosToExport = selectedPhotos, exportSettings = thumbnail_settings})
        	large_image_session:doExportOnNewTask()
        	thumbnail_session:doExportOnCurrentTask()

		elseif WX_prefs.WX_tab_id == Constants.TabId.mascotTab then
			ensure_dir_exists(WX_prefs.WX_mascotsOutputDir)
	        local mascot_settings = ExportSettings.setMascots(WX_prefs)
	        local mascot_session = LrExportSession({photosToExport = selectedPhotos, exportSettings = mascot_settings})
        	mascot_session:doExportOnCurrentTask()
		end
        return true
    end)
end

wx_main({})