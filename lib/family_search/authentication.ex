defmodule FamilySearch.Authentication do
  @moduledoc """
  Routes for authentication.
  """

  def oauth_password(username, password) do
    FamilySearchApi.post(
      "https://ident.familysearch.org/cis-web/oauth2/v3/token",
      {:form, [
          {:grant_type, "password"},
          {:client_id, System.get_env("FS_CLIENT_ID")},
          {:username, username},
          {:password, password}
        ]},
      [
        {"Content-Type", "application/x-www-form-urlencoded"}
      ]
    )
  end

end
