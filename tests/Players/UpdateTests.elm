module Players.UpdateTests exposing(..)

import Test exposing(..)
import Expect
import Fuzz exposing(string)
import Players.Update exposing(deletePlayer, updatePlayer)
import Players.Models exposing(Player)

players: List Player
players = [
    { id="1"
    , name= "toto"
    , level = 1
    }
  , { id="2"
    , name= "tutu"
    , level = 2
    }]

tests : Test
tests =
    describe "The Player module"
        [ describe "deletePlayer" -- Nest as many descriptions as you like.
            [ test "should remove no player if not in list" <|
                \() ->
                    let
                        actual = deletePlayer "3" players
                    in
                        Expect.equalLists actual players

            -- Expect.equal is designed to be used in pipeline style, like this.
            , test "keep the other players" <|
                \() ->
                    let
                        actual = deletePlayer "1" players
                    in
                        Expect.equal (Just actual) (List.tail players)
            , test "remove the player if present" <|
                \() ->
                    let
                        actual = deletePlayer "1" players
                    in
                        Expect.equal (List.length actual) 1

            ]
        ]
