defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "gb@email.com", name: "Gabriel", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "gb@email.com",
            "id" => "#{user_id}",
            "name" => "Gabriel"
          }
        }
      }

      assert expected_response == response
    end
  end

  describe "user mutation" do
    test "when all params are valid, returns the created user???", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Gabriel", email: "gb@email.com", password: "123456"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => _id,
                   "name" => "Gabriel"
                 }
               }
             } = response
    end
  end
end
