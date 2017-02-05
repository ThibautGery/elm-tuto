module Players.Update exposing (..)
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save, delete)
import Players.Messages exposing (Msg(..))
import Navigation

update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
      OnFetchAll (Ok newPlayers) ->
          ( newPlayers, Cmd.none )

      OnFetchAll (Err error) ->
          ( players, Cmd.none )

      ShowPlayers ->
          ( players, Navigation.newUrl "#players" )

      ShowPlayer id ->
          ( players, Navigation.newUrl ("#players/" ++ id) )

      ChangeLevel id howMuch ->
          ( players, changeLevelCommands id howMuch players |> Cmd.batch )

      ChangeName playerId playerName ->
          ( players, changeNameCommands playerId playerName players |> Cmd.batch )

      OnSave (Ok updatedPlayer) ->
          ( updatePlayer updatedPlayer players, Cmd.none )

      OnSave (Err error) ->
          ( players, Cmd.none )

      DeletePlayer player ->
          ( players, delete player )

      OnDelete (Ok playerId) ->
          ( deletePlayer playerId players, Cmd.none )

      OnDelete (Err error) ->
          ( players, Cmd.none )


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players


changeNameCommands : PlayerId -> String -> List Player -> List (Cmd Msg)
changeNameCommands playerId newName players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | name = newName }
            else
                Cmd.none
    in
        List.map cmdForPlayer players


updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players


deletePlayer : PlayerId -> List Player -> List Player
deletePlayer playerId players =
        List.filter (\player -> player.id /= playerId ) players
