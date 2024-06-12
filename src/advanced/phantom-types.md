# Phantom types

Phantom types are types that have a type variable on the type that is not used constructors. E.g.

```haskell
type Users a =
	Users (List User)
```

This type variable allows us to restrict what type a function can take and return. For example:

```haskell
type Active
	= Active

activeUsers : List User -> Users Active
activeUsers users =
	users
		|> List.filter isActive
		|> Users
```

`activeUsers` is a function that takes all users and only returns active users.

Phantom types are useful for things like:

- Enforcing invariants in functions and views
- Validation
- State machines
- Processes

In the example below we could have a view that only takes active users:

```haskell
usersView : Users Active -> Html msg
```

The compiler will complain if we try to pass all users to this view. In this way it can be sure that we are filtering users correctly.
