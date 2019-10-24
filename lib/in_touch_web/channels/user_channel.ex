defmodule InTouchWeb.UserChannel do
  use InTouchWeb, :channel

  def join("user:" <> id, _payload, socket) do
    if authorized?(id, socket) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  defp authorized?(id, socket) do
    String.to_integer(id) == socket.assigns.user_id
  end
end
