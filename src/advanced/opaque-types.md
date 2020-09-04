# Opaque types

Opaque types are types that cannot be created outside of a specific module. For example:

```elm
module Lib

exposing (Config)

type Config = Config { size: Int, style: Style }
```

This module expose the `Config` type but not the constructor. An external module can't construct or modify a `Config` type.
Opaque types are mostly useful for building packages as they hide the implementation of something. Hiding a type like this makes it easier to change the implementation without breaking the code using it.

## Anti-pattern

```elm
module Lib

exposing (Config)

type alias Config = { size: Int, style: Style }
```

This packages exposes `Config` transparently. Any changes we want to make will require changes in the application using this. If we remove or change a type in `Config` we will have to publish a major version of this package.

## Pattern

```elm
module Lib

exposing (Config, newConfig, withSize)

type Config = Config { size: Int, style: Style }

newConfig : Config
newConfig =
	Config { size: 1, style : Big }

withSize : Int -> Config -> Config
```

This package allows an application to create a `Config` and updated it. But if we decide to change how we store the `Config` we can do so without any breaking changes for the application using this.
