module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"


add : Int -> Int -> Int
add x y =
  x + y


switch : ( qqq, ccc ) -> ( ccc, qqq )
switch ( x, y ) =
  ( y, x )


type alias Player =
    { id : Int
    , name : String
    }


