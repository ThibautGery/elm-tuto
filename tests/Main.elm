port module Main exposing (..)

import Sample.Generated
import Sample.String
import Players.UpdateTests
import Test exposing(Test, describe)
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


tests : Test
tests =
    describe "Elm test"
        [ Sample.Generated.tests
        , Sample.Generated.tests
        , Players.UpdateTests.tests
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
