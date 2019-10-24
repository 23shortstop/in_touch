defmodule InTouch.Messaging do
  @moduledoc """
  The Messaging context.
  """

  import Ecto.Query, warn: false
  alias InTouch.Repo

  alias InTouch.Messaging.Chat
  alias InTouch.Messaging.Participant

  @doc """
  Returns the list of chats for a user.

  ## Examples

      iex> list_chats(current_user)
      [%Chat{}, ...]

  """
  def list_chats(user) do
    user_id = user.id

    (from chat in Chat,
    join: ptcp in Participant,
    on: chat.id == ptcp.chat_id and ptcp.user_id == ^user_id)
    |> Repo.all
  end

  @doc """
  Gets a single chat.

  Raises `Ecto.NoResultsError` if the Chat does not exist.

  ## Examples

      iex> get_chat!(123)
      %Chat{}

      iex> get_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chat!(id), do: Repo.get!(Chat, id)

  def create_chat(%{"type" => type, "participant_ids" => ptcp_ids}) do
    case type do
      "direct" -> direct_chat(ptcp_ids)
      _ -> :error
    end
  end

  @doc """
  Gets a direct chat for the set of participants or creates if not exists.

  ## Examples

      iex> direct_chat(%{user_id: 1, user_id: 2})
      {:ok, %Chat{}}

      iex> direct_chat(bad_params)
      {:error, %Ecto.Changeset{}}

  """
  def direct_chat(participant_ids) do
    fingerprint = direct_fingerprint(participant_ids)
    params =  %{type: "direct", direct_fingerprint: fingerprint}
    case Repo.get_by(Chat, params) do
      nil ->
        participants = fingerprint |> Enum.map(fn(id) -> %{user_id: id} end)
        params |> Map.put(:participants, participants) |> insert_chat
      chat -> {:ok, chat}
    end
  end

  defp direct_fingerprint(participant_ids) do
    participant_ids
      |> Enum.uniq
      |> Enum.filter(&(&1))
      |> Enum.sort
  end

  defp insert_chat(attrs) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:participants)
    |> Repo.insert
  end
end
