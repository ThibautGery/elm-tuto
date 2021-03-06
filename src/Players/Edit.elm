module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, type_ )
import Players.Messages exposing (..)
import Players.Models exposing (..)
import Html.Events exposing (onClick, onInput)
import Players.Error as Error



view : Player -> Maybe String -> Html Msg
view players errorMsg =
    div []
        [ nav
        , Error.view errorMsg
        , form players
        ]


nav : Html Msg
nav =
    div [ class "clearfix white bg-black p1" ]
        [ listBtn ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        , div [ class "col col-5" ] [ text "Name" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ]
            [
              input [ type_ "text", value player.name, onInput (ChangeName player.id)  ] []  ]
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
