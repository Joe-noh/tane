# Tane

Tane means seeds.

```elixir
# priv/repo/seeds/user.exs

import Tane

init
|> repo(MyApp.Repo)
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
