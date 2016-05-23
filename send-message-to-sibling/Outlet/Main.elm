module Outlet.Main exposing (..)

import Html exposing (..)
import Outlet.Msg exposing(Msg(..))

-- MODEL

type alias Model =
  String

initialModel : Model
initialModel =
  ""

-- VIEW

view : Model -> Html Msg
view model =
  div
    []
    [ text model ]

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Message message ->
      ( message, Cmd.none )
