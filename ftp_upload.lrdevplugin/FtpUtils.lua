local LrLogger = import 'LrLogger'
local logger = LrLogger('FtpExportPlugin') -- Replace 'YourPluginName' with your plugin's name
logger:enable("logfile") -- or "print" for console output

---------------------------------------------------------------------------------
FtpUtils = {}
function FtpUtils.init()

end
function FtpUtils.message(msg)
    logger:info(msg)
end
function FtpUtils.dumpTable(tbl, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)
    logger:info(indentStr .. "{")

    for k, v in pairs(tbl) do
        local keyStr = tostring(k)
        local valueStr
        if type(v) == "table" then
            logger:info(indentStr .. "  " .. keyStr .. " = ")
            FtpUtils.dumpTable(v, indent + 1) -- Recursive call for nested tables
        else
            valueStr = tostring(v)
            logger:info(indentStr .. "  " .. keyStr .. " = " .. valueStr .. ",")
        end
    end
    logger:info(indentStr .. "}")
end
return FtpUtils