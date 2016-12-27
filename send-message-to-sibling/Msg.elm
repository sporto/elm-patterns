module Msg exposing (..)

import Outlet.Msg
import Trigger.Msg


type Msg
    = ShowMessage String
    | TriggerMsg Trigger.Msg.Msg
    | OutletMsg Outlet.Msg.Msg
