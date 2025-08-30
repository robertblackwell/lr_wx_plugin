local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrPrefs = import 'LrPrefs'

UI = {}

local function exportPrefixRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Output Root ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_exportPrefix',
			width = 200,
			-- enabled = bind 'putInSubfolder',
			-- validate = LrFtp.ftpPathValidator,
			-- truncation = 'middle',
			-- immediate = true,
			fill_horizontal = 1,
		},				
		f:push_button {
			title = "Choose",
			value = "Choose",
			width = 100,
			action = function()
				local d = LrDialogs.runOpenPanel {
					title = "Dummy select prefix dir",
					canChooseFile = false,
					canChooseDirectories = true,
					canCreateDirectories = true,
					allowMultipleSelection = false,
					initialDirectory = "/Volumes"
				}
				if (d ~= nil) and (type(d) == "table") and (#d > 0) then
					LrDialogs.message("You selected " .. d[1])
					wxPropertyTable.WX_exportPrefix = d[1]
				end
			end
		}
	}
end
local function typeOfAlbumRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Type of Album ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:popup_menu {
			value = LrView.bind 'WX_journal_album_type',
			width = 300,
			items = {
				{ value = Constants.AlbumTypes.journal, title = "Journal" },
				{ value = Constants.AlbumTypes.named_journal, title = "Named Journal" },
				{ value = Constants.AlbumTypes.photo, title = "Photo Album" },
			},
		},
	}
end
local function typeOfJournalAlbumRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Type of Journal Album ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:popup_menu {
			value = LrView.bind 'WX_journal_album_type',
			width = 300,
			items = {
				{ value = Constants.AlbumTypes.journal, title = "Journal" },
				{ value = Constants.AlbumTypes.named_journal, title = "Named Journal" },
			},
		},
	}
end
local function journalSlugRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Slug for Journal ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_slug',
			width = 200,
			-- enabled = bind 'putInSubfolder',
			-- validate = LrFtp.ftpPathValidator,
			-- truncation = 'middle',
			-- immediate = true,
			fill_horizontal = 1,
		},
	}
end
local function photoSlugRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Slug for Photo Album ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_slug',
			width = 200,
			-- enabled = bind 'putInSubfolder',
			-- validate = LrFtp.ftpPathValidator,
			-- truncation = 'middle',
			-- immediate = true,
			fill_horizontal = 1,
		},
	}
end
local function journalAlbumNameRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "If checked enter an album name ",
			alignment = 'right',
			width = LrView.share 'labelWidth',
			enabled = LrView.bind 'WX_require_journal_album_name'
		},
		f:edit_field {
			value = LrView.bind 'WX_journal_album_name',
			width = 200,
			enabled = LrView.bind 'WX_require_journal_album_name',
			-- tool_tip = "If exporting a named journal album, enter the name here",
			-- validate = LrFtp.ftpPathValidator,
			-- truncation = 'middle',
			-- immediate = true,
			fill_horizontal = 1,
		},
		f:spacer {
			width = 5,
			enabled = LrView.bind 'WX_require_journal_album_name',
		},
	}
end
local function renamingStartNumberRow(wxPropertyTable, f)
	return f:row {
		f:static_text {
			title = "Renaming start number ",
			alignment = 'right',
			width = LrView.share 'labelWidth',
		},
		f:edit_field {
			value = LrView.bind 'WX_renaming_start_number',
			width = 200,
			-- enabled = LrView.bind 'WX_require_journal_album_name',
			-- tool_tip = "If exporting a named journal album, enter the name here",
			-- validate = LrFtp.ftpPathValidator,
			-- truncation = 'middle',
			-- immediate = true,
			-- fill_horizontal = 1,
		},
		f:spacer {
			width = 5,
			-- enabled = LrView.bind 'WX_require_journal_album_name',
		},
	}
end
local function imagesOutputPathRow(wxPropertyTable, f)
	return	f:row {
		f:static_text {
			title = "Images output path ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_imagesOutputDir',
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
	}
end
local function thumbnailsOutputPathRow(wxPropertyTable, f)
	return	f:row {
		f:static_text {
			title = "Thumbnails output path ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_thumbnailsOutputDir',
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
	}
end 
local function mascotsOutputPathRow(wxPropertyTable, f)
	return	f:row {
		f:static_text {
			title = "Mascots output path ",
			alignment = 'right',
			width = LrView.share 'labelWidth'
		},
		f:edit_field {
			value = LrView.bind 'WX_mascotsOutputDir',
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
	}
end 

local function errorRow(wxPropertyTable, f)
	return	f:column {
		place = 'overlapping',
		fill_horizontal = 1,
		
		f:row {
			f:static_text {
				title = "Full Path:",
				alignment = 'right',
				width = LrView.share 'labelWidth',
				visible = LrView.bind 'hasNoError',
			},
			
			f:static_text {
				fill_horizontal = 1,
				width_in_chars = 20,
				title = LrView.bind 'fullPath',
				visible = LrView.bind 'hasNoError',
			},
		},
		
		f:row {
			f:static_text {
				fill_horizontal = 1,
				title = LrView.bind 'message',
				visible = LrView.bind 'hasError',
			},
		},
	}
end
function UI.form(wxPrefs)
    local f = LrView.osFactory()
    local bind = LrView.bind
    local share = LrView.share
    local dialog_spacing = f:dialog_spacing()

    return {
        title = "Export of photo album for Whiteacorn Journal Entry",
        resizeable = false,
        contents = f:view{
			bind_to_object = wxPrefs,
			f:tab_view {
				value = LrView.bind 'WX_tab_id', 
				f:tab_view_item {
					title = "Export a Journal album",
					identifier = Constants.TabId.journalTab,
					width = 800,
					spacing = dialog_spacing,
					exportPrefixRow(wxPrefs, f),
					journalSlugRow(wxPrefs, f),
					typeOfJournalAlbumRow(wxPrefs, f),
					journalAlbumNameRow(wxPrefs, f),
					renamingStartNumberRow(wxPrefs, f),
					imagesOutputPathRow(wxPrefs, f),
					thumbnailsOutputPathRow(wxPrefs, f),
				},
				f:tab_view_item {
					title = "Export a Photo Album",
					identifier = Constants.TabId.photoTab,
					width = 800,
					spacing = dialog_spacing,
					exportPrefixRow(wxPrefs, f),
					photoSlugRow(wxPrefs, f),
					renamingStartNumberRow(wxPrefs, f),
					imagesOutputPathRow(wxPrefs, f),
					thumbnailsOutputPathRow(wxPrefs, f),
				},
				f:tab_view_item {
					title = "Export Mascots for a Photo Album",
					identifier = Constants.TabId.mascotTab,
					width = 800,
					spacing = dialog_spacing,
					exportPrefixRow(wxPrefs, f),
					photoSlugRow(wxPrefs, f),
					renamingStartNumberRow(wxPrefs, f),
					mascotsOutputPathRow(wxPrefs, f),
				},

			}
		}
    }
end
return