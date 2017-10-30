module Autocombo.Test where 

import Data.Map.Strict as M
import Autocombo.Core
import Autocombo.Types

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

unit3  = ComboUnit "2" 1 3
unit6  = ComboUnit "2" 2 6
unit5  = ComboUnit "3" 1 5
unit22 = ComboUnit "5" 2 22
unit13 = ComboUnit "6" 1 13

-- units   3, 6 and 5
basket1 = [ ( "2", 1 )
          , ( "2", 2 )
          , ( "3", 1 )
          ]

-- units 3 and 5
basket2 = [ ( "2", 1 )
          , ( "3", 1 )
          ]

findCombo = bestCombos itemPrimeMap comboCatalog

forBasket1 = findCombo basket1  -- matches 3 combos
forBasket2 = findCombo basket2  -- matches 1 combo

