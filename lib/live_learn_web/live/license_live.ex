defmodule LiveLearnWeb.LicenseLive do
  use LiveLearnWeb, :live_view

  alias LiveLearn.Licenses

  import Number.Currency

  @default_seats 2
  @default_expire 1

  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    expiration_time = Timex.shift(Timex.now(), hours: @default_expire)
    # socket = assign(socket, seats: @default_seats, amount: Licenses.calculate(2))
    socket =
      assign(socket,
        seats: @default_seats,
        expiration_time: expiration_time,
        time_remaining: time_remaining(expiration_time),
        amount: Licenses.calculate(@default_seats)
      )

    {:ok, socket}
  end

  def render(assigns) do
      ~L"""
      <h1>Team License</h1>
      <div id="license">
        <div class="card">
          <div class="content">
            <div class="seats">
              <img src="images/license.svg">
              <span>
                Your license is currently for
                <strong><%= @seats %></strong> seats.
              </span>
            </div>

            <form phx-change="update">
              <input type="range" min="1" max="10"
                    name="seats" value="<%= @seats %>" />
            </form>

            <div class="amount">
              <%= number_to_currency(@amount) %>
            </div>
          </div>

          <p class="m-4 font-semibold text-indigo-800">
            <%= @time_remaining %> left to save 20%
          </p>

        </div>
      </div>
      """
  end


  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licenses.calculate(seats)
      )

    {:noreply, socket}
  end


  def handle_info(:tick, socket) do
    expiration_time = socket.assigns.expiration_time
    socket = assign(socket, time_remaining: time_remaining(expiration_time))
    {:noreply, socket}
  end


  defp time_remaining(expiration_time) do
    Timex.Interval.new(from: Timex.now(), until: expiration_time)
    |> Timex.Interval.duration(:seconds)
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end

end
