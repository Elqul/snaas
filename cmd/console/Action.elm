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
    | FetchRule (WebData Rule)
    | FetchRules (WebData (List Rule))
    | LocationChange Location
    | Navigate Route
    | NewApp (WebData App)
    | RuleDeleteAsk String
    | RuleDeleteConfirm String
    | RuleDelete (WebData Bool)
    | Tick Time
