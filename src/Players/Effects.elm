module Players.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task
import Players.Models exposing (Player)
import Players.Actions as Actions


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/players"


saveOne : Player -> Effects Actions.Action
saveOne player =
  let
    body =
      Http.string (memberEncoder player)
  in
    Http.post memberDecoder (saveOneUrl player.id) body
      |> Task.toResult
      |> Task.map Actions.SaveOneDone
      |> Effects.task


saveOneUrl : Int -> String
saveOneUrl playerId =
  "http://localhost:4000/players/" ++ (toString playerId)


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
  Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
  Decode.object3
    Player
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("level" := Decode.int)


memberEncoder : Player -> String
memberEncoder player =
  let
    list =
      [ ( "name", Encode.string player.name )
      , ( "level", Encode.int player.level )
      ]
  in
    list
      |> Encode.object
      |> Encode.encode 0
