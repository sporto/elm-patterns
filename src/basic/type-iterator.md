# Type iterator

When we have a list of all the variants in our custom type, 
sometimes that list can get out-of-sync when we add a new variant.

```elm
module Color exposing (Color(..), all)

type Color
    = Red
    | Yellow
    | Green
    | Blue -- Recently added

all : List Color
all =
    [ Red, Yellow, Green ]
    -- Forgot to add Blue here
```

It would be nice if the compiler could remind us. 
Especially so if there are many variants.

We can get the compiler to remind us a missing variant by 
building our list with a `case` statement.

```elm
module Color exposing (Color(..), all)

type Color
    = Red
    | Yellow
    | Green
    | Blue -- Recently added

all : List Color
all =
    next [] |> List.reverse

next : List Color -> List Color
next list =
    case List.head list of
        Nothing ->
            Red :: list |> next
        
        Just Red ->
            Yellow :: list |> next

        Just Yellow -> 
            Green :: list |> next

        Just Green ->
            list -- return the list as is on the final variant

        -- Blue is still missing, but now, the compiler will complain
        -- until we add it here

```

Important: We should never use wildcard matching `_` in the `next` function.
It would prevent the compiler from detecting new variants.