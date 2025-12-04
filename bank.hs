import System.IO (hFlush, stdout)


data Customer = Customer
    { customerName :: String
    , customerEmail :: String
    } deriving (Show, Eq)

-- Account now contains a Customer and a balance
--account needs ID, balance, customer and account type
data Account = CheckingAccount { accountCustomer :: Customer, accountBalance :: Double }
    | SavingsAccount  { accountCustomer :: Customer, accountBalance :: Double, interestRate :: Double }
    deriving (Show, Eq)

-- Recursive menu function
menu :: IO ()
menu = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    putStrLn "1. Account Balance"
    putStrLn "2. Add Numbers"
    putStrLn "3. Withdraw Funds"
    putStrLn "4. Quit"
    putStr "Enter your choice: "
    hFlush stdout

    choice <- getLine
    case choice of
        "1" -> do
            putStrLn "Account Balance Is...."
            menu  -- recursively call menu again
        "2" -> do
            putStr "Enter first number: "
            hFlush stdout
            a <- readLn
            putStr "Enter second number: "
            hFlush stdout
            b <- readLn
            putStrLn $ "Sum is: " ++ show (a + b)
            menu  -- loop back
        "3" -> do
            putStr "Enter first number: "
            hFlush stdout
            a <- readLn
            putStr "Enter second number: "
            hFlush stdout
            b <- readLn
            putStrLn $ "Sum is: " ++ show (a + b)
            menu  -- loop back
        "4" -> putStrLn "Goodbye!"  -- stop recursion
        _   -> do
            putStrLn "Invalid choice, try again."
            menu  -- loop back on invalid input

-- Main function
main :: IO ()
main = menu