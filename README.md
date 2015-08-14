# Tane

[![Build Status](https://travis-ci.org/Joe-noh/tane.svg?branch=master)](https://travis-ci.org/Joe-noh/tane)

Tane means seeds.

```elixir
# priv/repo/seeds.exs

use Tane

repo(MyApp.Repo)
|> model(MyApp.User)
|> seed(name: "Bob",  email: "bob@black.com")
|> seed(name: "Mary", email: "mary@blue.com")
```

Then do this.

```
$ mix tane
```

You can specify the path.

```
$ mix tane --path priv/another_repo/seeds.exs
```

If you want to delete all data before seeding, `delete_all!/1` is useful.

```elixir
repo(MyApp.Repo)
|> model(MyApp.User)  # have to register these two before delete_all!.
|> delete_all!
|> seed(name: "Bob", email: "bob@black.com")
```

Use `get_by/2` to get saved models.

```elixir
use Tane

alias MyApp.User
alias MyApp.Post
alias MyApp.Repo

repo(Repo)
|> model(User)
|> seed(name: "bob")
|> seed(name: "mary")
|> model(Post)
|> seed(title: "Hello", body: "I'm bob", user_id: get_by(User, name: "bob").id)
```
