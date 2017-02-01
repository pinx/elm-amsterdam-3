module Translation exposing (..)


type alias Model =
    { welcome : WelcomeString
    , logout : String
    }


type alias WelcomeString =
    String
-- = { name : String }


defaultTranslation : Model
defaultTranslation =
    { welcome = "Welcome"
    , logout = "Logout"
    }
