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

deposit :: Double -> Account -> Account
deposit amount (CheckingAccount name balance) = CheckingAccount name (balance + amount)
deposit amount (SavingsAccount name balance rate) = SavingsAccount name (balance + amount) rate

withdraw :: Double -> Account -> Account
withdraw amount (CheckingAccount name balance) 
    | amount <= balance = CheckingAccount name (balance - amount)
    | otherwise = CheckingAccount name balance
withdraw amount (SavingsAccount name balance rate) 
    | amount <= balance = SavingsAccount name (balance - amount) rate
    | otherwise = SavingsAccount name balance rate

-- Recursive menu function
menu :: Account -> IO ()
menu account = do
    putStrLn "\n===== Main Menu ====="
    putStrLn "1. Say Hello"
    putStrLn "2. Add two numbers"
    putStrLn "3. Deposit"
    putStrLn "4. Withdraw"
    putStrLn "5. Quit"
    putStr "Enter your choice: "
    hFlush stdout

    choice <- getLine
    case choice of
        "1" -> do
            putStrLn "Hello!"
            menu account -- recursively call menu again
        "2" -> do
            putStr "Enter first number: "
            hFlush stdout
            a <- readLn
            putStr "Enter second number: "
            hFlush stdout
            b <- readLn
            putStrLn $ "Sum is: " ++ show (a + b)
            menu  account-- loop back
        "3" -> do
            putStr "Enter the amount to deposit: "
            hFlush stdout
            amount <- readLn
            let newAccount = deposit amount account
            putStrLn $ "New balance: " ++ show (accountBalance newAccount)
            menu newAccount
        "4" -> do
            putStr "Enter the amount to withdraw: "
            hFlush stdout
            amount <- readLn
            let newAccount = withdraw amount account
            putStrLn $ "New balance " ++ show (accountBalance newAccount)
            menu newAccount
        "5" -> putStrLn "Goodbye!"  -- stop recursion
        _   -> do
            putStrLn "Invalid choice, try again."
            menu  -- loop back on invalid input

-- Main function
main :: IO ()
main = menu