--this is a comment
--below, result of sorting empty list, is an empty list
quicksort :: Ord a => [a] -> [a]
quicksort []     = []
--result of sorting non empty list, whose first element p, and the rest is xs, is a result of 3 concatenated sublists,
--first result sorting elements of xs less than p
--then p itself, then result of elements of xs greater than p

quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
        lesser  = filter (< p) xs
        greater = filter (>= p) xs