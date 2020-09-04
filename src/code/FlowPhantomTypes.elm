module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


type alias Order =
    { total : Int
    , quantity : Int
    }


initialOrder : Order
initialOrder =
    { total = 0
    , quantity = 0
    }


type Msg
    = OrderTotalInc
    | OrderTotalDec
    | QuantityInc
    | QuantityDec


priceEach =
    5


update : Msg -> Order -> Order
update msg order =
    case msg of
        OrderTotalInc ->
            flowPrioritizingTotal (order.total + priceEach) order

        OrderTotalDec ->
            flowPrioritizingTotal (order.total - priceEach) order

        QuantityInc ->
            flowPrioritizingQuantity (order.quantity + 1) order

        QuantityDec ->
            flowPrioritizingQuantity (order.quantity - 1) order


type Step step
    = Step Order


type Start
    = Start


type AfterTotal
    = AfterTotal


type AfterQuantity
    = AfterQuantity


type Done
    = Done


setTotal : Int -> Step Start -> Step AfterTotal
setTotal total (Step model) =
    Step { model | total = total }


adjustQuantityFromTotal : Step AfterTotal -> Step Done
adjustQuantityFromTotal (Step model) =
    Step { model | quantity = model.total // priceEach }


setQuantity : Int -> Step Start -> Step AfterQuantity
setQuantity quantity (Step order) =
    Step { order | quantity = quantity }


adjustTotalFromQuantity : Step AfterQuantity -> Step Done
adjustTotalFromQuantity (Step order) =
    Step { order | total = order.quantity * priceEach }


done : Step Done -> Order
done (Step order) =
    order


flowPrioritizingTotal total order =
    Step order
        |> setTotal total
        |> adjustQuantityFromTotal
        |> done


flowPrioritizingQuantity quantity order =
    Step order
        |> setQuantity quantity
        |> adjustTotalFromQuantity
        |> done


view : Order -> Html Msg
view order =
    div []
        [ h3 [] [ text "Price each" ]
        , span [] [ text <| String.fromInt priceEach ]
        , h3 [] [ text "Order total" ]
        , button [ onClick OrderTotalDec ] [ text "-" ]
        , button [ onClick OrderTotalInc ] [ text "+" ]
        , span [] [ text <| String.fromInt order.total ]
        , h3 [] [ text "Quantity" ]
        , button [ onClick QuantityDec ] [ text "-" ]
        , button [ onClick QuantityInc ] [ text "+" ]
        , span [] [ text <| String.fromInt order.quantity ]
        ]


main : Program () Order Msg
main =
    Browser.sandbox
        { init = initialOrder
        , view = view
        , update = update
        }
