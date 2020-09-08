# Type blindness

Type blindness is when you have several values of the same type that could get mixed up.

**Example 1**

```haskell
type alias User =
  { firstName: String, lastName: String }
```

Both attributes are `String`. It is easy to mix them up when receiving external information. 

**Example 2**

```haskell
priceInDollars : Float
priceInDollars = 2.0

priceInEuros : Float
priceInEuros = 1
```

Both values are `Float`. There is nothing preventing us from doing a non sensical operation like `priceInDollars + priceInEuros`.

## Pattern

In this case consider wrapping values in a unique type.

```haskell
type Dollar = Dollar Float

priceInDollars : Dollar
priceInDollar =
  Dollar 2.0
```

You will need to unwrap values later, which can get tedious, so use this when there is a good potential of mixing up values. 
