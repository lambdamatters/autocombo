module Autocombo.Core where

import Autocombo.Types
import qualified Data.Map.Strict as M (Map, fromList, lookup)
import Data.Maybe

applicableCombos :: ComboCatalog -> ProductMap -> Basket  -> [Combo]
applicableCombos cat ps b = filter (f (magicNumber ps b)) cat
  where 
    f denominator combo = denominator `mod` (comboNumber combo) == 0

strategy :: [Combo] -> [Combo]
strategy = id

bestCombos :: ProductMap -> ComboCatalog -> [ItemAndQuantity] -> [Combo]
bestCombos pmap cat b = strategy (applicableCombos cat pmap b)

magicNumber :: ProductMap -> Basket -> Integer
magicNumber pmap b = foldr (*) 1 factors
  where 
    ids = fmap fst b
    qts = fmap (toInteger . snd) b
    primes = catMaybes $ fmap ((flip M.lookup) pmap) ids
    factors =  zipWith (*) primes qts


