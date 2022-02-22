
module Main where

import Data.Foldable
import Data.Letter
import Data.List.Lazy as List
import Data.Map as Map
import Data.Maybe
import Data.Trie as Trie
import Data.Tuple
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (throwException, error)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Prelude
import Purdle.Types
import Purdle.UI as UI
import Web.DOM.ParentNode as DOM

main :: Effect Unit
main = HA.runHalogenAff do
  _         <- HA.awaitBody
  container <- HA.selectElement (DOM.QuerySelector "#ui")
  case container of
    Nothing   -> liftEffect $ throwException (error "#ui not found")
    Just cont -> runUI (UI.mainComponent initialDict) unit cont

initialDict :: Dictionary
initialDict = Trie.fromMap $ Map.fromFoldable $ map reshape $
    [ [H,E,L,L,O]
    , [H,E,L,P,S]
    ]
  where
    reshape wd = Tuple (List.fromFoldable wd) (foldMap show wd)
