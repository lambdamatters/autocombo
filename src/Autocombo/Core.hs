module Autocombo.Core where

import Autocombo.Types

applicableCombos :: [ComboCatalog] -> [ItemAndQuantity] -> [Combo]
applicableCombos cs is = undefined

strategy :: [Combo] -> [Combo]
strategy cs = undefined

bestCombos :: [ComboCatalog] -> [ItemAndQuantity] -> [Combo]
bestCombos cs is = strategy (applicableCombos cs is)
