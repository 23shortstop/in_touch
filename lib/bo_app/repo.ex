defmodule BoApp.Repo do
  use Ecto.Repo, otp_app: :bo_app

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  @doc """
  Fetches a single result by an id.
  Returns {:ok, record} if result was successfully found or {:error, reason} otherwise.
  """
  def fetch(queryable, id, opts \\ []) do
    try do
      record = get!(queryable, id, opts)
      {:ok, record}
    rescue
      exception -> {:error, Exception.message(exception)}
    end
  end

  @doc """
  Fetches a single result from the query.
  Returns {:ok, record} if result was successfully found or {:error, reason} otherwise.
  """
  def fetch_by(queryable, opts \\ []) do
    try do
      record = get_by!(queryable, opts)
      {:ok, record}
    rescue
      exception -> {:error, Exception.message(exception)}
    end
  end
end
