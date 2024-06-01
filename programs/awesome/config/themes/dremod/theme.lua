
--[[
                                   
     modified
     Dremora Awesome WM config 2.0 
     github.com/copycat-killer     
                                   
     icons from powerarrow dark theme
--]]

local theme                                     = {}

local xresources = require("beautiful").xresources
local theme_assets = require("beautiful.theme_assets")
local xrdb = xresources.get_current_theme()

theme.config_dir                                = os.getenv("HOME") .. "/.config/awesome"
theme.dir                                       = theme.config_dir .. "/themes/dremod"
theme.icons_dir                                 = theme.config_dir .. "/awesome-copycats/themes/powerarrow-dark/icons"
theme.wallpaper                                 = theme.dir .. "/wall.png"

theme.delta = 10
theme.padding = 10
theme.useless_gap = 0

-- theme.font                                      = "Misc Tamsyn 10.5"
-- theme.taglist_font                              = "Misc Tamsyn 10.5"
theme.font                                      = "Terminus 9"
theme.taglist_font                              = "Terminus 9"
theme.fg_normal                                 = "#747474"
theme.fg_focus                                  = "#DDDCFF"
theme.bg_normal                                 = xrdb.background
theme.bg_focus                                  = xrdb.background
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = 3
theme.border_normal                             = xrdb.background --"#2F2F2F"
-- theme.border_focus                              = "#4F4F4F"
-- theme.border_focus                              = "#6F6F6F"
theme.border_focus                              = "#12abe2"
-- theme.border_focus                              = xrdb.color8
-- theme.border_focus                              = "#FFFFFF" --xrdb.color0
theme.titlebar_bg_focus                         = "#292929"
theme.taglist_fg_focus                          = "#dddcff"
theme.taglist_bg_focus                          = xrdb.background --"#00000000" --

theme.menu_height                               = 16
theme.menu_width                                = 130
theme.menu_submenu_icon                         = theme.icons_dir .. "/submenu.png"
theme.awesome_icon                              = theme.icons_dir .. "/awesome.png"
theme.taglist_squares_sel                       = theme.icons_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icons_dir .. "/square_unsel.png"
theme.layout_tile                               = theme.icons_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icons_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icons_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icons_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icons_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icons_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icons_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icons_dir .. "/dwindle.png"
theme.layout_max                                = theme.icons_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icons_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icons_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icons_dir .. "/floating.png"

theme.titlebar_close_button_focus               = theme.icons_dir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.icons_dir .. "/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.icons_dir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.icons_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.icons_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.icons_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.icons_dir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.icons_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.icons_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.icons_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.icons_dir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.icons_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.icons_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.icons_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.icons_dir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.icons_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.icons_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.icons_dir .. "/titlebar/maximized_normal_inactive.png"


theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true



-- recolor icons
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

return theme
