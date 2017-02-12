module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Players.Messages exposing (..)
import Players.Models exposing (Player)
import Html.Events exposing (onClick)
import Players.Error as Error


view : List Player -> Maybe String -> Html Msg
view players errorMsg =
    div []
        [ nav
        , Error.view errorMsg
        , list players
        ]


nav : Html Msg
nav =
    div [ class "clearfix white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
          ,div [] [
            createBtn
          ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [editBtn player]
        , td []
            [deleteBtn player]
        ]

editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]


deleteBtn : Player -> Html Msg
deleteBtn player =
    button
        [ class "btn regular"
        , onClick (DeletePlayer player)
        ]
        [ i [ class "fa fa-trash mr1" ] [], text "Delete" ]

createBtn : Html Msg
createBtn =
    button
        [ class "btn regular"
        , onClick GeneratePlayer
        ]
        [ i [ class "fa fa-plus-square-o mr1" ] [], text "Create" ]
