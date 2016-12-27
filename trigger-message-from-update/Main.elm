module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Task exposing (Task)


-- MESSAGES


type Msg
    = Click
    | Message String



-- MODEL


type alias Model =
    String



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ div
            []
            [ text model
            ]
        , button [ onClick Click ] [ text "Click" ]
        ]



-- UPDATE


{-|
To trigger an action from update use Task.succeed
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            let
                fx =
                    Task.succeed "Hello"
                        |> Task.perform Message
            in
                ( model, fx )

        Message msg ->
            ( msg, Cmd.none )



-- APP


init : ( Model, Cmd Msg )
init =
    ( "Click", Cmd.none )


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
