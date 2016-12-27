module Main exposing (..)

import Html exposing (..)


-- MESSAGES


type Msg
    = NoOp



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
            [ text model ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- APP


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


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
