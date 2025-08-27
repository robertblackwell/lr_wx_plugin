
require 'Constants'

local LrView = import 'LrView'
local LrFtp = import 'LrFtp'

local function isEmpty(value) 
	return (value == nil or value == "")
end
local function notEmpty(value)
	return (value ~= "" and value ~= nil)
end

local function validImageAndAlbumTypes(imageType, albumType)
	PrintUtils.message("validImageAndAlbumType imageType: " .. imageType .. " albumType: " .. albumType)
	if (imageType == Constants.ImageTypes.mascot) and (albumType ~= Constants.AlbumTypes.photo) then
		return false
	end
	return true
end
local function pathJoin(...)
	return table.concat({...}, '/')
end
ExportDialogSections = {}

local function makeOutputDirPath(propertyTable)
	local outputPath = nil
	local pt = propertyTable
	if (notEmpty(pt.WX_exportPrefix) 
		and validImageAndAlbumTypes(pt.WX_imageType, pt.WX_albumType)
		and notEmpty(pt.WX_slug)) then

		-- if pt.WX_albumType == Constants.AlbumTypes.photo then
		-- 	PrintUtils.message("WX_albumType is equal to Constants.AlbumTypes.photo")
		-- end

		-- PrintUtils.message("Outter then WX_albumType: " .. pt.WX_albumType .. " WX_imageType: " .. pt.WX_imageType .. " " .. Constants.AlbumTypes.photo)

		if (pt.WX_albumType == Constants.AlbumTypes.named_journal) and (notEmpty(pt.WX_journal_album_name)) then
			-- PrintUtils.message("Leg 1 jounal named") 
			-- outputPath = "step 1" --pt.WX_exportPrefix .."/content/".. pt.WX_slug .. "/" .. pt.WX_journal_album_name .."/".. Constants.ImageTypes.toString(pt.WX_imageType)
			outputPath = pathJoin(pt.WX_exportPrefix, "content", pt.WX_slug, pt.WX_journal_album_name, Constants.ImageTypes.toString(pt.WX_imageType))
			-- PrintUtils.message("Leg 1 outputPath: ") 
		elseif (pt.WX_albumType == Constants.AlbumTypes.journal) then
			-- PrintUtils.message("Leg 2 jounal not named")
			-- outputPath = "step 2" -- pt.WX_exportPrefix .."/content/".. pt.WX_slug .. "/" .. Constants.ImageTypes.toString(pt.WX_imageType)
			outputPath = pathJoin(pt.WX_exportPrefix, "content", pt.WX_slug, Constants.ImageTypes.toString(pt.WX_imageType))
			-- PrintUtils.message("Leg 2 outputPath: ") 
		elseif (pt.WX_albumType == Constants.AlbumTypes.photo) and (pt.WX_imageType == Constants.ImageTypes.mascot) then
			-- PrintUtils.message("Leg 3 photo album mascot outputPath: ") 
			-- outputPath = "step 3" -- pt.WX_exportPrefix .."/photos/galleries/".. pt.WX_slug 
			outputPath = pathJoin(pt.WX_exportPrefix, "photos", "galleries", pt.WX_slug)
			-- PrintUtils.message("Leg 3 outputPath: " .. outputPath)
		elseif (pt.WX_albumType == Constants.AlbumTypes.photo) then
			-- PrintUtils.message("Leg 4 photo album not mascot outputPath: ") 
			-- outputPath = pt.WX_exportPrefix .."/photos/galleries/".. pt.WX_slug .. "/" .. Constants.ImageTypes.toString(pt.WX_imageType)
			outputPath = pathJoin(pt.WX_exportPrefix, "photos", "galleries", pt.WX_slug, Constants.ImageTypes.toString(pt.WX_imageType))
			-- PrintUtils.message("Leg 4 outputPath: ")
		else
			PrintUtils.message("Leg 4") 
			outputPath = nil
		end
	else
		PrintUtils.message("Outter else")
	end
	PrintUtils.message("makeOutputDir return value: " .. outputPath)
	return outputPath
	-- propertyTable.fullOutputPath = outputPath
