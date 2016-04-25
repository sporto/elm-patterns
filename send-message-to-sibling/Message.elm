module Message (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Signal exposing (Address)


-- ACTIONS


type Action
  = Message String



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
    [ text model ]



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Message message ->
      ( message, Effects.none )
