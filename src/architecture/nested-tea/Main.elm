module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    { count : Int
    , subModel : SubModel
    }


newModel : Model
newModel =
    { count = 0
    , subModel = newSubModel
    }


type Msg
    = Increment
    | Sub SubMsg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Sub subMessage ->
            { model
                | subModel =
                    subUpdate subMessage model.subModel
            }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text <| String.fromInt model.count ]
        , button [ onClick Increment ] [ text "+1" ]
        , subView model.subModel |> Html.map Sub
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = newModel
        , view = view
        , update = update
        }



-- Another module e.g. Page1.elm


type alias SubModel =
    { count : Int }


newSubModel : SubModel
newSubModel =
    { count = 0
    }


type SubMsg
    = SubIncrement


subUpdate : SubMsg -> SubModel -> SubModel
subUpdate msg model =
    case msg of
        SubIncrement ->
            { model | count = model.count + 1 }


subView : SubModel -> Html SubMsg
subView model =
    div []
        [ div [] [ text <| String.fromInt model.count ]
        , button [ onClick SubIncrement ] [ text "+1" ]
        ]
