defmodule LiveLearnWeb.LightLive do
  use LiveLearnWeb, :live_view

  def mount(_params, _session, socket) do
      socket = assign(socket, :brightness, 10)
      {:ok, socket}
  end

  def render(assigns) do
      ~L"""
      <h1>Front light </h1>
      <div id="light">
          <div class="meter">
              <span style="width: <%= @brightness %>%">
                  <%= @brightness %>%
              </span>

          </div>

          <button phx-click="off">
              <img src="images/light-off.svg">
          </button>

          <button phx-click="down">
              <img src="images/down.svg">
          </button>

          <button phx-click="up">
              <img src="images/up.svg">
          </button>

          <button phx-click="on">
              <img src="images/light-on.svg">
          </button>

          <button phx-click="rando">
              <img src="images/phone.svg">
          </button>

      </div>

      """
  end


  def handle_event("on", _, socket) do
      socket = assign(socket, :brightness, 100)
      {:noreply, socket}
  end

  def handle_event("up", _, socket) do
      # --- same flow as below ---
      # brightness = socket.assigns.brightness + 10
      # socket = assign(socket, :brightness, brightness)
      socket = update(socket, :brightness, &min(&1 + 10, 100))
      {:noreply, socket}
  end

  def handle_event("down", _, socket) do
      # --- same flow as below ---
      # brightness = socket.assigns.brightness + 10
      # socket = assign(socket, :brightness, brightness)
      socket = update(socket, :brightness, &max(&1 - 10, 0))
      {:noreply, socket}
  end


  def handle_event("off", _, socket) do
      socket = assign(socket, :brightness, 0)
      {:noreply, socket}
  end

  def handle_event("rando", _, socket) do
      socket = assign(socket, :brightness, Enum.random(0..100))
      {:noreply, socket}
  end


end
