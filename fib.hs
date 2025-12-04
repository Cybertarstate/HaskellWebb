import Debug.Trace (trace)
--zipwith combines two lists element-wise, applies function to each pair
--fib is an infinite list of Fibo Numbers


--helper function that works like zipWith
zipper :: (a -> b -> c) -> [a] -> [b] -> [c]
zipper _ [] _ = []
zipper _ _ [] = []
zipper f (x:xs) (y:ys) = f x y : zipper f xs ys

fib :: [Int]
fib = 0 : 1 : zipper (+) fib (tail fib)

newtake :: Int -> [a] -> [a]
newtake 0 _ = []
newtake _ [] = []
newtake n (x:xs) = x : newtake (n-1) xs

main :: IO ()
main = do
    let first8 = newtake 8 fib
        fibeq = zipper (\a b -> show a ++ " + " ++ show b) first8 (tail first8)
    print fibeq
    putStrLn $ unlines fibeq
    print first8