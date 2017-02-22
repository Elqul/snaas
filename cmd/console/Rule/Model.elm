module Rule.Model exposing (Rule, decodeList)

import Dict exposing (Dict)
import Json.Decode as Decode


-- MODEL


type alias Recipient =
    { query : Dict String String
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
    Decode.at [ "rules" ] (Decode.list decode)


decodeRecipient : Decode.Decoder Recipient
decodeRecipient =
    Decode.map3 Recipient
        (Decode.field "query" (Decode.dict Decode.string))
        (Decode.field "templates" (Decode.dict Decode.string))
        (Decode.field "urn" Decode.string)
