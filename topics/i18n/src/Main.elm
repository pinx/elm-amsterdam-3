module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Task exposing (..)
import Material
import Server exposing (..)
import View exposing (view)
import Model exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update msg_ model

        GetTranslations languageCode ->
            ( model, getTranslations languageCode )

        SetTranslations (Ok translations) ->
            ( { model | translations = Debug.log "translations" translations }, Cmd.none )

        SetTranslations (Err _) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


msgToCmd msg =
    Task.perform (always msg) (Task.succeed ())
