# Outcome

As described in [Nested TEA](./nested-tea.html) it is sometimes useful to create a nested Elm architecture. In that case we might want to send a message from the child to the parent after an action.

One simple way to do this is by returning a third value in the `update` function of the child.

```haskell
module Child exposing
    ( Outcome(..)
    , update
    , ...
    )

type Outcome
  = OutcomeNone
  | OutcomeDateUpdated Date

update : Msg -> Model -> (Model, Cmd Msg, Outcome)
```

Then the parent module can deal with that:

```haskell
module Parent exposing (...)

import Child

...

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ChildMsg childMsg ->
      let
        (nextChildModel, childCmd, childOutcome) =
          Child.update childMsg model.childModel

      -- Do something with the childOutcome

    ...
```
