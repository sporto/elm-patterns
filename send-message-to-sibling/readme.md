I want to send a message to a sibling component.

- Component `Trigger` wants to send a message to `Message`

## Solution

- This patterns uses an auxiliary mailbox for sending messages between components
- The `Trigger` component sends the message to this mailbox
- When a message is received in this mailbox it is redirected to the `Message` component

## Running

Use Elm reactor.
