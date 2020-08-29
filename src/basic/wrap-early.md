# Wrap early, unwrap late

To avoid type blidness, you probably want to wrap your values in unique types.

When you do this it is a good idea to wrap your types as early as possible. E.g. when decoding values from external sources.

Then try to unwrap as late as possible.

## Example anti-patterns

```elm
displayPriceInDollars : Float -> String
displayPriceInDollars price =
    "USD$" ++ String.fromFloat price
```

There is nothing stopping us from passing something that is not dollars here (e.g. we might use Euros).

```elm
calculateTotalPrice: List Float -> Float
```

We could send a list of mixed currencies e.g. dollars and euros.

## Pattern

```elm
type Dollar = Dollar Float

displayPriceInDollars : Dollar -> String
displayPriceInDollars (Dollar price) =
    "USD$" ++ String.fromFloat price
```

This enforces that we use the `Dollar` type as much as possible.
