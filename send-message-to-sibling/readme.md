I want to send a message to a sibling component.

- Component `Trigger` wants to send a message to `Outlet`

## Solution

- The trigger component returns a third value in `update`. This third value is a root message.
- Then the main component reacts to this root message creating a message for the Outlet component.

## Running

Use Elm reactor. Open `Main.elm`.
