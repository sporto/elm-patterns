# Elm Patterns

![github pages](https://github.com/sporto/elm-patterns/workflows/github%20pages/badge.svg)

A collection of common patterns in Elm <http://sporto.github.io/elm-patterns/>.

## Development

### mdbook

This book uses mdbook: <https://github.com/rust-lang/mdBook>

To view locally run

```
mdbook serve -p 5000
```

Deployment is done automatically via github actions (No need to build the book).

## Contributing

This guide documents patterns that are commonly used in Elm applications.

- Avoid uncommon or esoteric patterns.
- The pattern explanation needs to be as simple as possible. Don't write a whole essay for each one. They should be easy to read and understand in a few minutes (whenever possible).
- Avoid complex terminology e.g. Monads, Applicative, etc. Unless this is really critical for understanding the pattern.
- The pattern explanation doesn't need to be thorough (i.e. show all the code). As long at it conveys the idea and benefits. Linking to a more detailed source is great.
- These patterns should try to align with the community recommendations and best practices.
- Write in first person voice using the pronoun "we". E.g. "We might choose to use X".
