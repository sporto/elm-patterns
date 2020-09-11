# The effects pattern

In a usual Elm application the `update` function returns `(Model, Cmd Msg)`. Commands in Elm are an opaque types so testing update functions is not easy. We cannot easily inspect the commands and see if they are doing the right thing, we cannot also simulate these commands as we don't know what they are doing.

## Pattern

What pattern to deal with this is returning an `Effect` type instead of `Cmd msg`.

```haskell
type Effect
	= SaveUser User
	| LogoutUser
	| LoadData
	| ...

update : Msg -> Model -> (Model, List Effect)
```

At the last moment possible we will have a function that converts the `Effect` into actual commands:

```haskell
runEffects : List Effect -> Cmd Msg
```

This makes a Elm application a lot more testable. This is approach taken by [elm-program-test](https://elm-program-test.netlify.app/cmds.html).

---

A [blog post about this pattern](http://reasonableapproximation.net/2019/10/20/the-effect-pattern.html)
