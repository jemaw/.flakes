{ ... }:
{
  xdg.configFile."herdr/config.toml".text = ''
    [ui]
    agent_panel_sort = "spaces"

    [keys]
    navigate_workspace_down = "j"
    navigate_workspace_up = "k"
    navigate_pane_down = "down"
    navigate_pane_up = "up"

    [experimental]
    kitty_graphics = true

    [theme]
    name = "vesper"
    auto_switch = false
  '';
}
