module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)
import Json.Encode as Encode


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PUT"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object


deleteUrl : PlayerId -> String
deleteUrl playerId =
    "http://localhost:4000/players/" ++ playerId


deleteRequest : Player -> Http.Request PlayerId
deleteRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectStringResponse (\_ -> Ok player.id)
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = deleteUrl player.id
        , withCredentials = False
        }


delete : Player -> Cmd Msg
delete player =
    deleteRequest player
        |> Http.send OnDelete


createUrl : PlayerId -> String
createUrl playerId =
    "http://localhost:4000/players"


createRequest : Player -> Http.Request Player
createRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = createUrl player.id
        , withCredentials = False
        }


create : Player -> Cmd Msg
create player =
    createRequest player
        |> Http.send OnCreate
