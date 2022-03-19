# Minimize boolean usage

Boolean ambiguity can lead to loss of intent and loss of information in our code, resulting in ambiguous logic. To avoid this issue, we should prefer self-documenting alternatives whenever the intention is unclear.

This pattern is inspired by [Jeremy Fairbank](https://github.com/jfairbank)'s ["Solving the Boolean Identity Crisis"](https://www.youtube.com/watch?v=6TDKHGtAxeg) talk and [series of articles](https://programming-elm.com/blog/2019-05-20-solving-the-boolean-identity-crisis-part-1/), where he explains the rationale and the pattern in great details, if you want to delve deeper.

## Boolean Ambiguity

Boolean arguments can make code confusing and harder to maintain by hiding the intent of code.

### Anti-Pattern 1

What is the significance of the ```True``` value here without looking up the definition of ```bookFlight```?

```haskell
bookFlight "ELM" True
```

### Pattern 1

We can clean up the ```bookFlight``` function by replacing the boolean arguments with a ```Custom Type```:

```haskell
type CustomerStatus
    = Premium
    | Regular
    | Economy
```

Now calls to ```bookFlight``` declare the intent of code because we pass in the ```CustomerStatus``` directly:

```haskell
bookFlight "ELM" Premium
```

## Boolean Blindness

Returning `Bool` from a function can lead to boolean blindness. This happens because we get a value that the type system cannot use for enforcing further logic in the program.

### Anti-Pattern 2

For example:

```haskell
time =
    if isValid formData then
        submitForm formData

    else
        showErrors formData
```

In this snippet `isValid` only returns a `Bool`. We can call `submitForm` with the original `formData`. The compiler wouldn't complain if we swap the if-else branches.

### Pattern 2

Replace boolean return values with custom types to eliminate boolean blindness and leverage the compiler for safer code. In this example we do it with a ```Result Error Type```:

```haskell
time =
    case isValid formData of
        Ok validFormData ->
            submitForm validFormData

        Err errors ->
            showErrors errors
```

In this case `submitForm` is a function that can only be called with valid form data.
