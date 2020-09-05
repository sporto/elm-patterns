module Main exposing (main)

import Html exposing (Html, div, text)


type alias User =
    { name : String
    , age : Int
    }


validateUser : User -> Result String User
validateUser user =
    Ok User
        |> validateName user.name
        |> validateAge user.age


validateName : String -> Result String (String -> a) -> Result String a
validateName name =
    Result.andThen
        (\constructor ->
            if String.isEmpty name then
                Err "Invalid name"

            else
                Ok (constructor name)
        )


validateAge : Int -> Result String (Int -> a) -> Result String a
validateAge age =
    Result.andThen
        (\fn ->
            if age < 13 then
                Err "Invalid age"

            else
                Ok (fn age)
        )


invalidUser =
    { name = ""
    , age = 0
    }


main =
    div []
        [ text (Debug.toString (validateUser invalidUser))
        ]
