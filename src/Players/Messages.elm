module Players.Messages exposing (..)

import Http exposing (Error)
import Players.Models exposing (Player, PlayerId)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
      | ShowPlayers
      | ShowPlayer PlayerId
