module Autocombo.Core where

import Autocombo.Types
import qualified Data.Map.Strict as M (Map, fromList, lookup)
import Data.Maybe

applicableCombos :: ComboCatalog -> [ItemAndQuantity] -> [Combo]
applicableCombos cat is = filter (f (magicNumber is)) cat
  where 
    f denominator combo = (comboNumber combo) `mod` denominator == 0

strategy :: [Combo] -> [Combo]
strategy cs = undefined

bestCombos :: ComboCatalog -> [ItemAndQuantity] -> [Combo]
bestCombos cs is = strategy (applicableCombos cs is)

magicNumber :: [ItemAndQuantity] -> Integer
magicNumber is = foldr (*) 1 factors
  where 
    factors = catMaybes (fmap ((flip M.lookup) itemPrimeMap) (fmap itemId is))

itemPrimeMap :: M.Map String Integer
itemPrimeMap = M.fromList itemList

itemList = [ ("1", 2)
           , ("2", 3)
           , ("3", 5)
           , ("4", 7)
           , ("5", 11)
           , ("6", 13)
          ]

comboList = [ Combo [unit4, unit5] FreeItem "1" 20
            , Combo [unit2, unit3] FreeItem "2" 6
            , Combo [unit2, unit6] FreeItem "3" 14
            ]

unit2 = ComboUnit (ItemAndQuantity "2" 1) 2
unit4 = ComboUnit (ItemAndQuantity "2" 2) 4
unit5 = ComboUnit (ItemAndQuantity "3" 1) 5
unit22 = ComboUnit (ItemAndQuantity "5" 2) 22
unit13 = ComboUnit (ItemAndQuantity "6" 1) 13
