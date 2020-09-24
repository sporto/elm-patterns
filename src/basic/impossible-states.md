# Make impossible states impossible

Elm has a great and expressible type system. This type system allows us to avoid having impossible states in our application.

## Anti-pattern

A common pattern is to have a boolean attribute to show a loading spinner while data is loading. e.g.

```haskell
type alias Model =
    { isLoading: Bool
    , data: Maybe Data
    }
```

But in this type is possible to have something like `isLoading = false` and `data = Nothing`. What is the meaning of this? This is probably an impossible state that should never happen.

## Pattern

Which Elm you can represent your types in ways that don't allow for impossible states. e.g

```haskell
type RemoteData
    = Loading
    | Loaded Data

type alias Model =
    { data : RemoteData }
```

[Here is an excellent talk about this](https://www.youtube.com/watch?v=IcgmSRJHu_8).
