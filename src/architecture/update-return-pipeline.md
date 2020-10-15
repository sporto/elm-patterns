# Update return pipeline

Sometimes in the our update function we need to do many different things. For example:

- Change the state of the model
- Change some value in the browser query
- Conditionally load more data
- Do some analytics tracking

We can do all these things at once:

```haskell
case msg of
	SeeReport report ->
		let
			nextModel =
				{ model
					| stage = ReportVisible report
					, loading =
						if needsToLoadMoreData model then
							Loading
						else
							model.loading

				}
			cmd =
				Cmd.batch
					[
					if needsToLoadMoreData model then
						loadMoreDataCmd
					else
						Cmd.none
					, setSomeValueInUrl
					, TrackEvent.track {... }
					]
		in
		(nextModel, cmd)

	... ->
```

But in these cases our update branches can get very complex very quickly. Making them difficult to understand and ripe for bugs.

## Pattern

A nice way to make many things in an update branch is to break them by concerns and create a "return" pipeline.

```haskell
case msg of
	SeeReport report ->
		(model, Cmd.none)
			|> andThen (setStageToReportVisible report)
			|> andThen loadMoreDataIfNeeded
			|> andThen addKeyInUrl
			|> andThen trackSeeReportEvent
```

In this case `andThen` is a function like:

```haskell
andThen : (model -> (model, Cmd msg)) -> (model, Cmd msg) -> (model, Cmd msg)
andThen fn ( model, cmd ) =
    let
        ( nextModel, nextCmd ) =
            fn model
    in
    ( nextModel, Cmd.batch [ cmd, nextCmd ] )
```

This function takes another function that given the `model` returns a `(model, Cmd msg)` just like `update`.
`andThen` takes care of batching commands together.

Every function is the pipeline will be responsible for only one thing, which is a lot easier to understand. E.g.

```haskell
loadMoreDataIfNeeded : Model -> (Model, Cmd Msg)
loadMoreDataIfNeeded model =
	if needsToLoadMoreData model then
		({ model | loading = Loading }, loadMoreDataCmd)
	else
		(model, Cmd.none)
```

[elm-return is a package that implements functions for this.](https://package.elm-lang.org/packages/Fresheyeball/elm-return/)
