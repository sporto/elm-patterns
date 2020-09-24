# Parse don't validate

When we have external data (e.g. user input or remote data) it is a common pattern to validate this data before using it.

## Anti-pattern

A common approach is to ask if the data is valid and then use it e.g.

```haskell
type alias UserInput =
    { name: Maybe String
    , age: Maybe Int
    }

isValidUser : UserInput -> Bool
```

The problem with this approach is that after doing this you still have a `UserInput` with can still hold invalid values.

## Pattern

A better approach is to "parse" your input and return a known valid type. e.g.

```haskell
 type alias UserInput =
    { name: Maybe String
    , age: Maybe Int
    }

type alias ValidUser =
    { name: String
    , age: Int
    }

validateUser : UserInput -> Result String ValidUser
````

In this way you ensure that you have a valid type to work with later on. Some examples where this is useful:

- Validating user input
- Parsing JSON from external sources
