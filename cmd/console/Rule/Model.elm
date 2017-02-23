module Rule.Model exposing (Rule, decode, decodeList, targetString)

import Dict exposing (Dict)
import Json.Decode as Decode


-- MODEL


type alias Recipient =
    { query : List Query
    , targets : List Target
    , templates : Dict String String
    , urn : String
    }


type alias Rule =
    { active : Bool
    , deleted : Bool
    , ecosystem : Int
    , entity : Int
    , id : String
    , name : String
    , recipients : List Recipient
    }

type Target
    = Commenters | PostOwner | Unknown

type alias Query =
    ( String, String )


matchTarget : Query -> Target
matchTarget query =
    case query of
        ( "objectOwner", """{ "object_ids": [ {{.Parent.ID}} ], "owned": true, "types": [ "tg_comment" ]}""" ) ->
            Commenters

        ( "parentOwner", "" ) ->
            PostOwner

        ( _, _ ) ->
            Unknown

targetString : Target -> String
targetString target =
    case target of
        Commenters ->
            "Commenters"

        PostOwner ->
            "PostOwner"

        Unknown ->
            "Unknown"



-- DECODERS


decode : Decode.Decoder Rule
decode =
    Decode.map7 Rule
        (Decode.field "active" Decode.bool)
        (Decode.field "deleted" Decode.bool)
        (Decode.field "ecosystem" Decode.int)
        (Decode.field "entity" Decode.int)
        (Decode.field "id" Decode.string)
        (Decode.field "name" Decode.string)
        (Decode.field "recipients" (Decode.list decodeRecipient))


decodeList : Decode.Decoder (List Rule)
decodeList =
    Decode.field "rules" (Decode.list decode)


decodeRecipient : Decode.Decoder Recipient
decodeRecipient =
    Decode.map4 Recipient
        (Decode.field "query" (Decode.keyValuePairs Decode.string))
        (Decode.andThen decodeRecipientTarget (Decode.field "query" (Decode.keyValuePairs Decode.string)))
        (Decode.field "templates" (Decode.dict Decode.string))
        (Decode.field "urn" Decode.string)

decodeRecipientTarget : List (String, String) -> Decode.Decoder (List Target)
decodeRecipientTarget queries =
   Decode.succeed (List.map matchTarget queries)
