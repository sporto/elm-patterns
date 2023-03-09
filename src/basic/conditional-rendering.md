# Conditional rendering

Many time we want to conditionally render an element. For example, sometimes we want to render a banner, sometimes we don't. Here are some common patterns for this:

## Using Maybe

We can write our HTML like:

```elm
[ Just headerElement
, maybeBanner showBanner
, Just content
, Just footerElement
] |> List.filterMap identity

maybeBanner showBanner =
  if showBanner then
     Just bannerElement
  else
    Nothing
```

In this pattern we create a list of Maybes, and then use `List.filterMap identity` to remove the  Nothings.

## Using a no-op

We can also achieve this using:

```elm
[ headerElement
, maybeBanner showBanner
, content
, footerElement
]

maybeBanner showBanner =
  if showBanner then
     bannerElement
  else
    text ""
```

In this case `text ""` is a no-op (No operation). So nothing gets rendered.
To achieve the same for attributes we can use `class ""`.

## Using list concatenation

And we could also write our HTML like:

```elm
( [ headerElement ]
++ maybeBanner showBanner
++ [ content, footerElement ]
)

maybeBanner showBanner =
  if showBanner then
    [ bannerElement ]
  else
    []
```

In this case we use list concatenation to assemble the HTML. When we don't need to render the banner we can return an empty list.
