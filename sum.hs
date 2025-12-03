-- Haskell sum program
{-inked lists, not random-access arrays
  immutable
  homogeneous (all elements must be same type)
-}
--hindley miller type inference system
import Prelude hiding (sum)

sum :: [Int] -> Int
sum [] = 0
sum (h:t) = h + sum t

main = print (sum [5,6,1,8,3,7])
