module Model exposing (..)

import Material
import Material.Snackbar as Snackbar
import Http exposing (Error)
import Json.Encode as JE
import Translation exposing (..)


type alias Model =
    { mdl : Material.Model
    , language : Language
    , translations : Translation.Model
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , language = English
    , translations = defaultTranslation
    }


type Language
    = English
    | Dutch


type Msg
    = Mdl (Material.Msg Msg)
    | GetTranslations Language
    | SetTranslations (Result Http.Error Translation.Model)
