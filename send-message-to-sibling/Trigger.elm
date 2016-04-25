module Trigger (..) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Effects exposing (Effects, Never)
import Signal exposing (Address)


-- ACTIONS


type Action
  = Trigger
  | TaskDone ()



-- MODEL


type alias Model =
  String


initialModel : Model
initialModel =
  ""



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ button
        [ onClick address Trigger ]
        [ text "Trigger" ]
    ]



-- UPDATE


{-|
update expects an address where to send a message.
Instead of passing the model directly to update we pass a context
which contains the model and the address.
-}
type alias UpdateContext =
  { model : Model
  , showMessageAddress : Address String
  }


{-|
The trigger action returns an effect which send a message to the
given address.
-}
update : Action -> UpdateContext -> ( Model, Effects Action )
update action context =
  case action of
    Trigger ->
      let
        fx =
          Signal.send context.showMessageAddress "Hello"
            |> Effects.task
            |> Effects.map TaskDone
      in
        ( context.model, fx )

    TaskDone () ->
      ( context.model, Effects.none )
