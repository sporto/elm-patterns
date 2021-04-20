# The effects pattern

In a usual Elm application the `update` function returns `(Model, Cmd Msg)`. `Cmd` in Elm is an opaque type so `update` functions are not easy to test. We cannot easily inspect the commands and see if they are doing the right thing. We cannot also simulate these commands as we don't know what they are doing.

## Pattern

The **effects pattern** allows us to deal with these issues by returning an `Effect` type instead of `Cmd msg` from `update`.

```haskell
type Effect
	= SaveUser User
	| LogoutUser
	| LoadData
	| ...

update : Msg -> Model -> (Model, List Effect)
```

At the last possible moment we convert the `Effect` into actual commands. E.g. in the root module of the app we would have a function like:

```haskell
runEffects : List Effect -> Cmd Msg
```

This makes a Elm application a lot more testable. This is approach taken by [elm-program-test](https://elm-program-test.netlify.app/cmds.html).

Here is a more detailed [blog post about this pattern](http://reasonableapproximation.net/2019/10/20/the-effect-pattern.html).
