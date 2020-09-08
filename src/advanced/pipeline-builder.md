# Pipeline builder

This is a common pattern used for decoders and validation. This pattern is used to build a function for processing some data using a series of piped functions.

```haskell
type alias User =
	{ name: String
	, age: Int
	}

validateUser : User -> Result String User
validateUser user =
    Ok User
        |> validateName user.name
        |> validateAge user.age
```

This builds a function `validateUser` that will take a user and validate it. This `validateUser` function works like the railway pattern. We might get an `Ok User` at the end or an error `Err String`.

This pattern relies on the fact that a type alias in Elm can be used as a function. e.g. `User` is a function like:

```haskell
String -> Int -> User
```

We start by putting the function (`User`) into a Result.

Then each function in the chain takes an attribute and the previous result, does the validation and returns a result back.

```haskell
validateName : String -> Result String (String -> a) -> Result String a
validateName name =
    Result.andThen
        (\constructor ->
            if String.isEmpty name then
                Err "Invalid name"

            else
                Ok (constructor name)
        )
```

Complete example <https://ellie-app.com/9SZTHJqB5r2a1>

## Caveat

When using this pattern we have to be careful with the order of functions in the pipeline. It is easy to make a mistake when the end type has many attribute of the same type.

```haskell
type alias User =
	{ name: String
	, email: String
	}
```

With this type, we can mix up the order of name validation and email validation e.g.

```haskell
    Ok User
        |> validateEmail user.email
        |> validateName user.name
```

This will work, but give us a broken user.

---

Some example packages using this:

- Json decoding <https://package.elm-lang.org/packages/elm/json/latest/Json.Decode>
- Validation <https://package.elm-lang.org/packages/stoeffel/elm-verify/latest/>
- More validation <https://package.elm-lang.org/packages/gege251/elm-validator-pipeline/>
