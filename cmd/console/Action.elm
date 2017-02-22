module Action exposing (Msg(..))

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Time exposing (Time)
import App.Model exposing (App)
import Route exposing (Route)
import Rule.Model exposing (Rule)


type Msg
    = AppFormBlur String
    | AppFormClear
    | AppFormFocus String
    | AppFormSubmit
    | AppFormUpdate String String
    | FetchApp (WebData App)
    | FetchApps (WebData (List App))
    | FetchRules (WebData (List Rule))
    | ListApps
    | LocationChange Location
    | Navigate Route
    | NewApp (WebData App)
    | SelectApp String
    | Tick Time
