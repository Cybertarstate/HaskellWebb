--type declaration takes takes and returns
mymult :: Int -> Int -> Int
mymult x y = x * y

main :: IO ()
main = print (mymult 3 4)