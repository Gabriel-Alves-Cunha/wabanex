defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns it's data" do
      params = %{"filename" => "test.csv"}

      response = IMC.calculate(params)

      expected_response = {:ok, %{"banana" => 26.989619377162633}}

      assert response == expected_response
    end

    test "when the file does not exists, returns an error" do
      params = %{"filename" => "test.cs"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error when opening file: enoent"}

      assert response == expected_response
    end
  end
end
