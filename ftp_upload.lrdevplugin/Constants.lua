Constants = {}
Constants.ImageTypes = {large = "large_images", thumbnails = "thumbnails", mascot = "mascot"}
Constants.ImageTypes.toString = function(s) 
    if s == Constants.ImageTypes.large then
        return "Images" 
    elseif s == Constants.Imagetypes.thumbnails then 
        return "Thumbnails"
    elseif s == Constants.ImageTypes.mascot then
        return "mascot.jpg"
    else 
        return nil
    end
end
Constants.AlbumTypes = {journal = "journal", named_journal = "named_journal", photo = "photo"}
return Constants