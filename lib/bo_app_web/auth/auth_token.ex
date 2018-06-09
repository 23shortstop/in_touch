defmodule BoAppWeb.AuthToken do
  @token_age 86400
  @token_salt "987435uweur98sfvui3r783yriuhsfkduy8723y"

  def verify(nil), do: {:error, :empty_token}

  def verify(token) do
    BoAppWeb.Endpoint
    |> Phoenix.Token.verify(@token_salt, token, max_age: @token_age)
  end

  def sign(user) do
    BoAppWeb.Endpoint
    |> Phoenix.Token.sign(@token_salt, user.id)
  end
end
