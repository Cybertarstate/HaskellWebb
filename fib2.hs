-- Recursive Fibonacci function
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

newmap :: (a -> b) -> [a] -> [b]
newmap _ [] = []
newmap f (x:xs) = f x : newmap f xs

main :: IO ()
main = do
    let first8 = newmap fib [0..7]
    --newmap :: (a -> b) -> [a] -> [b]
    --[fib 0, fib 1, fib 2, fib 3, fib 4, fib 5, fib 6, fib 7]
        
    print first8