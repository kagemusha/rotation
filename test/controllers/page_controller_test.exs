defmodule Rotation.PageControllerTest do
  use Rotation.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Developers"
  end
end
