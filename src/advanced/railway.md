# The railway pattern

The railway pattern is a way of chaining operations where each might fail.
It is called railway because there are two tracks in this pattern.

- The first track is the happy path
- The second track is the error track

If any of the chained functions fails we move to the error track. From there we get an error at the end of the railway.

For example, let say we want to:

- Parse some external data
- Validate the parsed data
- Transform the data into something else

```elm
parseData : String -> Result String ParsedData

validateData : ParsedData -> Result String ValidData

transformData : ValidData -> Result String TransformedData
```

## Pattern

In Elm this is commonly done using `Maybe.andThen` and `Result.andThen`. These function will run the next function in the chain if the previous function was successful, otherwise they will propage the error.

```elm
process : String -> Result String TransformedData
process data =
	parseData data
		|> Result.andThen validateData
		|> Result.andThen transformData
```

[Here is an excellent post about this with a lot more details](https://fsharpforfunandprofit.com/rop/).

## Variant

A variant of this is where the second track doesn't represent an error, but rather an early exit.

E.g. This process finds recommendations for a user. Each function in the chain can add to the recommendations or choose to exit the process.


```elm
type Process
	= Continue Recommendation
	| Exit Recommendation

andThen : (Recommendation -> Process) -> Process -> Process
andThen callback process =
	case process of
		Continue document -> callback document
		Exit document -> Exit document

findRecommendations user =
	Continue emptyRecommendation
		|> andThen (findMusic user)
		|> andThen (findBooks user)
		|> andThen (findMovies user)
		|> andThen (findGames user)

findMusic : User -> Recommendation -> Process

...
```

`andThen` is a function that mirrors `Result.andThen` but specific for `Process`.
