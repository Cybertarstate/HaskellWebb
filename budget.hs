-- Function: Takes a list of Ints, returns a list of Ints
auditExpenses :: [Int] -> [Int]
auditExpenses [] = []
auditExpenses (x:xs)
    | x > 100   = x : auditExpenses xs  -- Keep 'x' if it's over 100
    | otherwise = auditExpenses xs      -- Otherwise, skip it

main :: IO ()
main = do
    let expenses = [12, 5, 200, 45, 150, 8, 999]
    putStrLn "Flagged Expenses (> $100):"
    print (auditExpenses expenses)