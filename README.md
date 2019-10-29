# InTouch

InTouch is my sample elixir/phoenix application.
It will be a kind of online-chat.

### Implemented features:
  * user registration and authorization;

### ToDo features:
  * direct messaging;
  * users presence tracking;
  * group messaging.

### Live staging is available here:
https://in-touch-23.herokuapp.com


### To start application locally:

  * Create a `config.secret.exs` file on a base of `config.secret.exs.sample` in the `config` directory
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
