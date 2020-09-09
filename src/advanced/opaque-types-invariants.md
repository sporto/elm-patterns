# Opaque types for enforcing invariants

Some times we want our data to always follow certain rules. E.g. We would like a list that is always sorted.

Using opaque types we can create a module that enforces this invariant.

```haskell
module SortedList

exposing (SortedList, new, add)

type SortedList a =
	SortedList (List a)

new : SortedList a
new =
	SortedList []

add : (a -> a -> Order) -> a -> SortedList a -> SortedList a
```

Only this module can create a `SortedList` as we don't expose the constructor.

Also, only this module can add an item to the list. By doing this we can enforce that the list is always sorted. External modules cannot change this data, so they are unable to break the sort invariant.
