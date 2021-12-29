# Minimize Boolean Usage

Boolean ambiguity and boolean blindness can lead to loss of intent and loss of information in our code, resulting in an opaque logic. To avoid these issues, we should use self-documenting alternatives whenever it is a viable and sensible solution. That said, booleans aren't going anywhere. We'd still use them, parsimoniously, when necessary and if they don't obfuscate our code's logic.

This pattern is inspired by [Jeremy Fairbank](https://github.com/jfairbank)'s ["Solving the Boolean Identity Crisis"](https://www.youtube.com/watch?v=6TDKHGtAxeg) talk and [series of articles](https://programming-elm.com/blog/2019-05-20-solving-the-boolean-identity-crisis-part-1/), where he explains the rationale and the pattern in great details, if you want to delve deeper.

## Boolean Ambiguity

Boolean function arguments can make code confusing and unmaintainable by hiding the intent of code.

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

Boolean return values cause a problem known as boolean blindness.

### Anti-Pattern 2

When we reduce information to a boolean, we lose that information easily. This code may look fine but it can create accidental bugs in if-else expressions that the compiler can’t prevent.

```haskell
time =
    if doYouKnowTheTime person then
        tellMeTheTime person

    else
        "Does anybody really know what time it is?"
```

### Pattern 2

Replace boolean return values with custom types to eliminate boolean blindness and leverage the compiler for safer code. In this example we do it with a ```Maybe Type```:

```haskell
time =
    case whatTimeIsIt person of
        Just time ->
            time

        Nothing ->
            "Does anybody really know what time it is?"
```
