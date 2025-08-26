require "PrintUtils"

local LrPathUtils = import 'LrPathUtils'
local LrFileUtils = import 'LrFileUtils'
local LrErrors = import 'LrErrors'
local LrDialogs = import 'LrDialogs'

ExportTask = {}

function ExportTask.processRenderedPhotos( functionContext, exportContext )

	local exportSession = exportContext.exportSession
	local exportParams = exportContext.propertyTable
	local ftpPreset = exportParams.ftpPreset
	PrintUtils.dumpTable(exportParams, 4)
	-- Set progress title.

	local nPhotos = exportSession:countRenditions()

	local progressScope = exportContext:configureProgress {
						title = nPhotos > 1
							   and LOC( "$$$/FtpUpload/Upload/Progress=Uploading ^1 photos via Ftp", nPhotos )
							   or LOC "$$$/FtpUpload/Upload/Progress/One=Uploading one photo via Ftp",
					}
	
	local failures = {}
	local destParentPath = LrPathUtils.child(exportParams.WX_exportPrefix, exportParams.WX_exportFolder)
	if not LrFileUtils.exists(destParentPath) then
		LrFileUtils.createAllDirectories(destParentPath)
	end
	PrintUtils.message("destParentPath : " .. destParentPath)
	for _, rendition in exportContext:renditions{ stopIfCanceled = true } do
		local success, pathOrMessage = rendition:waitForRender()
		if progressScope:isCanceled() then break end
		if success then
			local filename = LrPathUtils.leafName( pathOrMessage )
			PrintUtils.message("in render loop filename: " .. filename .. " path: " .. pathOrMessage)
			if not success then
				table.insert( failures, filename )
			end
			local dest = LrPathUtils.child(destParentPath, filename)
			if LrFileUtils.exists(dest) then 
				PrintUtils.message("dest file " .. dest .. " already exists. Overwriting")
			end
			LrFileUtils.copy(pathOrMessage, dest)
			PrintUtils.message("copy " .. pathOrMessage .. "  -->  " .. dest )
			LrFileUtils.delete( pathOrMessage )
					
		end
		
	end

	-- ftpInstance:disconnect()
	
	if #failures > 0 then
		local message
		if #failures == 1 then
			message = LOC "$$$/FtpUpload/Upload/Errors/OneFileFailed=1 file failed to upload correctly."
		else
			message = LOC ( "$$$/FtpUpload/Upload/Errors/SomeFileFailed=^1 files failed to upload correctly.", #failures )
		end
		LrDialogs.message( message, table.concat( failures, "\n" ) )
	end
	
end

return ExportTask
