# Reusable views

It is common to need reusable views in our applications. The most basic way in Elm is to have view functions that take message constructors as arguments.

For example:

```haskell
type alias Args msg =
	{ currentDate: Date
	, isOpen: Bool
	, onOpen: msg
	, onClose: msg
	, onSelectDate : Date -> msg
	}

calendar : Args msg -> Html msg
calendar args =
```

This view is easy to integrate and reuse. However it requires the caller to keep track of the state e.g. `isOpen`.
Another limitation is that this view is incapable of producing commands.

## Using the builder pattern

Reusable views like these are perfect candidates for the builder pattern:

```haskell
Button.newArgs "Clear selection" Clear
	|> Button.withIcon IconClear
	|> Button.withSize Button.Wide
	|> Button.view
```
