
return {
    VERSION = { major=1, minor=0, revision=0, },
    LrSdkVersion = 9.0, -- Adjust based on your Lightroom SDK version
    LrSdkMinimumVersion = 4.0, -- Adjust based on your Lightroom SDK version
    LrToolkitIdentifier = "com.whiteacorn.export", -- Unique identifier for your plugin
    LrPluginName = "Whiteacorn Export Plugin",
    LrPluginInfoUrl = "https://whiteacorn.com/whiteacorn-export-plugin", -- Optional URL
    
    -- Define a menu item that will trigger an action
    LrExportMenuItems = {
        {
            title = "Whiteacorn Custom Export",
            file = "Main.lua", -- The Lua file to execute
        },
    },
}