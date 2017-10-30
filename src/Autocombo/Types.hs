module Autocombo.Types where

import Data.Map.Strict as M

type ItemId          = String
type ComboCatalog    = [Combo]
type ItemCatalog     = [ItemId]
type ItemAndQuantity = (ItemId, Int)
type Basket          = [ItemAndQuantity]

type ProductMap = M.Map ItemId Integer

data Combo = Combo 
  { comboUnits  :: [ComboUnit]
  , offer       :: Offer
  , comboNumber :: Integer
  } deriving Show

data ComboUnit = ComboUnit 
  { itemId        :: ItemId
  , itemQuantity  :: Int
  , productNumber :: Integer
  } deriving Show

data Offer = FreeItem ItemId | Discount Double deriving Show

