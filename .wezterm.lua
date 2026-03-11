local wezterm = require "wezterm"

local config = wezterm.config_builder()
config:set_strict_mode(true)

-- keymap
-- 1, 2, 3, etc.
local shifted_nums = { "!", "@", "#", "$", "%", "^", "&", "*", "(", ")" }
config.keys = {
  {
    -- need to use shifted form because of SHIFT
    key = shifted_nums[1],
    mods = "CTRL | SHIFT",
    action = wezterm.action.SpawnTab "DefaultDomain"
  },
  {
    key = shifted_nums[2],
    mods = "CTRL | SHIFT",
    action = wezterm.action.SpawnTab {
      DomainName = "SSH:pi"
    }
  },
  --{
  --  key = shifted_nums[3],
  --  mods = "CTRL | SHIFT",
  --  action = wezterm.action.SpawnTab {
  --    DomainName = 'WSL:Debian'
  --  }
  --},
  -- CTRL+SHIFT+% split vertical, CTRL+SHIFT+", split horizontal
  {
    key = "%",
    mods = "CTRL | SHIFT | ALT",
    action = wezterm.action.SplitVertical
  },
  {
    key = "\"",
    mods = "CTRL | SHIFT | ALT",
    action = wezterm.action.SplitHorizontal
  },
  -- goto last tab
  {
    key = "0",
    mods = "CTRL | ALT",
    action = wezterm.action.ActivateTab(-1),
  },
  -- more scroll controls
  {
    key = "DownArrow",
    mods = "CTRL | SHIFT",
    action = wezterm.action.ScrollToBottom
  },
  {
    key = "UpArrow",
    mods = "CTRL | SHIFT",
    action = wezterm.action.ScrollToTop
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = wezterm.action.ScrollByLine(1)
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = wezterm.action.ScrollByLine(-1)
  },
  {
    key = "PageDown",
    mods = "CTRL",
    action = wezterm.action.ScrollByPage(1)
  },
  {
    key = "PageUp",
    mods = "CTRL",
    action = wezterm.action.ScrollByPage(-1)
  },
  -- remove font resizing CTRL+ keybinds
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment
  },
  {
    key = "=",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment
  },
  {
    key = "_",
    mods = "CTRL | SHIFT",
    action = wezterm.action.DisableDefaultAssignment
  },
  {
    key = "+",
    mods = "CTRL | SHIFT",
    action = wezterm.action.DisableDefaultAssignment
  }
}
--> remove default ctrl shift keybind
for i = 0, 9 do
  -- we have custom keybinds for 1, 2, and 3
  if i <= 3 then
    goto continue
  end
  -- number 0 is the tenth key from the left.
  if i == 0 then
    i = 10
  end
  table.insert(config.keys, {
    key = shifted_nums[i],
    mods = "CTRL | SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  })
  ::continue::
end
--> from 1-9, CTRL+ALT+`number` to goto that tab
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL | ALT",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- functionality
--> powershell core
config.default_cwd = wezterm.home_dir
--config.default_prog = { "pwsh" }
--> make initial window size like windows terminal:
config.initial_cols = 120
config.initial_rows = 30

-- appearance
--> catppuccin
config.color_scheme = "Catppuccin Macchiato"
-->> tab bar colors
config.window_frame = {
  -- from catppuccin windows terminal
  active_titlebar_bg = "#1E2030",
  inactive_titlebar_bg = "#181926"
}
-- catppuccin bg&fgs
local bg = "#24273A"
local fg = "#CAD3F5"
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = bg,
      fg_color = fg,
    },
    inactive_tab = {
      bg_color = "#1f2131",
      fg_color = fg,
    },
    inactive_tab_hover = {
      bg_color = "#212435",
      fg_color = fg,
    },
    new_tab = {
      bg_color = "#1E2030",
      fg_color = fg,
    },
    new_tab_hover = {
      bg_color = "#212435",
      fg_color = fg,
    },
  }
}
-->> command palette styling
config.command_palette_bg_color = bg
config.command_palette_fg_color = fg
config.command_palette_font_size = 13
config.command_palette_rows = 10
--> make the window buttons in-line with tab bar:
--config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
--> font
config.font = wezterm.font_with_fallback {
  { family = "Cascadia Mono", weight = "DemiBold" },
  "Noto Color Emoji",
}
config.font_size = 12

return config
