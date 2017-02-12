module Players.Update exposing (..)
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save, delete)
import Players.Messages exposing (Msg(..))
import Navigation
import Random

update : Msg -> List Player -> ( List Player, Maybe String, Cmd Msg )
update message players =
    case message of
      OnFetchAll (Ok newPlayers) ->
          ( newPlayers, Nothing, Cmd.none )

      OnFetchAll (Err error) ->
          ( players, Just "Impossible to retreive all the players",Cmd.none )

      ShowPlayers ->
          ( players, Nothing, Navigation.newUrl "#players" )

      GeneratePlayer ->
          ( players, Nothing, Random.generate PlayerGenerated (Random.map (\b -> toString b)(Random.int 0 Random.maxInt)))

      PlayerGenerated id ->
          ( createPlayer players id, Nothing,Navigation.newUrl ("#players/" ++ id))

      ShowPlayer id ->
          ( players, Nothing, Navigation.newUrl ("#players/" ++ id) )

      ChangeLevel id howMuch ->
          ( players, Nothing, changeLevelCommands id howMuch players |> Cmd.batch )

      ChangeName playerId playerName ->
          ( players, Nothing, changeNameCommands playerId playerName players |> Cmd.batch )

      OnSave (Ok updatedPlayer) ->
          ( updatePlayer updatedPlayer players, Nothing, Cmd.none )

      OnSave (Err error) ->
          ( players, Just "Impossible to save Player", Cmd.none )

      DeletePlayer player ->
          ( players, Nothing, delete player )

      OnDelete (Ok playerId) ->
          ( deletePlayer playerId players, Nothing, Cmd.none )

      OnDelete (Err error) ->
          ( players, Just "Impossible to delete Player", Cmd.none )

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


createPlayer: List Player -> PlayerId -> List Player
createPlayer players id =
  let
    newPlayer =
      { id = id
      , level = 1
      , name = ""
      }
  in newPlayer :: players
