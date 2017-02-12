module Players.Messages exposing (..)

import Http exposing (Error)
import Players.Models exposing (Player, PlayerId)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
      | ShowPlayers
      | ShowPlayer PlayerId
      | ChangeLevel PlayerId Int
      | DeletePlayer Player
      | OnDelete (Result Http.Error PlayerId)
      | OnSave (Result Http.Error Player)
      | OnCreate (Result Http.Error Player)
      | ChangeName PlayerId String
      | GeneratePlayer
      | PlayerIdGenerated PlayerId
