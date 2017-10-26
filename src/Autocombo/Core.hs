module Autocombo.Core where

import Autocombo.Types
import qualified Data.Map.Strict as M (Map, fromList, lookup)
import Data.Maybe

applicableCombos :: ComboCatalog -> [ItemAndQuantity] -> [Combo]
applicableCombos cat is = filter (f (magicNumber is)) cat
  where 
    f denominator combo = denominator `mod` (comboNumber combo) == 0

strategy :: [Combo] -> [Combo]
strategy = id

bestCombos :: ComboCatalog -> [ItemAndQuantity] -> [Combo]
bestCombos cs is = strategy (applicableCombos cs is)

magicNumber :: [ItemAndQuantity] -> Integer
magicNumber is = foldr (*) 1 factors
  where 
    ids = fmap itemId is
    qts = fmap (toInteger . itemQuantity) is
    primes = catMaybes $ fmap ((flip M.lookup) itemPrimeMap) ids
    factors =  zipWith (*) primes qts

itemPrimeMap :: M.Map String Integer
itemPrimeMap = M.fromList itemList

itemList :: [(String, Integer)]
itemList = [ ("1", 2)
           , ("2", 3)
           , ("3", 5)
           , ("4", 7)
           , ("5", 11)
           , ("6", 13)
          ]

comboCatalog :: ComboCatalog
comboCatalog = [ Combo [unit3, unit5]  ( FreeItem "1" ) 15
               , Combo [unit3, unit6]  ( FreeItem "2" ) 18
               , Combo [unit3, unit5, unit6]  ( FreeItem "2" ) 90
               , Combo [unit3, unit13] ( FreeItem "3" ) 39
               ]

unit3  = ComboUnit (ItemAndQuantity "2" 1) 3
unit6  = ComboUnit (ItemAndQuantity "2" 2) 6
unit5  = ComboUnit (ItemAndQuantity "3" 1) 5
unit22 = ComboUnit (ItemAndQuantity "5" 2) 22
unit13 = ComboUnit (ItemAndQuantity "6" 1) 13

-- units   3, 6 and 5
basket1 = [ ItemAndQuantity "2" 1
          , ItemAndQuantity "2" 2
          , ItemAndQuantity "3" 1
          ]

-- units 3 and 5
basket2 = [ ItemAndQuantity "2" 1
          , ItemAndQuantity "3" 1
          ]


findCombo = bestCombos comboCatalog  


forBasket1 = findCombo basket1  -- matches 3 combos
forBasket2 = findCombo basket2  -- matches 1 combo 

