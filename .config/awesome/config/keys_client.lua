local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

local config = {}

function config.init(context)

    context.keys = context.keys or {}
    context.mouse = context.mouse or {}

    local modkey      = context.keys.modkey
    local altkey      = context.keys.altkey
    local ctrlkey     = context.keys.ctrlkey
    local shiftkey    = context.keys.shiftkey
    local l_key       = context.keys.l_key
    local r_key       = context.keys.r_key
    local u_key       = context.keys.u_key
    local d_key       = context.keys.d_key

    local terminal    = context.vars.terminal
    local browser     = context.vars.browser

    context.keys.client = gears.table.join(
        awful.key({ modkey, altkey            }, "Return", function(c) c:swap(awful.client.getmaster()) end,
                  {description = "swap with master", group = "client"}),
        awful.key({ modkey, ctrlkey           }, "m", lain.util.magnify_client,
                  {description = "magnify", group = "client"}),

        awful.key({ modkey                    }, "z", function(c) c:kill() end,
                  {description = "close", group = "client"}),
        awful.key({ modkey, ctrlkey           }, "space", awful.client.floating.toggle,
                  {description = "toggle floating", group = "client"}),
        awful.key({ modkey                    }, "o", function(c) c:move_to_screen() end,
                  {description = "move to screen", group = "client"}),
        awful.key({ modkey                    }, "t", function(c) c.ontop = not c.ontop end,
                  {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey                    }, "s", function(c) c.sticky = not c.sticky end,
                  {description = "toggle sticky", group = "client"}),
        awful.key({ modkey                    }, "i", context.util.toggle_titlebar,
                  {description = "toggle titlebar", group = "client"}),
        awful.key({ modkey                    }, "n", function(c) c.minimized = true end,
                  {description = "minimize", group = "client"}),
        awful.key({ modkey                    }, "m", context.util.toggle_maximized,
                  {description = "maximize", group = "client"}),
        awful.key({ modkey                    }, "f", context.util.toggle_fullscreen,
                  {description = "fullscreen", group = "client"}),

        awful.key({ modkey                    }, "v", function(c) --luacheck: no unused args
            awful.spawn(terminal .. " zsh -lic '" .. context.vars.scripts_dir .. "/edit-in-vim'", {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end)
    )

    if context.util.set_wallpaper then
        context.keys.client = gears.table.join(
            context.keys.client,
            awful.key({ modkey, ctrlkey           }, "i", function() context.util.set_wallpaper(0) end,
                      {description = "unblur wallpaper", group = "client"})
        )
    end

    context.mouse.client = gears.table.join(
        awful.button({                  }, 1, function(c) client.focus = c; c:raise() end),
        awful.button({ modkey           }, 1, awful.mouse.client.move),
        awful.button({ modkey, shiftkey }, 1, awful.mouse.client.resize)
    )

end

return config
