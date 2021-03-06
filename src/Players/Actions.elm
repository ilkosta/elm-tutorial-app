module Players.Actions (..) where

import Http
import Players.Models exposing (PlayerId, Player)
import Perks.Models exposing (PerkId)


type Action
  = NoOp
  | HopAction ()
  | EditPlayer PlayerId
  | ListPlayers
  | FetchAllDone (Result Http.Error (List Player))
  | TaskDone ()
  | CreatePlayer
  | CreatePlayerDone (Result Http.Error Player)
  | DeletePlayerIntent Player
  | DeletePlayer PlayerId
  | DeletePlayerDone PlayerId (Result Http.Error ())
  | ChangeLevel PlayerId Int
  | SaveDone (Result Http.Error Player)
  | TogglePlayerPerk PlayerId PerkId Bool
  | ChangeName PlayerId String
