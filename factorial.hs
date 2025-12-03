factorial :: Int -> Int
factorial 0 = 1
factorial n 
    | n < 0 = error "The factorial of a negative number is undefined"
    | otherwise = n * factorial (n-1)

main :: IO ()
main = do
    print (factorial 5)