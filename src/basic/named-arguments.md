# Named arguments

There are times when the order of arguments for a functions can be ambiguous. For example:

```haskell
isBefore : Date -> Date -> Bool
```

What is the subject date here and the comparison date? 

As we usually put the data at the end (for pipelines) we might think that the subject is the second date, but maybe is not. This is vague and error prone.

In this cases is better if we ask for a record as argument:

```haskell
isBefore : { subject: Date, comparedTo: Date } -> Bool
```

This might not be pipeline friendly, but it is a lot more precise and hard to get wrong.
