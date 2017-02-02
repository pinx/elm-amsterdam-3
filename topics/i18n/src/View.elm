module View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import String.Interpolate exposing (interpolate)


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (GetTranslations English) ] [ text "English" ]
        , button [ onClick (GetTranslations Dutch) ] [ text "Dutch" ]
        , br [] []
        , text (interpolate model.translations.welcome ["Joe"])
        , br [] []
        , text model.translations.logout
        ]
