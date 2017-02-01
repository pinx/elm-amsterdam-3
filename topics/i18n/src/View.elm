module View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (GetTranslations English) ] [ text "English" ]
        , button [ onClick (GetTranslations Dutch) ] [ text "Dutch" ]
        , br [] []
        , text model.translations.welcome
        , br [] []
        , text model.translations.logout
        ]
