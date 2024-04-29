local wezterm = require 'wezterm';
return {
  -- default_prog = {"wsl", "zellij", "attach", "--create"},
  -- font = wezterm.font("FiraMono Nerd Font"),
  -- window_decorations = "RESIZE",
  font = wezterm.font("UbuntuMono Nerd Font"),
  font_size = 14,
  window_decorations = "NONE",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  }
}
