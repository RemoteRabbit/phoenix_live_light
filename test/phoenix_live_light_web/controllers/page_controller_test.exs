defmodule PhoenixLiveLightWeb.PageControllerTest do
  use PhoenixLiveLightWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
  end
end
