module Rule.Api exposing (deleteRule, getRule, listRules)

import Http
import RemoteData exposing (WebData, sendRequest)
import Rule.Model exposing (Rule, decode, decodeList)


deleteRule : String -> String -> Cmd (WebData Bool)
deleteRule appId ruleId =
    Http.request
        { body = Http.emptyBody
        , expect = Http.expectStringResponse readDelete
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = ruleUrl appId ruleId
        , withCredentials = False
        }
        |> sendRequest

getRule : String -> String -> Cmd (WebData Rule)
getRule appId ruleId =
    Http.get (ruleUrl appId ruleId) decode
        |> sendRequest


listRules : String -> Cmd (WebData (List Rule))
listRules appId =
    Http.get ("/api/apps/" ++ appId ++ "/rules") decodeList
        |> sendRequest

readDelete : Http.Response String -> Result String Bool
readDelete response =
     if response.status.code == 204 then
        Ok True
    else
        Err response.status.message

ruleUrl : String -> String -> String
ruleUrl appId ruleId =
    "/api/apps/" ++ appId ++ "/rules/" ++ ruleId
