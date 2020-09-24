# Unwrap Maybe and Result early

If you have a `Maybe`, `Result` or `RemoteData` it is often a good idea to try to unwrap those as early as possible.

## Anti-pattern

```haskell
userCard : Maybe User -> Html Msg
userCard maybeUser =
   div []
        [ userInfo maybeUser
        , userActivity maybeUser
        ]
```

In here both `userInfo` and `userActivy` get a `Maybe User`. Meaning that will need to unwrap this value several times in your views.

## Pattern

```haskell
userCard maybeUser =
    case maybeUser of
        Nothing ->
            div [] [ ... ]

        Just user ->
            div []
                [ userInfo user
                , userActivity user
                ]
```

Here the sub views take a `User`, this makes most of your views easier to write and test. 
