
local LrView = import 'LrView'
local LrFtp = import 'LrFtp'


ExportDialogSections = {}

local function updateExportStatus( propertyTable )
	
	local message = nil
	
	repeat
		-- Use a repeat loop to allow easy way to "break" out.
		-- (It only goes through once.)
		
		if propertyTable.ftpPreset == nil then
			message = LOC "$$$/FtpUpload/ExportDialog/Messages/SelectPreset=Select or Create an FTP preset"
			break
		end
		
		if propertyTable.putInSubfolder and ( propertyTable.path == "" or propertyTable.path == nil ) then
			message = LOC "$$$/FtpUpload/ExportDialog/Messages/EnterSubPath=Enter a destination path"
			break
		end
		
		local fullPath = propertyTable.ftpPreset.path or ""
		
		if propertyTable.putInSubfolder then
			fullPath = LrFtp.appendFtpPaths( fullPath, propertyTable.path )
		end
		
		propertyTable.fullPath = fullPath
		
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

	propertyTable:addObserver( 'WX_exportPrefix', updateExportStatus )
	propertyTable:addObserver( 'WX_exportFolder', updateExportStatus )
	propertyTable:addObserver( 'WX_synopsis', updateExportStatus )
	propertyTable:addObserver( 'WX_albumType', updateExportStatus )
	propertyTable:addObserver( 'WX_imageType', updateExportStatus )
	propertyTable:addObserver( 'WX_slug', updateExportStatus )
	propertyTable:addObserver( 'WX_journal_album_name', updateExportStatus )


	-- below here are hangovers from the ftp plugin that was modified to get the whiteacorn plugin
	propertyTable:addObserver( 'items', updateExportStatus )
	propertyTable:addObserver( 'path', updateExportStatus )
	propertyTable:addObserver( 'putInSubfolder', updateExportStatus )
	propertyTable:addObserver( 'ftpPreset', updateExportStatus )

	updateExportStatus( propertyTable )
	
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
					title = LOC "$$$/FtpUpload/ExportDialog/Destination=Destination:",
					alignment = 'right',
					width = share 'labelWidth'
				},
	
				LrFtp.makeFtpPresetPopup {
					factory = f,
					properties = propertyTable,
					valueBinding = 'ftpPreset',
					itemsBinding = 'items',
					fill_horizontal = 1,
				},
			},

			f:row {
				f:spacer {
					width = share 'labelWidth'
				},
	
				f:checkbox {
					title = LOC "$$$/FtpUpload/ExportDialog/PutInSubfolder=Put in Subfolder:",
					value = bind 'putInSubfolder',
				},

				f:edit_field {
					value = bind 'path',
					enabled = bind 'putInSubfolder',
					validate = LrFtp.ftpPathValidator,
					truncation = 'middle',
					immediate = true,
					fill_horizontal = 1,
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
