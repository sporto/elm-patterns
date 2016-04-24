module Main where

import StartApp
import Html exposing (..)
import Html.Events exposing (onClick)
import Task exposing (Task)
import Effects exposing (Effects, Never)

-- ACTIONS

type Action
  = Click
  | Greet

-- MODEL

type alias Model = String

-- VIEW
view address model =
    div [] [
      div [] [
        text model
      ],
      button [ onClick address Click ] [ text "Click" ]
    ]

-- UPDATE

update action model =
  case action of
    Click ->
      (model, Effects.none)
    Greet ->
      (model, Effects.none)

-- APP

init =
  ("Click", Effects.none)

app = StartApp.start {
  view = view,
  update = update,
  init =init, 
  inputs = [] 
 }

main =
  app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
