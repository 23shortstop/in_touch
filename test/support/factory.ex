defmodule InTouch.Factory do
  use ExMachina.Ecto, repo: InTouch.Repo
  alias Comeonin.Bcrypt

  def user_factory(attrs) do
    encrypted_password = attrs |> Map.get(:password, "123123") |> Bcrypt.hashpwsalt
    
    user = %InTouch.Identification.User{
      name: Faker.Name.name(),
      encrypted_password: encrypted_password
    }

    merge_attributes(user, attrs)
  end

  def chat_factory do
    %InTouch.Messaging.Chat{
      type: "direct",
      users: build_pair(:user)
    }
  end
end
