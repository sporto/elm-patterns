# Global actions

If we use the nested TEA for our application, we will most likely need a way for the nested modules to communicate with the top levels. For example:

- Open a notification
- Sign out the user
- Return a value to the top level

There are many way of achieving this. One possible way is to have a module with global actions e.g.

```haskell
module Actions exposing(..)

type Action
	= OpenSuccessNotification ...
	| OpenFailureNotifiation ...
	| ...
```

The all your nested module will return three elements on `update`. The third one being a list of actions to execute:

```haskell
update : Msg -> Model -> (Model, Cmd Msg, List Action)
```

Any nested module in the chain could add an action to the list.

Finally your root `update` will need to map through the list and process the actions.

---

- A nice pattern for adding actions is to mimic `Cmd.batch`. E.g. `Actions.batch`.
- We might need to send a message back to the module that returned the action. E.g. Open a dialogue with selections. In this case our actions might need a message associated with them e.g. `Action Msg`. We will need a `Actions.map` to just like `Html.map`.
