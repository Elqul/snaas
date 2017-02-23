module Rule.Api exposing (getRule, listRules)

import Http
import RemoteData exposing (WebData, sendRequest)
import Rule.Model exposing (Rule, decode, decodeList)


getRule : String -> String -> Cmd (WebData Rule)
getRule appId ruleId =
    Http.get ("/api/apps/" ++ appId ++ "/rules/" ++ ruleId) decode
        |> sendRequest


listRules : String -> Cmd (WebData (List Rule))
listRules appId =
    Http.get ("/api/apps/" ++ appId ++ "/rules") decodeList
        |> sendRequest
