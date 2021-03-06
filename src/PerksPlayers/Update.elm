module PerksPlayers.Update (..) where

import Effects exposing (Effects)
import PerksPlayers.Actions exposing (..)
import PerksPlayers.Models exposing (PerkPlayerId, PerkPlayer)
import PerksPlayers.Effects exposing (..)


type alias UpdateModel =
  { perksPlayers : List PerkPlayer
  , showErrorAddress : Signal.Address String
  }


update : Action -> UpdateModel -> ( List PerkPlayer, Effects Action )
update action model =
  case action of
    FetchAllDone result ->
      case result of
        Ok perksPlayers ->
          ( perksPlayers, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.perksPlayers, fx )

    TogglePlayerPerk toggle ->
      let
        fx =
          if toggle.value then
            addPerkPlayerFx toggle.playerId toggle.perkId
          else
            removePerkPlayerFx toggle.playerId toggle.perkId model.perksPlayers
      in
        ( model.perksPlayers, fx )

    CreatePerkPlayerDone result ->
      case result of
        Ok perkPlayer ->
          let
            updatedCollection =
              perkPlayer :: model.perksPlayers
          in
            ( updatedCollection, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.perksPlayers, fx )

    DeletePerkPlayerDone perkPlayerId result ->
      case result of
        Ok _ ->
          let
            updatedCollection =
              List.filter (\item -> item.id /= perkPlayerId) model.perksPlayers
          in
            ( updatedCollection, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.perksPlayers, fx )

    _ ->
      ( model.perksPlayers, Effects.none )
