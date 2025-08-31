require "Utils"

ExportTask = {}

function ExportTask.processRenderedPhotos( functionContext, exportContext )

	local exportParams = exportContext.propertyTable
	Utils.dumpTable(exportParams, 4)
	
end

return ExportTask
