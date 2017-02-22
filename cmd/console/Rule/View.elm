module Rule.View exposing (viewRuleItem, viewRuleTable)

import Html exposing (Html, a, h2, section, span, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, title)
import Html.Events exposing (onClick)

import Rule.Model exposing (Rule)


viewRuleItem : msg -> Rule -> Html msg
viewRuleItem msg rule =
    let
        activated =
            if rule.active then
                span [ class "nc-icon-glyph ui-1_check-circle-07" ] []
            else
                span [ class "nc-icon-glyph ui-1_circle-remove" ] []

        ecosystem =
            case rule.ecosystem of
                1 ->
                    span [ class "nc-icon-outline design-2_apple", title "iOS" ] []
                _ ->
                    span [ class "nc-icon-outline ui-2_alert", title "unknown" ] []

        entity =
            case rule.entity of
                0 ->
                    span [ class "nc-icon-outline arrows-2_conversion", title "Connection" ] []
                1 ->
                    span [ class "nc-icon-outline ui-1_bell-53", title "event" ] []
                2 ->
                    span [ class "nc-icon-outline ui-1_database", title "Object" ] []
                3 ->
                    span [ class "nc-icon-outline ui-2_like", title "Reaction" ] []
                _ ->
                    span [ class "nc-icon-outline ui-2_alert", title "Unknown" ] []

    in
        tr [ onClick msg ]
            [ td [ class "icon" ] [ activated ]
            , td [ class "icon" ] [ ecosystem ]
            , td [ class "icon" ] [ entity ]
            , td [ class "icon" ] [ text (toString (List.length rule.recipients)) ]
            , td [] [ text rule.name ]
            ]

viewRuleTable : (Rule -> Html msg) -> List Rule -> Html msg
viewRuleTable item rules =
    let
        list =
            List.sortBy .entity rules
    in
        table []
            [ thead []
                [ tr []
                    [ th [ class "icon" ] [ text "active" ]
                    , th [ class "icon" ] [ text "ecosystem" ]
                    , th [ class "icon" ] [ text "entity" ]
                    , th [ class "icon" ] [ text "recipients" ]
                    , th [] [ text "name" ]
                    ]
                ]
            , tbody [] (List.map item list)
            ]
