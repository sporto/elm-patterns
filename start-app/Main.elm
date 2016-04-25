module Main (..) where

import StartApp
import Html exposing (..)
import Task exposing (Task)
import Effects exposing (Effects, Never)
import Signal exposing (Address)


-- ACTIONS


type Action
  = NoOp



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
        [ text model ]
    ]



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )



-- APP


init : ( Model, Effects Action )
init =
  ( "Hello", Effects.none )


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
