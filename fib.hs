import Debug.Trace (trace)
--zipwith combines two lists element-wise, applies function to each pair
--fib is an infinite list of Fibo Numbera
fib :: [Int]
fib = 0 : 1 : zipWith (+) fib (tail fib)

--"\a b" is lambda function takes two arg, output a string
-- lambda function is an anonymous function
-- unlines takes a list of string, and seperates each element by new line
-- putStrLn print the string directly without the quotes
main :: IO ()
main = do
    let first8 = take 8 fib
        fibeq = zipWith (\a b -> show a ++ " + " ++ show b) first8 (tail first8)
    print fibeq
    putStrLn $ unlines fibeq
    print first8 