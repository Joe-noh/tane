# Tane

Tane means seeds.

```elixir
# priv/repo/seeds/user.exs

import Tane

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
$ mix tane --path priv/another_repo/seeds
```

If you want to delete all data before seeding, `delete_all!/1` is useful.

```elixir
repo(MyApp.Repo)
|> model(MyApp.User)  # have to register these two before delete_all!.
|> delete_all!
|> seed(name: "Bob",  email: "bob@black.com")
```
