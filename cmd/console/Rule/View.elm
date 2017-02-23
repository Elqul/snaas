module Rule.View exposing (viewRuleDescription, viewRuleItem, viewRuleTable)

import Html exposing (Html, a, div, h2, h3, section, span, strong, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, title)
import Html.Events exposing (onClick)
import Rule.Model exposing (Rule)


viewActivated : Bool -> Html msg
viewActivated active =
    if active then
        span [ class "nc-icon-glyph ui-1_check-circle-07" ] []
    else
        span [ class "nc-icon-glyph ui-1_circle-remove" ] []

viewEcosystem : Int -> Html msg
viewEcosystem ecosystem =
    case ecosystem of
        1 ->
            span [ class "nc-icon-outline design-2_apple", title "iOS" ] []

        _ ->
            span [ class "nc-icon-outline ui-2_alert", title "unknown" ] []

viewEntity : Int -> Html msg
viewEntity entity =
    case entity of
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

viewRuleDescription : Rule -> Html msg
viewRuleDescription rule =
    let
        ecosystem =
            case rule.ecosystem of
                1 ->
                    div [ class "icon", title "iOS" ]
                        [ span [ class "nc-icon-outline design-2_apple" ] []
                        , span [] [ text "iOS" ]
                        ]

                _ ->
                    div [ class "icon", title "Unknown" ]
                        [ span [ class "nc-icon-outline ui-2_alert" ] []
                        , span [] [ text "Unknown" ]
                        ]

        entity =
            case rule.entity of
                0 ->
                    div [ class "icon", title "Connections" ]
                        [ span [ class "nc-icon-outline arrows-2_conversion" ] []
                        , span [] [ text "Connections" ]
                        ]

                1 ->
                    div [ class "icon", title "Events" ]
                        [ span [ class "nc-icon-outline ui-1_bell-53" ] []
                        , span [] [ text "Events" ]
                        ]

                2 ->
                    div [ class "icon", title "Objects" ]
                        [ span [ class "nc-icon-outline ui-1_database" ] []
                        , span [] [ text "Objects" ]
                        ]

                3 ->
                    div [ class "icon", title "Reactions" ]
                        [ span [ class "nc-icon-outline ui-2_like" ] []
                        , span [] [ text "Reactions" ]
                        ]

                _ ->
                    div [ class "icon", title "Unknown" ]
                        [ span [ class "nc-icon-outline ui-2_alert" ] []
                        , span [] [ text "Unknown" ]
                        ]
    in
        h3 []
            [ span [] [ text "A rule for" ]
            , entity
            , span [] [ text "called" ]
            , strong [] [ text rule.name ]
            , span [] [ text "targeting the" ]
            , ecosystem
            , span [] [ text "platform." ]
            ]


viewRuleItem : msg -> Rule -> Html msg
viewRuleItem msg rule =
    tr [ onClick msg ]
        [ td [ class "icon" ] [ viewActivated rule.active ]
        , td [ class "icon" ] [ viewEcosystem rule.ecosystem ]
        , td [ class "icon" ] [ viewEntity rule.entity ]
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
