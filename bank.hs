import System.IO (hFlush, stdout)


newtype Customer = Customer
    { customerName :: String
    } deriving (Show, Eq)

-- Account now contains a Customer and a balance
--account needs ID, balance, customer and account type
data Account = CheckingAccount { accountID :: Int, accountCustomer :: Customer, accountBalance :: Double }
    | SavingsAccount  { accountCustomer :: Customer, accountBalance :: Double, interestRate :: Double }
    deriving (Show, Eq)

defaultCustomer :: Customer
defaultCustomer = Customer
    { customerName = ""
    }
defaultChecking :: Account
defaultChecking = CheckingAccount
    { accountID = 123,
      accountCustomer = defaultCustomer
    , accountBalance = 0.0
    }
defaultSavings :: Account
defaultSavings = SavingsAccount
    { accountCustomer = defaultCustomer
    , accountBalance = 0.0
    , interestRate = 0.00
    }

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
main = do
    let customer1 = defaultCustomer { customerName = "Jimmy Buffet" }
        checking1 = defaultChecking { accountID = 001, accountCustomer = customer1, accountBalance = 1500.0 }
        savings1 = defaultSavings { accountCustomer = customer1, accountBalance = 2000.0, interestRate = 0.05 }
    menu