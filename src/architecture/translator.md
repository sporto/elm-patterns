# Translator

As described in [Nested TEA](./nested-tea.html) it is sometimes useful to create a nested Elm architecture. When making this we normally would use `Html.map` to route messages back to the nested module.

For example, in the parent container you would have:

```haskell
module Parent exposing(..)

import Child

Child.view model.childModel |> Html.map ChildMsg
```

The challenge of using `Html.map` here is that messages produced in the child module always need to route back to itself. We cannot easily produce a message in the child destined to its parent.

As an application grows it is common to encounter something like this, perhaps we need a UI element in the child module that needs to send the message to its parent.

## Pattern

The solution to this is to make the child module views generic and provide a constructor for routing messages. So, instead of `View Msg` in the child module, it becomes `View msg`. Then the parent explicitly provides the constructor to route messages.

For example, we have a child module with a view like:

```haskell
module Child exposing(..)

view: Model -> Html Msg
view model =
  div []
  [ button [ onClick Clicked ] [ text model.name ]
  ]
```

We want to add another button, but this time it should send a message to its parent.

### First, make the child module generic

```haskell
module Child exposing(..)

view: Model -> (Msg -> msg) -> Html msg
view model toSelf =
  div []
  [ button [ onClick (toSelf Clicked) ] [ text model.name ]
  ]
```

To `toSelf` is a constructor that wraps the internal message, producing a parent message. This replaces `Html.map` in the parent module and will route the message back to this module.

In the parent container we would use this view like:

```haskell
module Parent exposing(..)

import Child

type Msg = ChildMsg Child.Msg

view model =
  ...
  Child.view model.childModel ChildMsg
```

### Produce a parent message

With this setup we can produce parent messages from the child module.

```haskell
module Child exposing(..)

type alias Args msg =
  { toSelf : Msg -> msg
  , onSave: msg
  }

view: Model -> Args msg -> Html msg
view model args =
  div []
  [ button [ onClick (args.toSelf Clicked) ] [ "Send to self" ]
  , button [ onClick args.onSave ] [ text "Send to parent" ]
  ]
```

The parent would call this like:

```haskell
module Parent exposing(..)

import Child

type Msg
  = OnSave
  | ChildMsg Child.Msg

view model =
  ...
  Child.view
    model.childModel
    { toSelf = ChildMsg
    , onSave = OnSave
    }
```
