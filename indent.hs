indentHs :: Int -> Int
indentHs x = 
    let y = x + 1
        z = y * 2
    in z

main :: IO ()
main = print (indentHs 2)