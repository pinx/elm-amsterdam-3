module Server exposing (..)

import Http exposing (get)
import Task exposing (perform)
import Json.Encode exposing (Value)
import Json.Decode exposing (at, decodeValue, field, list, int, string, float, null, oneOf, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded, requiredAt)
import Model exposing (..)
import Translation exposing (..)


endpoint =
    "/"


getTranslations : Language -> Cmd Msg
getTranslations language =
    let
        url =
            (endpoint ++ (toString language) ++ ".json")
    in
        Http.send SetTranslations (Http.get url languageDecoder)


decodeLanguages : Json.Encode.Value -> Result String Translation.Model
decodeLanguages raw =
    decodeValue languageDecoder raw


languageDecoder : Decoder Translation.Model
languageDecoder =
        decode Translation.Model
            |> required "welcome" string
            |> required "logout" string
