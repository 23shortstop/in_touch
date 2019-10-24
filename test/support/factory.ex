defmodule InTouch.Factory do
  use ExMachina.Ecto, repo: InTouch.Repo

  def user_factory do
    %InTouch.Identification.User{
      name: Faker.Name.name(),
      password: '123123'
    }
  end

  def chat_factory do
    %InTouch.Messaging.Chat{
      users: build_pair(:user)
    }
  end
end
