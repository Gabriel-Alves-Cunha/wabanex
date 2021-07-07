defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc", %{conn: conn} do
      params = %{"filename" => "test.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_resonse = %{"result" => %{"banana" => 26.989619377162633}}

      assert response == expected_resonse
    end

    test "when not all params are valid, returns an error", %{conn: conn} do
      params = %{"filename" => "test.cs"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_resonse = %{"result" => "Error when opening file: enoent"}

      assert response == expected_resonse
    end
  end
end
