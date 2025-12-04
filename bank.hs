import System.IO (hFlush, stdout)


newtype Customer = Customer
    { customerName :: String
    } deriving (Show, Eq)

-- Account now contains a Customer and a balance
--account needs ID, balance, customer and account type
data Account = CheckingAccount { accountID :: Int, accountCustomer :: Customer, accountBalance :: Double }
    | SavingsAccount  { accountCustomer :: Customer, accountBalance :: Double, interestRate :: Double }
    deriving (Show, Eq)

bank :: [Account]
bank = []

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

deposit :: Double -> Account -> Account
deposit amount (CheckingAccount id name balance) = CheckingAccount id name (balance + amount)
deposit amount (SavingsAccount name balance rate) = SavingsAccount name (balance + amount) rate

withdraw :: Double -> Account -> Account
withdraw amount (CheckingAccount id name balance) 
    | amount <= balance = CheckingAccount id name (balance - amount)
    | otherwise = CheckingAccount id name balance
withdraw amount (SavingsAccount name balance rate) 
    | amount <= balance = SavingsAccount name (balance - amount) rate
    | otherwise = SavingsAccount name balance rate


calcInterest :: Account -> Int -> Double
calcInterest a 0 = accountBalance a
calcInterest a n = (calcInterest a (n-1)) * (1.0 + (interest a))

interest :: Account -> Double
interest acc = case acc of
    CheckingAccount{} -> 0.0
    SavingsAccount{} -> interestRate acc

-- Recursive menu function
menu :: Account -> IO ()
menu account = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    putStrLn "1. Account Balance"
    putStrLn "2. Calculate Interest"
    putStrLn "3. Deposit"
    putStrLn "4. Withdraw"
    putStrLn "5. Quit"
    putStr "Enter your choice: "
    hFlush stdout

    choice <- getLine
    case choice of
        "1" -> do
            putStrLn $ "Account Balance Is " ++ show (accountBalance account)
            putStrLn $ "Account interest rate is " ++ show (interest account)
            menu account-- recursively call menu again
        "2" -> do
            putStr "Enter number of years for interest: "
            hFlush stdout
            y <- readLn
            putStrLn $ "Account interest rate is " ++ show (interest account)
            putStrLn $ "Total is: " ++ show (calcInterest account y)
            menu account
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
            menu account -- loop back on invalid input


accountSelect :: [Account] -> IO()
accountSelect a = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    let numbered = zip [0..] [accountBalance e | e <- a]
    let names = [ "Account " ++ show n ++ ": " ++ show (a) ++ "\n" | (n, a) <- numbered]
    putStrLn (concat names)
    putStr "Pick account number to view: "
    hFlush stdout
    acct <- readLn
    menu (a !! acct)

-- Main function
main :: IO ()
main = do
    let customer1 = defaultCustomer { customerName = "Jimmy Buffet" }
        checking1 = defaultChecking { accountID = 001, accountCustomer = customer1, accountBalance = 1500.0 }
        savings1 = defaultSavings { accountCustomer = customer1, accountBalance = 2000.0, interestRate = 0.05 }
        
    let bank = [savings1 , checking1]
    accountSelect bank

