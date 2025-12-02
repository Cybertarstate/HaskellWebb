-- Takes a list of prices (Floats) and returns new prices
addTax :: [Float] -> [Float]
addTax prices = map (* 1.1) prices

main :: IO ()
main = do
    let basePrices = [10.0, 20.0, 100.0]
    let taxedPrices = addTax basePrices
    
    putStrLn "Prices with Tax:"
    print taxedPrices