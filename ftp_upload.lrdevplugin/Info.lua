
return {

	LrSdkVersion = 3.0,
	LrSdkMinimumVersion = 1.3, -- minimum SDK version required by this plug-in

	LrToolkitIdentifier = 'com.adobe.lightroom.export.ftp_upload',

	LrPluginName = "Whiteacorn Photo Export",
	
	LrExportServiceProvider = {
		title = "Whiteacorn Export",
		file = 'ExportServiceProvider.lua',
	},

	VERSION = { major=14, minor=3, revision=0, build="202504141032-10373aad", },

}
