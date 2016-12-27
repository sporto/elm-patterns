module Main exposing (..)

import Html exposing (..)
import Task
import Msg exposing (Msg(..))
import Outlet.Main
import Outlet.Msg
import Trigger.Main
import Debug


-- MODEL


type alias Model =
    { message : Outlet.Main.Model
    , trigger : Trigger.Main.Model
    }


initialModel : Model
initialModel =
    { message = Outlet.Main.initialModel
    , trigger = Trigger.Main.initialModel
    }



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ Html.map TriggerMsg (Trigger.Main.view model.trigger)
        , Html.map OutletMsg (Outlet.Main.view model.message)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        -- ShowMessage returns an effect which send the message to the Message component
        ShowMessage message ->
            let
                cmd =
                    Task.succeed message
                        |> Task.perform Outlet.Msg.Message
            in
                ( model, Cmd.map OutletMsg cmd )

        TriggerMsg subMsg ->
            let
                ( subModel, cmd, mainCmd ) =
                    Trigger.Main.update subMsg model.trigger

                cmds =
                    Cmd.batch [ Cmd.map TriggerMsg cmd, mainCmd ]
            in
                ( { model | trigger = subModel }, cmds )

        OutletMsg subMsg ->
            let
                ( subModel, cmd ) =
                    Outlet.Main.update subMsg model.message
            in
                ( { model | message = subModel }, Cmd.map OutletMsg cmd )



-- APP


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
