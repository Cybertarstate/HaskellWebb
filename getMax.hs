getMax :: Ord a => [a] -> a
getMax [] = error "Can't get a max out of an empty list"
getMax [x] = x
getMax (x:xs) = max x (getMax xs) 

main :: IO ()
main = do
    let nums = [2, 9, 10, 12, 1]
    let higher = getMax nums
    print higher