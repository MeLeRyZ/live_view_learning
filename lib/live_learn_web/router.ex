defmodule LiveLearnWeb.Router do
  use LiveLearnWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveLearnWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveLearnWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/light", LightLive
    live "/license", LicenseLive
    live "/light-slider", LightSliderLive
    live "/sales-dashboard", SalesDashboardLive

    get "/sales", SalesController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveLearnWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LiveLearnWeb.Telemetry
    end
  end
end
