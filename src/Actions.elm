module Actions (..) where

import Players.Actions
import Perks.Actions
import PerksPlayers.Actions
import Perks.List
import Models exposing (PlayerPerkToggle)
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | PlayersAction Players.Actions.Action
  | PerksAction Perks.Actions.Action
  | PerksPlayersAction PerksPlayers.Actions.Action
  | PerksListAction Perks.List.Action
  | TogglePlayerPerk PlayerPerkToggle
  | ShowError String
