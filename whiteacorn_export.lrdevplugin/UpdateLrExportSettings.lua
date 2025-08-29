require "Utils"

UpdateLrExportSettings = {}
local function updateImageSizing(propertyTable)
	propertyTable.LR_size_resizeType = "longEdge"
	propertyTable.LR_size_units = "pixels"
	propertyTable.LR_size_resolutionUnits = "inch"
	propertyTable.LR_size_doConstrain = true
	propertyTable.LR_size_resolution = 240
	propertyTable.LR_ui_enableSizeDoNotEnlarge = true
    if propertyTable.WX_imageType == Constants.ImageTypes.large then
    	propertyTable.LR_size_resizeType = "longEdge"
        propertyTable.LR_size_maxWidth = 1000
	    propertyTable.LR_size_maxHeight = 2000
    elseif propertyTable.WX_imageType == Constants.ImageTypes.thumbnails then
    	propertyTable.LR_size_resizeType = "longEdge"
        propertyTable.LR_size_maxWidth = 100
	    propertyTable.LR_size_maxHeight = 150
    elseif propertyTable.WX_imageType == Constants.ImageTypes.mascot then
    	propertyTable.LR_size_resizeType = "wh"
        propertyTable.LR_size_maxWidth = 280
	    propertyTable.LR_size_maxHeight = 210
    end
end
local function updateImageSettings(propertyTable)
	propertyTable.LR_export_colorSpace = "AdobeRGB"
	propertyTable.LR_jpeg_quality = 0.90
	propertyTable.LR_format = "JPEG"
	propertyTable.LR_jpeg_useLimitSize = false
	propertyTable.LR_enableHDRDisplay = false
	propertyTable.LR_export_bitDepth = 8
	propertyTable.LR_maximumCompatibility = false
end
local function updateOutputSharpening(propertyTable)
	propertyTable.LR_outputSharpeningOn = true
	propertyTable.LR_outputSharpeningLevel = 2
	propertyTable.LR_outputSharpeningMedia = "screen"
end
local function updateFileNaming(propertyTable)
	propertyTable.LR_renamingTokensOn = true
	if propertyTable.WX_imageType == Constants.ImageTypes.mascot then
		propertyTable.LR_tokens = "mascot-{{naming_sequenceNumber_2Digits}}"
		propertyTable.LR_tokenCustomString = "mascot"
		propertyTable.LR_initialSequenceNumber = 1
	else
		propertyTable.LR_tokens = "pict-{{naming_sequenceNumber_4Digits}}"
		propertyTable.LR_tokenCustomString = "pict"
		if propertyTable.WX_addToExisting then
			propertyTable.LR_initialSequenceNumber = 200
		else
			propertyTable.LR_initialSequenceNumber = 1
		end
	end
end
function UpdateLrExportSettings.update(propertyTable)
	Utils.message('updateExportSettings')
	updateImageSettings(propertyTable)
	-- propertyTable.LR_export_colorSpace = "AdobeRGB"
	-- propertyTable.LR_jpeg_quality = 0.90
	-- propertyTable.LR_format = "JPEG"
	-- propertyTable.LR_jpeg_useLimitSize = false
	-- propertyTable.LR_enableHDRDisplay = false
	-- propertyTable.LR_export_bitDepth = 8
	-- propertyTable.LR_maximumCompatibility = false

	propertyTable.LR_useWatermark = false
	propertyTable.LR_watermarking_id = "<simpleCopyrightWatermark>"

	updateOutputSharpening(propertyTable)
	-- propertyTable.LR_outputSharpeningOn = true
	-- propertyTable.LR_outputSharpeningLevel = 2
	-- propertyTable.LR_outputSharpeningMedia = "screen"

	updateFileNaming(propertyTable)
	-- propertyTable.LR_renamingTokensOn = true
	-- propertyTable.LR_tokens = "apict-{{naming_sequenceNumber_2Digits}}"
	-- propertyTable.LR_tokenCustomString = "pict"
	-- propertyTable.LR_initialSequenceNumber = 200

	updateImageSizing(propertyTable)
	-- propertyTable.LR_size_resizeType = "longEdge"
	-- propertyTable.LR_size_units = "pixels"
	-- propertyTable.LR_size_resolutionUnits = "inch"
	-- propertyTable.LR_size_maxWidth = 1111
	-- propertyTable.LR_size_doConstrain = true
	-- propertyTable.LR_size_maxHeight = 2222
	-- propertyTable.LR_size_resolution = 240
	-- propertyTable.LR_ui_enableSizeDoNotEnlarge = true

end
return UpdateLrExportSettings