# Arguments list

The builder patterns gives us to build configuration. We could also use plain lists for this:

```haskell
view =
  shape
    [ scale 0.5 0.5 0.5
    , position 0 -6 -13
    , rotation -90 0 0
    ]
```

Our module exposes a series of functions that return a common type e.g.

```haskell
scale : Float -> Float -> Float -> Attribute

rotation : Int -> Int -> Int -> Attribute
```

Using that we can build a `List Attribute` and pass it to a function as configuration.

This is the pattern used in elm/html, elm/svg, elm-css, elm-ui.

- This pattern is best used with Opaque types. As we don't usually want the caller to be able access the returned type (e.g. `Attribute`).
- This pattern is best when all arguments are optional as we cannot avoid having the caller pass an empty list.


