# The builder pattern

When we need to pass many arguments to a function we might have something like

```haskell
module Button exposing (..)

type alias Args =
    { isEnabled : Bool
    , label : String
    , hexColor : String
    , ...
    }

btn: Args -> Html msg
```

In the caller module:

```haskell
import Button

Button.btn { isEnabled = True, label = "Click me", ....}
```

The problem with this is that each time we add an argument to `Args` we need to change every single place where we call this function.

## Pattern

With builder pattern we build the arguments with the minimum necessary information, then modify the arguments if we need to.

```haskell
module Button exposing (..)

newArgs: String -> Args
newArgs label =
    { isEnabled = True
    , label = label
    , hexColor: "#ABC"
    , ...
    }

withIsEnabled : Bool -> Args -> Args
withIsEnabled isEnabled args =
    { args | isEnabled = isEnabled }

btn: Args -> Html msg
```

This modules exposes a function to create the initial arguments and a series of function to modify the arguments (commonly using `with` as prefix).

Then the caller module uses this:

```haskell
import Button

aButton =
    Button.newArgs "Click me"
        |> Button.withIsEnabled False
        |> Button.withHexColor "#123"
        |> Button.btn
```

The advantage of this is that adding new arguments to `Args` doesn't require us to change every caller.

## As test factories

This pattern is also very useful for tests. Similar to test factories in many languages. For example if we were testing a `User`, we could start with a basic user and then use the builder pattern to modify attributes for different tests.
