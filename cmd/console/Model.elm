module Model exposing (Flags, Model, init)

import Navigation
import RemoteData exposing (RemoteData(..), WebData)
import Time exposing (Time)

import Action exposing (..)
import App.Api exposing (getApp, getApps)
import App.Model exposing (App, initAppForm)
import Formo exposing (Form)
import Route exposing (Route, parse)
import Rule.Api exposing (listRules)
import Rule.Model exposing (Rule)

type alias Flags =
    { zone : String
    }

type alias Model =
    { app : WebData App
    , apps : WebData (List App)
    , appForm : Form
    , appId : String
    , focus : String
    , newApp : WebData App
    , route : Maybe Route
    , rule : WebData Rule
    , rules : WebData (List Rule)
    , startTime : Time
    , time : Time
    , zone : String
    }

init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init { zone } location =
    let
        route = parse location

        model = initModel zone route
    in
        case route of
            Just (Route.App id) ->
                ( (model Loading NotAsked id), Cmd.map FetchApp (getApp id) )

            Just (Route.Apps) ->
                ( (model NotAsked Loading ""), Cmd.map FetchApps getApps )

            Just (Route.Rules appId) ->
                let
                    cmds =
                        Cmd.batch
                            [ Cmd.map FetchApp (getApp appId)
                            , Cmd.map FetchRules (listRules appId)
                            ]
                in
                    ( (model Loading NotAsked appId), cmds )

            _ ->
                ( (model NotAsked NotAsked ""), Cmd.none)

initModel : String -> Maybe Route -> WebData App -> WebData (List App) -> String -> Model
initModel zone route app apps appId =
    Model app apps initAppForm appId "" NotAsked route NotAsked NotAsked 0 0 zone
