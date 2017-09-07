defmodule FamilySearch.Authentication.AccessToken do

  @type t :: %__MODULE__{token: String.t, type: String.t}
  defstruct [:token, :type]
  @enforce_keys [:token, :type]

  @spec from_username_and_password(String.t, String.t) :: __MODULE__.t
  def from_username_and_password(username, password) do
    response_body = "https://ident.familysearch.org/cis-web/oauth2/v3/token"
      |> FamilySearchApi.post!({:form,
                                [grant_type: "password",
                                 client_id: System.get_env("FS_CLIENT_ID"),
                                 username: username,
                                 password: password]},
                               [{"Content-Type",
                                 "application/x-www-form-urlencoded"}])
      |> Map.get(:body)
      |> Poison.decode!

    %__MODULE__{token: response_body["access_token"],
                type: response_body["token_type"]}
  end
end
