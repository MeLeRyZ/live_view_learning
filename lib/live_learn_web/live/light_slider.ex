defmodule LiveLearnWeb.LightSliderLive do
  use LiveLearnWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Light Slider</h1>
    <div id="light_slider">
      <div class="card">
        <div class="content">
        <div id="light">
            <div class="meter">
                <span style="width: <%= @brightness %>%">
                    <%= @brightness %>%
                </span>
            </div>
          </div>

          <form phx-change="update">
            <input type="range" min="0" max="100"
                  name="brightness" value="<%= @brightness %>" />
          </form>

        </div>
      </div>
    </div>
    """
end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end


end
