defmodule LiveLearnWeb.SalesController do

  use LiveLearnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
