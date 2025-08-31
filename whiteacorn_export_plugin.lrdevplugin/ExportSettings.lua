
ExportSettings = {}
local function commonSettings()
        local settings = {}
    settings.LR_DNG_compatibility_v13_0 = 268435456
    settings.LR_DNG_lossyCompression = false
    settings.LR_DNG_previewSize = "medium"
    settings.LR_DNG_conversionMethod = "preserveRAW"
    settings.LR_DNG_compressed = true
    settings.LR_DNG_embedRAW = false
    settings.LR_DNG_embedCache = true

    settings.LR_tiff_compressionMethod = "compressionMethod_None"
    settings.LR_tiff_preserveTransparency = false

    --settings.WX_require_album_name_field = false
    settings.LR_canExportVideo = false
    settings.LR_avif_quality = 0.7
    settings.LR_export_videoPreset = "original"
    settings.LR_includeVideoFiles = true
    settings.LR_includeFaceTagsInIptc = true
    settings.LR_exportServiceProviderTitle = "Whiteacorn Export"
    settings.LR_jxl_losslessQuality = false
    settings.LR_jxl_quality = 0.7
    settings.LR_export_videoFormat = "4e49434b-4832-3634-fbfb-fbfbfbfbfbfb"
    settings.LR_export_videoFileHandling = "exclude"

    settings.LR_ui_enableResolution = true
    settings.LR_includeFaceTagsAsKeywords = true

    ------------------------------------------------------------------------------
    -- Must have
    settings.hasError = false
    settings.LR_canExport = true

    -- Location
    settings.LR_export_destinationType = "specificFolder"
    settings.LR_export_useSubfolder = false
    settings.LR_export_destinationPathSuffix = "Images"
    -- settings.LR_export_destinationPathPrefix = wxprefs.WX_imagesOutputDir
    settings.LR_collisionHandling = "ask"
    settings.LR_extensionCase = "lowercase"
    settings.LR_reimportExportedPhoto = false
    settings.LR_reimport_stackWithOriginal_position = "below"
    settings.LR_reimport_stackWithOriginal = false

    -- File naming
    settings.LR_renamingTokensOn = true
    settings.LR_tokenCustomString = "pict"
    -- settings.LR_initialSequenceNumber = wxprefs.WX_renaming_start_number
    -- settings.LR_tokens = "pict-{{naming_sequenceNumber_4Digits}}"

    -- Video

    -- File Settings
    settings.LR_format = "JPEG"
    settings.LR_jpeg_useLimitSize = false
    settings.LR_jpeg_limitSize = 100
    settings.LR_export_colorSpace = "AdobeRGB"
    settings.LR_jpeg_quality = 0.9
    settings.LR_enableHDRDisplay = false
    settings.LR_maximumCompatibility = false
    settings.LR_ui_enableBitDepth = true
    settings.LR_export_bitDepth = 8

    -- Image sizing
    settings.LR_size_doConstrain = true
    settings.LR_ui_enableConstrain = true
    settings.LR_size_megapixels = 5
    settings.LR_size_resizeType = "longEdge"
    settings.LR_size_doNotEnlarge = false
    settings.LR_ui_enableSizeDontEnlarge = true
    -- settings.LR_size_maxWidth = 2000
    -- settings.LR_size_maxHeight = 2000
    settings.LR_size_resolution = 300
    settings.LR_size_units = "pixels"
    settings.LR_size_resolutionUnits = "inch"

    -- Output sharpening
    settings.LR_outputSharpeningOn = true
    settings.LR_outputSharpeningLevel = 2
    settings.LR_outputSharpeningMedia = "screen"

    -- Metadata
    settings.LR_removeLocationMetadata = true
    settings.LR_metadata_keywordOptions = "flat"
    settings.LR_removeFaceMetadata = true
    settings.LR_ui_enableEmbeddedMetadataOption = true
    settings.LR_embeddedMetadataOption = "all"

    -- Watermarking
    settings.LR_ui_enableWatermark = true
    settings.LR_useWatermark = false
    settings.LR_watermarking_id = "<simpleCopyrightWatermark>"

    -- Post processing
    settings.LR_export_postProcessing = "doNothing"
    return settings

end
function ExportSettings.setLargeImages(wxprefs)
    local settings = commonSettings()
    settings.LR_export_destinationPathPrefix = wxprefs.WX_imagesOutputDir
    settings.LR_tokenCustomString = "pict"
    settings.LR_initialSequenceNumber = wxprefs.WX_renaming_start_number
    settings.LR_tokens = "pict-{{naming_sequenceNumber_4Digits}}"
    settings.LR_size_maxWidth = 2000
    settings.LR_size_maxHeight = 2000
    settings.LR_size_resolution = 300
    return settings
end
function ExportSettings.setThumbnails(wxprefs)
    local settings = commonSettings()
    settings.LR_export_destinationPathPrefix = wxprefs.WX_thumbnailsOutputDir
    settings.LR_initialSequenceNumber = wxprefs.WX_renaming_start_number
    settings.LR_tokens = "pict-{{naming_sequenceNumber_4Digits}}"
    settings.LR_size_maxWidth = 100
    settings.LR_size_maxHeight = 150
    settings.LR_size_resolution = 300
    return settings
end
function ExportSettings.setMascots(wxprefs)
    local settings = commonSettings()
    settings.LR_export_destinationPathPrefix = wxprefs.WX_mascotsOutputDir
    settings.LR_tokens = "mascot-{{naming_sequenceNumber_2Digits}}"
    settings.LR_size_resizeType = "longEdge"
    settings.LR_size_maxWidth = 560
    settings.LR_size_maxHeight = 420
    return settings
end
return ExportSettings