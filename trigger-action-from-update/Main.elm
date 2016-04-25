module Main (..) where

import StartApp
import Html exposing (..)
import Html.Events exposing (onClick)
import Task exposing (Task)
import Effects exposing (Effects, Never)
import Signal exposing (Address)


-- ACTIONS


type Action
  = Click
  | Message String



-- MODEL


type alias Model =
  String



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ div
        []
        [ text model
        ]
    , button [ onClick address Click ] [ text "Click" ]
    ]



-- UPDATE


{-|
To trigger an action from update use Task.succeed
-}
update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Click ->
      let
        fx =
          Task.succeed (Message "Hello")
            |> Effects.task
      in
        ( model, fx )

    Message msg ->
      ( msg, Effects.none )



-- APP


init : ( Model, Effects Action )
init =
  ( "Click", Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { view = view
    , update = update
    , init = init
    , inputs = []
    }


main : Signal Html
main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
