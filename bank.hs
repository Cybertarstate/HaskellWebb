import System.IO (hFlush, stdout)

newtype Customer = Customer
    { customerName :: String
    } deriving (Show, Eq)

-- Modified Account to include a log for history
-- We need to store the history inside the object since we can't use a global variable
data Account = CheckingAccount 
    { accountID :: Int
    , accountCustomer :: Customer
    , accountBalance :: Double
    , accountLog :: [String] 
    }
    | SavingsAccount  
    { accountCustomer :: Customer
    , accountBalance :: Double
    , interestRate :: Double
    , accountLog :: [String] 
    }
    deriving (Show, Eq)

bank :: [Account]
bank = []

defaultCustomer :: Customer
defaultCustomer = Customer
    { customerName = ""
    }

-- Initialize new accounts with a starting log entry
defaultChecking :: Account
defaultChecking = CheckingAccount
    { accountID = 123
    , accountCustomer = defaultCustomer
    , accountBalance = 0.0
    , accountLog = ["Account Opened"]
    }

defaultSavings :: Account
defaultSavings = SavingsAccount
    { accountCustomer = defaultCustomer
    , accountBalance = 0.0
    , interestRate = 0.00
    , accountLog = ["Account Opened"]
    }

-- Update balance and add the transaction message to the front of the log list
deposit :: Double -> Account -> Account
deposit amount (CheckingAccount id name balance log) = 
    CheckingAccount id name (balance + amount) (("Deposited " ++ show amount) : log)
deposit amount (SavingsAccount name balance rate log) = 
    SavingsAccount name (balance + amount) rate (("Deposited " ++ show amount) : log)

withdraw :: Double -> Account -> Account
withdraw amount (CheckingAccount id name balance log) 
    | amount <= balance = CheckingAccount id name (balance - amount) (("Withdrew " ++ show amount) : log)
    | otherwise         = CheckingAccount id name balance (("Failed Withdrawal of " ++ show amount) : log)
withdraw amount (SavingsAccount name balance rate log) 
    | amount <= balance = SavingsAccount name (balance - amount) rate (("Withdrew " ++ show amount) : log)
    | otherwise         = SavingsAccount name balance rate (("Failed Withdrawal of " ++ show amount) : log)

-- Helper to get interest rate safely
interest :: Account -> Double
interest acc = case acc of
    CheckingAccount{} -> 0.0
    SavingsAccount{} -> interestRate acc

calcInterest :: Account -> Int -> Double
calcInterest a 0 = accountBalance a
calcInterest a n = (calcInterest a (n-1)) * (1.0 + (interest a))

menu :: Account -> IO ()
menu account = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    putStrLn "1. Account Balance"
    putStrLn "2. Calculate Interest"
    putStrLn "3. Deposit"
    putStrLn "4. Withdraw"
    putStrLn "5. View Transaction History"
    putStrLn "6. Quit"
    putStr "Enter your choice: "
    hFlush stdout

    choice <- getLine
    case choice of
        "1" -> do
            putStrLn $ "Account Balance Is " ++ show (accountBalance account)
            putStrLn $ "Account interest rate is " ++ show (interest account)
            menu account
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
            -- Recursive call passes the new state (with the new balance) back to the menu
            menu newAccount
        "4" -> do
            putStr "Enter the amount to withdraw: "
            hFlush stdout
            amount <- readLn
            let newAccount = withdraw amount account
            putStrLn $ "New balance " ++ show (accountBalance newAccount)
            menu newAccount
        "5" -> do
            putStrLn "\n--- Transaction History ---"
            -- We reverse the log because we prepended new items to the front
            mapM_ putStrLn (reverse (accountLog account))
            menu account
        "6" -> putStrLn "Goodbye!" 
        _   -> do
            putStrLn "Invalid choice, try again."
            menu account

-- Code for selecting accounts
accountSelect :: [Account] -> IO()
accountSelect a = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    let numbered = zip [0..] [accountBalance e | e <- a]
    let names = [ "Account " ++ show n ++ ": Balance $" ++ show (bal) ++ "\n" | (n, bal) <- numbered]
    putStrLn (concat names)
    putStr "Pick account number to view: "
    hFlush stdout
    acct <- readLn
    menu (a !! acct)

main :: IO ()
main = do
    let customer1 = defaultCustomer { customerName = "Jimmy Buffet" }
        -- Create default accounts with initial logs
        checking1 = defaultChecking { accountID = 001, accountCustomer = customer1, accountBalance = 1500.0 }
        savings1 = defaultSavings { accountCustomer = customer1, accountBalance = 2000.0, interestRate = 0.05 }
        
    let bank = [savings1 , checking1]
    accountSelect bank