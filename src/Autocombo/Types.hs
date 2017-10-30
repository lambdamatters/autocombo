module Autocombo.Types where

type ItemId       = String
type ComboCatalog = [Combo]
type ItemCatalog  = [ItemId]

data ComboUnit = ComboUnit 
  { itemAndQuantity :: ItemAndQuantity
  , primeNumber :: Integer
  } deriving Show

data Offer = FreeItem ItemId | Discount Double deriving Show

data Combo = Combo 
  { comboUnits  :: [ComboUnit]
  , offer       :: Offer
  , comboNumber :: Integer
  } deriving Show

data ItemAndQuantity = ItemAndQuantity
  { itemId :: ItemId
  , itemQuantity :: Int
  } deriving Show

comboItem :: ComboUnit -> ItemId
comboItem = itemId . itemAndQuantity

comboQuantity :: ComboUnit -> Int
comboQuantity = itemQuantity . itemAndQuantity

