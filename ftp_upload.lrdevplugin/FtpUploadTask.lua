--[[----------------------------------------------------------------------------

FtpUploadTask.lua
Upload photos via Ftp

--------------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2007 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

------------------------------------------------------------------------------]]
require "FtpUtils"
-- Lightroom API
local LrPathUtils = import 'LrPathUtils'
local LrFtp = import 'LrFtp'
local LrFileUtils = import 'LrFileUtils'
local LrErrors = import 'LrErrors'
local LrDialogs = import 'LrDialogs'

--============================================================================--

FtpUploadTask = {}

--------------------------------------------------------------------------------

function FtpUploadTask.processRenderedPhotos( functionContext, exportContext )

	-- Make a local reference to the export parameters.
	
	local exportSession = exportContext.exportSession
	local exportParams = exportContext.propertyTable
	local ftpPreset = exportParams.ftpPreset
	FtpUtils.dumpTable(exportParams, 4)
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
	FtpUtils.message("destParentPath : " .. destParentPath)
	for _, rendition in exportContext:renditions{ stopIfCanceled = true } do
		local success, pathOrMessage = rendition:waitForRender()
		if progressScope:isCanceled() then break end
		if success then
			local filename = LrPathUtils.leafName( pathOrMessage )
			FtpUtils.message("in render loop filename: " .. filename .. " path: " .. pathOrMessage)
			if not success then
				table.insert( failures, filename )
			end
			local dest = LrPathUtils.child(destParentPath, filename)
			if LrFileUtils.exists(dest) then 
				FtpUtils.message("dest file " .. dest .. " already exists. Overwriting")
			end
			LrFileUtils.copy(pathOrMessage, dest)
			FtpUtils.message("copy " .. pathOrMessage .. "  -->  " .. dest )
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
