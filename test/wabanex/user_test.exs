defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Gabriel", email: "gb@email.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Gabriel", email: "gb@email.com", password: "123456"},
               errors: []
             } = response
    end

    test "when not all params are valid, returns an invalid changeset" do
      params = %{name: "G", email: "gbemail.com", password: "12345"}

      response = User.changeset(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