end
local function setError(propertyTable, message)
	if message then
		propertyTable.message = message
		propertyTable.hasError = true
		propertyTable.hasNoError = false
		propertyTable.LR_cantExportBecause = message
	else
		propertyTable.message = nil
		propertyTable.hasError = false
		propertyTable.hasNoError = true
		propertyTable.LR_cantExportBecause = nil
	end

end
local function updateExportParams( propertyTable )
	
	local message = nil
	
	repeat
		propertyTable.WX_require_album_name_field = (propertyTable.WX_albumType == Constants.AlbumTypes.named_journal)
		propertyTable.WX_is_journal = (propertyTable.WX_albumType == Constants.AlbumTypes.named_journal) or (propertyTable.WX_albumType == Constants.AlbumTypes.journal)
		propertyTable.WX_is_not_journal = not propertyTable.WX_is_journal
		if isEmpty(propertyTable.WX_slug) then
			propertyTable.WX_slug = Constants.default_slug_value
			setError(propertyTable, "The Slug field MUST have a value")
			break
		end
		if isEmpty(propertyTable.WX_journal_album_name) then
			propertyTable.WX_journal_album_name = Constants.default_journal_album_name
			setError(propertyTable, "The Slug field MUST have a value")
			break
		end
		local output_dir = makeOutputDirPath(propertyTable)
		if(output_dir == nil) then
			setError(propertyTable, "Form is not completed satisfactorially")
		else
			setError(propertyTable, nil)
			propertyTable.WX_outputDir = output_dir
		end
	until true
	
	if message then
		propertyTable.message = message
		propertyTable.hasError = true
		propertyTable.hasNoError = false
		propertyTable.LR_cantExportBecause = message
	else
		propertyTable.message = nil
		propertyTable.hasError = false
		propertyTable.hasNoError = true
		propertyTable.LR_cantExportBecause = nil
	end
	
end

-------------------------------------------------------------------------------

function ExportDialogSections.startDialog( propertyTable )
	PrintUtils.message('startDialog')

	propertyTable:addObserver( 'WX_exportPrefix', updateExportParams )
	propertyTable:addObserver( 'WX_exportFolder', updateExportParams )
	propertyTable:addObserver( 'WX_synopsis', updateExportParams )
	propertyTable:addObserver( 'WX_albumType', updateExportParams )
	propertyTable:addObserver( 'WX_imageType', updateExportParams )
	propertyTable:addObserver( 'WX_slug', updateExportParams )
	propertyTable:addObserver( 'WX_journal_album_name', updateExportParams )


	-- below here are hangovers from the ftp plugin that was modified to get the whiteacorn plugin
	propertyTable:addObserver( 'items', updateExportParams )
	propertyTable:addObserver( 'path', updateExportParams )
	propertyTable:addObserver( 'putInSubfolder', updateExportParams )
	propertyTable:addObserver( 'ftpPreset', updateExportParams )

	updateExportParams( propertyTable )
	
end

