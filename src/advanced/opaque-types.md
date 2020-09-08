# Opaque types

Opaque types are types that cannot be created outside of a specific module. For example:

```haskell
module Lib

exposing (Config)

type Config = Config { size: Int, style: Style }
```

This module expose the `Config` type but not the constructor. An external module can't construct or modify a `Config` type.

Opaque types are useful for:

- Enforcing invariants: Only the relevant module can change the data. Other parts of the application cannot reach and change it.
- Hiding the implementation to external modules.
- Building packages as they hide the implementation of something. Hiding a type like this makes it easier to change the implementation without breaking the code using it.

## Anti-pattern

```haskell
module Lib

exposing (Config)

type alias Config = { size: Int, style: Style }
```

This module exposes `Config` transparently. Any changes we want to make will require changes in the module using this. In the case of a package, if we remove or change a type in `Config` we will have to publish a major version of this package.

## Pattern

```haskell
module Lib

exposing (Config, newConfig, withSize)

type Config = Config { size: Int, style: Style }

newConfig : Config
newConfig =
	Config { size: 1, style : Big }

withSize : Int -> Config -> Config
```

This module allows an application to create a `Config` and update it. But if we decide to change how we store the `Config` we can do so without any breaking changes for the caller module using this.

