require "PrintUtils"

UpdateLrExportSettings = {}

function UpdateLrExportSettings.update(propertyTable)
	PrintUtils.message('updateExportSettings')
	propertyTable.LR_export_colorSpace = "AdobeRGB"
	propertyTable.LR_jpeg_quality = 0.90
	propertyTable.LR_format = "JPEG"
	propertyTable.LR_jpeg_useLimitSize = false
	propertyTable.LR_enableHDRDisplay = false
	propertyTable.LR_export_bitDepth = 8
	propertyTable.LR_maximumCompatibility = false

	propertyTable.LR_useWatermark = false
	propertyTable.LR_watermarking_id = "<simpleCopyrightWatermark>"

	propertyTable.LR_outputSharpeningOn = true
	propertyTable.LR_outputSharpeningLevel = 2
	propertyTable.LR_outputSharpeningMedia = "screen"

	propertyTable.LR_renamingTokensOn = true
	propertyTable.LR_tokens = "apict-{{naming_sequenceNumber_2Digits}}"
	propertyTable.LR_tokenCustomString = "pict"
	propertyTable.LR_initialSequenceNumber = 200

	propertyTable.LR_size_resizeType = "longEdge"
	propertyTable.LR_size_units = "pixels"
	propertyTable.LR_size_resolutionUnits = "inch"
	propertyTable.LR_size_maxWidth = 1111
	propertyTable.LR_size_doConstrain = true
	propertyTable.LR_size_maxHeight = 2222
	propertyTable.LR_size_resolution = 240
	propertyTable.LR_ui_enableSizeDoNotEnlarge = true

end
return UpdateLrExportSettings