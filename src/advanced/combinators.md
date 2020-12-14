# Combinators

Combinators is a technique where combining several values of the same type gives us back a value of the same type.

For example:

```haskell
and : Filter -> Filter -> Filter
```

`and` is a function that takes two filters and combines them using an `AND` join. It gives us back another `Filter`.
Given that the return value is the same type, we can keep combining them endlessly.

Some examples of combinators are:

- Html
- Cmd.batch
- Parsers
- JSON Decoder / Encoders
- Filters e.g. (a AND (b OR c))
- Validations

Anything that resembles a tree is a good candiate for using combinators.

Combinators allow us to:

- Easily test each small part in isolation
- Make complex systems from very small part
- Create different combinations by cherry picking the parts we need
