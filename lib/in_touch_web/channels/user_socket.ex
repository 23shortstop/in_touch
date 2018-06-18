defmodule InTouchWeb.UserSocket do
  use Phoenix.Socket
  alias InTouch.Identification.AuthToken

  ## Channels
  channel "user:*", InTouchWeb.UserChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token}, socket) do
    case AuthToken.verify(token) do
      {:ok, user_id} -> {:ok, assign(socket, :user_id, user_id)}
      _ -> {:error, :unauthorized}
    end
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
