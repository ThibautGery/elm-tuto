module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update
import Routing exposing (parseLocation)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, newErrorMsg, cmd ) =
                    Players.Update.update subMsg model.players
            in
                ( { model | players = updatedPlayers, errorMsg = newErrorMsg }, Cmd.map PlayersMsg cmd )
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
