module Rule.Api exposing (listRules)

import Http
import RemoteData exposing (WebData, sendRequest)

import Rule.Model exposing (Rule, decodeList)

listRules : String -> Cmd (WebData (List Rule))
listRules appId =
    Http.get ("/api/apps/" ++ appId ++ "/rules") decodeList
        |> sendRequest