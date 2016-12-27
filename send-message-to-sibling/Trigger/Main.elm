module Trigger.Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Task
import Trigger.Msg exposing (Msg(..))
import Msg


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
        [ button
            [ onClick Trigger ]
            [ text "Trigger" ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg, Cmd Msg.Msg )
update msg model =
    case msg of
        Trigger ->
            let
                cmd =
                    Task.succeed "Hello"
                        |> Task.perform Msg.ShowMessage
            in
                ( model, Cmd.none, cmd )
