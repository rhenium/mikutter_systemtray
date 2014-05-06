# coding: UTF-8

Plugin.create :systemtray do
  @window = nil
  on_window_created do |i_window|
    @window = Plugin.create(:gtk).widgetof(i_window)
  end

  command(:toggle_window_visibility,
          name: "ウィンドウの表示・非表示を切り替える",
          condition: -> _ { @window },
          visible: true,
          role: :window) do
    @window.visible = !@window.visible?
  end

  status_icon = Gtk::StatusIcon.new
  status_icon.file = Skin.get("icon.png")
  status_icon.tooltip = "mikutter"
  status_icon.signal_connect("activate") do
    Plugin.filtering(:command, {}).first[:toggle_window_visibility][:exec].call
  end
end