function ExportDialogSections.sectionsForTopOfDialog( _, propertyTable )

	local f = LrView.osFactory()
	local bind = LrView.bind
	local share = LrView.share

	local result = {
		{
			title = "Whiteacorn Export",	
			synopsis = bind { key = 'WX_synopsis', object = propertyTable },
			f:row {
				f:static_text {
					title = "Output Root ",
					alignment = 'right',
					width = share 'labelWidth'
				},
				f:edit_field {
					value = bind 'WX_exportPrefix',
					width = 200,
					-- enabled = bind 'putInSubfolder',
					-- validate = LrFtp.ftpPathValidator,
					-- truncation = 'middle',
					-- immediate = true,
					fill_horizontal = 1,
				},
			},
			f:row {
				f:static_text {
					title = "Type of Album ",
					alignment = 'right',
					width = share 'labelWidth'
				},
				f:popup_menu {
					value = bind 'WX_albumType',
					width = 300,
					items = {
						{ value = Constants.AlbumTypes.journal, title = "Journal" },
						{ value = Constants.AlbumTypes.named_journal, title = "Named Journal" },
						{ value = Constants.AlbumTypes.photo, title = "Photo Album" },
					},
				},
			},
			f:row {
				f:static_text {
					title = "Slug ",
					alignment = 'right',
					width = share 'labelWidth'
				},
				f:edit_field {
					value = bind 'WX_slug',
					width = 200,
					-- enabled = bind 'putInSubfolder',
					-- validate = LrFtp.ftpPathValidator,
					-- truncation = 'middle',
					-- immediate = true,
					fill_horizontal = 1,
				},
			},
			f:row {
				f:static_text {
					title = "If checked enter an album name ",
					alignment = 'right',
					width = share 'labelWidth',
					enabled = bind 'WX_require_album_name_field'
				},
				f:edit_field {
					value = bind 'WX_journal_album_name',
					width = 200,
					enabled = bind 'WX_require_album_name_field',
					-- validate = LrFtp.ftpPathValidator,
					-- truncation = 'middle',
					-- immediate = true,
					fill_horizontal = 1,
				},
				f:spacer {
					width = 5,
					enabled = bind 'WX_require_album_name_field',
				},
			},
			f:row {
				visible = bind 'WX_is_not_journal',
				f:static_text {
					title = "Select Type of Image ",
					alignment = 'right',
					width = share 'labelWidth',
					visible = bind 'WX_is_not_journal',
				},
				f:popup_menu {
					value = bind 'WX_imageType',
					width = 300,
					-- enabled = bind 'WX_is_not_journal',
					visible = bind 'WX_is_not_journal',
					items = {
						{ value = Constants.ImageTypes.large, title = "Large Images" },
						{ value = Constants.ImageTypes.thumbnails, title = "Thumbnails" },
						{ value = 'mascot', title = "Mascot" },
					},
				},
			},
			f:row {
				visible = bind 'WX_is_journal',
				f:static_text {
					title = "Select Type of Image ",
					alignment = 'right',
					width = share 'labelWidth',
					visible = bind 'WX_is_journal',
				},
				f:popup_menu {
					value = bind 'WX_imageType',
					width = 300,
					-- enabled = bind 'WX_is_journal',
					visible = bind 'WX_is_journal',
					items = {
						{ value = Constants.ImageTypes.large, title = "Large Images" },
						{ value = Constants.ImageTypes.thumbnails, title = "Thumbnails" },
					},
				},
			},
			f:row {
				f:static_text {
					title = "Full output path ",
					alignment = 'right',
					width = share 'labelWidth'
				},
				f:edit_field {
					value = bind 'WX_outputDir',
					width = 200,
					-- enabled = bind 'putInSubfolder',
					-- validate = LrFtp.ftpPathValidator,
					-- truncation = 'middle',
					-- immediate = true,
					fill_horizontal = 1,
				},
				f:spacer {
					width = 5
				},
			},

			f:column {
				place = 'overlapping',
				fill_horizontal = 1,
				
				f:row {
					f:static_text {
						title = LOC "$$$/FtpUpload/ExportDialog/FullPath=Full Path:",
						alignment = 'right',
						width = share 'labelWidth',
						visible = bind 'hasNoError',
					},
					
					f:static_text {
						fill_horizontal = 1,
						width_in_chars = 20,
						title = bind 'fullPath',
						visible = bind 'hasNoError',
					},
				},
				
				f:row {
					f:static_text {
						fill_horizontal = 1,
						title = bind 'message',
						visible = bind 'hasError',
					},
				},
			},
		},
	}
	
	return result
	
end

return ExportDialogSections
