module Route exposing (..)

import Navigation exposing (Location, newUrl)
import UrlParser exposing (Parser, (</>), map, oneOf, parsePath, top, s, string)


-- MODEL


type Route
    = App String
    | Apps
    | Dashboard
    | Members
    | Rule String String
    | Rules String
    | Users String



-- HELPER


construct : Route -> String
construct route =
    case route of
        App id ->
            "/apps/" ++ id

        Apps ->
            "/apps"

        Dashboard ->
            "/"

        Members ->
            "/members"

        Rule appId ruleId ->
            "/apps/" ++ appId ++ "/rules/" ++ ruleId

        Rules appId ->
            "/apps/" ++ appId ++ "/rules"

        Users appId ->
            "/apps/" ++ appId ++ "/users"


navigate : Route -> Cmd msg
navigate route =
    newUrl (construct route)


parse : Location -> Maybe Route
parse location =
    parsePath routes location


routes : Parser (Route -> a) a
routes =
    oneOf
        [ map Dashboard top
        , map App (s "apps" </> string)
        , map Apps (s "apps")
        , map Members (s "members")
        , map Rule (s "apps" </> string </> s "rules" </> string)
        , map Rules (s "apps" </> string </> s "rules")
        , map Users (s "apps" </> string </> s "users")
        ]
