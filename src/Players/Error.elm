module Players.Error exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)
import Players.Messages exposing(Msg)

view: Maybe String -> Html Msg
view errorMsg =
  case errorMsg of
    Just msg ->
      div [ class "clearfix mb2 white bg-red p1" ]
          [ text  msg ]
    Nothing ->
      div [] []
