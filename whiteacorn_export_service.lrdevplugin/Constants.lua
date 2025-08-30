Constants = {}
Constants.ImageTypes = {large = "large_images", thumbnails = "thumbnails", mascot = "mascot"}
Constants.ImageTypes.toString = function(s) 
    if s == Constants.ImageTypes.large then
        return "Images" 
    elseif s == Constants.ImageTypes.thumbnails then 
        return "Thumbnails"
    elseif s == Constants.ImageTypes.mascot then
        return "mascot.jpg"
    else 
        return nil
    end
end
Constants.AlbumTypes = {journal = "journal", named_journal = "named_journal", photo = "photo"}
Constants.AlbumTypes.defaultValue = function() 
    return Constants.AlbumTypes.journal 
end
Constants.default_slug_value = "DEFAULT_SLUG"
Constants.default_journal_album_name = "DEFAULT_NAME"
return Constants