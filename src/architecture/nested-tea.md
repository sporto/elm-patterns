# The nested Elm architecture

When an application starts growing large we might want to break the application messages into discrete parts. For example:

- Root Application
	- Page 1
	- Page 2
	- ...

## Pattern

The nested Elm architecture is a way of achieving this.

```haskell
module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Sub


type alias Model =
    { count : Int
    , subModel : Sub.Model
    }


newModel : Model
newModel =
    { count = 0
    , subModel = Sub.newModel
    }


type Msg
    = Increment
    | Sub Sub.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Sub subMessage ->
            { model
                | subModel =
                    Sub.update subMessage model.subModel
            }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text <| String.fromInt model.count ]
        , button [ onClick Increment ] [ text "+1" ]
        , Sub.view model.subModel |> Html.map Sub
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = newModel
        , view = view
        , update = update
        }
```

Note the `Sub.view model.subModel |> Html.map Sub` in `view`.

Sub.elm :

```haskell

module Sub exposing (..)

...

type alias Model =
    { count : Int }


newModel : Model
newModel =
    { count = 0
    }


type Msg
    = Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text <| String.fromInt model.count ]
        , button [ onClick Increment ] [ text "+1" ]
        ]
```

This pattern comes with its own set of challenges like:

- Added boilerplate
- It is not simple for the child module to communicate with the parent module (see [Translator](./translator.html)).

So this pattern is best used sparingly.
