module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    { calendarModel : CalendarModel
    , selected : Int
    }


newModel : Model
newModel =
    { calendarModel = newCalendarModel
    , selected = 0
    }


type Msg
    = Calendar CalendarMsg


init : () -> ( Model, Cmd Msg )
init _ =
    ( newModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Calendar subMessage ->
            case calendarUpdate subMessage model.calendarModel of
                CalendarInProgress nextModel cmd ->
                    ( { model | calendarModel = nextModel }
                    , Cmd.map Calendar cmd
                    )

                CalendarClosed nextModel ->
                    ( { model | calendarModel = nextModel }
                    , Cmd.none
                    )

                CalendarDateSelected nextModel date ->
                    ( { model | calendarModel = nextModel, selected = date }
                    , Cmd.none
                    )


view : Model -> Html Msg
view model =
    div []
        [ text "Selected: "
        , text <| String.fromInt model.selected
        , calendarView model.calendarModel |> Html.map Calendar
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- Another module e.g. Calendar.elm


type alias CalendarModel =
    { count : Int
    , isOpen : Bool
    }


newCalendarModel : CalendarModel
newCalendarModel =
    { count = 0
    , isOpen = False
    }


type CalendarMsg
    = CalendarOpen
    | CalendarIncrement
    | CalendarClose
    | CalendarSelect Int


type CalendarOutcome
    = CalendarInProgress CalendarModel (Cmd CalendarMsg)
    | CalendarDateSelected CalendarModel Int
    | CalendarClosed CalendarModel


calendarUpdate : CalendarMsg -> CalendarModel -> CalendarOutcome
calendarUpdate msg model =
    case msg of
        CalendarOpen ->
            CalendarInProgress { model | isOpen = True } Cmd.none

        CalendarIncrement ->
            CalendarInProgress { model | count = model.count + 1 } Cmd.none

        CalendarSelect date ->
            CalendarDateSelected { model | isOpen = False } date

        CalendarClose ->
            CalendarClosed { model | isOpen = False }


calendarView : CalendarModel -> Html CalendarMsg
calendarView model =
    let
        calendar =
            if model.isOpen then
                div []
                    [ div [] [ text <| String.fromInt model.count ]
                    , button [ onClick CalendarIncrement ] [ text "+1" ]
                    , button [ onClick (CalendarSelect model.count) ] [ text "Select" ]
                    , button [ onClick CalendarClose ] [ text "Close" ]
                    ]

            else
                text ""
    in
    div []
        [ button [ onClick CalendarOpen ] [ text "Open" ]
        , calendar
        ]
