module Main (..) where

import StartApp
import Html exposing (..)
import Task exposing (Task)
import Effects exposing (Effects, Never)
import Signal exposing (Address, Mailbox)
import Message
import Trigger
import Debug


-- ACTIONS


type Action
  = ShowMessage String
  | NoOp
  | TriggerAction Trigger.Action
  | MessageAction Message.Action



-- MODEL


type alias Model =
  { message : Message.Model
  , trigger : Trigger.Model
  }


initialModel : Model
initialModel =
  { message = Message.initialModel
  , trigger = Trigger.initialModel
  }



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ Trigger.view (Signal.forwardTo address TriggerAction) model.trigger
    , Message.view (Signal.forwardTo address MessageAction) model.message
    ]



-- ACTIONS MAILBOX


{-|
In order to send events between component we create an Actions Mailbox.
This mailbox provides an address that can be given to a component.
-}
actionsMailbox : Mailbox Action
actionsMailbox =
  Signal.mailbox NoOp


{-|
Next we need an address that tags messages with ShowMessage
-}
showMessageAddress : Address String
showMessageAddress =
  Signal.forwardTo actionsMailbox.address ShowMessage



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case Debug.log "action" action of
    NoOp ->
      ( model, Effects.none )

    {-|
    ShowMessage returns an effect which send the message to the Message component
    -}
    ShowMessage message ->
      let
        fx =
          Task.succeed (Message.Message message)
            |> Effects.task
            |> Effects.map MessageAction
      in
        ( model, fx )

    TriggerAction subAction ->
      let
        context =
          { model = model.trigger
          , showMessageAddress = showMessageAddress
          }

        ( subModel, fx ) =
          Trigger.update subAction context
      in
        ( { model | trigger = subModel }, Effects.map TriggerAction fx )

    MessageAction subAction ->
      let
        ( subModel, fx ) =
          Message.update subAction model.message
      in
        ( { model | message = subModel }, Effects.map MessageAction fx )



-- APP


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


{-|
actionsMailbox needs to be an input to StartApp
-}
app : StartApp.App Model
app =
  StartApp.start
    { view = view
    , update = update
    , init = init
    , inputs = [ actionsMailbox.signal ]
    }


main : Signal Html
main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
