defmodule InTouchWeb.Token do

  @token_age 86400
  @token_salt "987435uweur98sfvui3r783yriuhsfkduy8723y"

  def verify(nil), do: {:error, :empty_token}

  @doc """
  Decodes the original data from the user authentication token and verifies its integrity.
  Returns {:ok, user_id} if verified successfully or {:error, :reason} otherwise.
  """
  def verify(token) do
    InTouchWeb.Endpoint
    |> Phoenix.Token.verify(@token_salt, token, max_age: @token_age)
  end

  @doc """
  Encodes user id and signs it in an authentication token.
  """
  def sign(user) do
    InTouchWeb.Endpoint
    |> Phoenix.Token.sign(@token_salt, user.id)
  end
end
