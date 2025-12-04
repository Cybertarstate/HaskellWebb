import System.IO (hFlush, stdout)
import Numeric (showFFloat)
import Language.Haskell.TH.Syntax (justName)

newtype Customer = Customer --new type signature with data constructor
    { customerName :: String
    } deriving (Show, Eq) --allows us to print Customers and compare them

-- Modified Account to include a log for history
-- We need to store the history inside the object since we can't use a global variable
data Account = CheckingAccount --Algebraic Data Type with two constructors
    { accountID :: Int
    , accountCustomer :: Customer
    , accountBalance :: Double
    , accountLog :: [String] 
    }
    | SavingsAccount  
    { accountID :: Int
    , accountCustomer :: Customer
    , accountBalance :: Double
    , interestRate :: Double
    , accountLog :: [String] 
    }
    deriving (Show, Eq) --allows us to print Accounts and compare them

bank :: [Account] --type signature
bank = [] --initial empty bank 

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
    { accountID = 321
    , accountCustomer = defaultCustomer
    , accountBalance = 0.0
    , interestRate = 0.00
    , accountLog = ["Account Opened"]
    }

-- Update balance and add the transaction message to the front of the log list
deposit :: Double -> Account -> Account
deposit amount (CheckingAccount id name balance log) = 
    CheckingAccount id name (balance + amount) (("Deposited " ++ show amount) : log)
deposit amount (SavingsAccount id name balance rate log) = 
    SavingsAccount id name (balance + amount) rate (("Deposited " ++ show amount) : log)

withdraw :: Double -> Account -> Account
withdraw amount (CheckingAccount id name balance log) 
    | amount <= balance = CheckingAccount id name (balance - amount) (("Withdrew " ++ show amount) : log)
    | otherwise         = CheckingAccount id name balance (("Failed Withdrawal of " ++ show amount) : log)
withdraw amount (SavingsAccount id name balance rate log) 
    | amount <= balance = SavingsAccount id name (balance - amount) rate (("Withdrew " ++ show amount) : log)
    | otherwise         = SavingsAccount id name balance rate (("Failed Withdrawal of " ++ show amount) : log)

-- Helper to get interest rate safely
interest :: Account -> Double
interest acc = case acc of
    CheckingAccount{} -> 0.0
    SavingsAccount{} -> interestRate acc

calcInterest :: Account -> Int -> Double
calcInterest a 0 = accountBalance a
calcInterest a n = calcInterest a (n-1) * (1 + interest a / 100)

menu :: Account -> IO ()
menu account = do
    putStrLn "\n===== Grouper Bank Group Inc. ====="
    putStrLn "1. Account Balance"
    putStrLn "2. Calculate Interest"
    putStrLn "3. Deposit"
    putStrLn "4. Withdraw"
    putStrLn "5. View Transaction History"
    putStrLn "6. Account Selection"
    putStrLn "7. Quit"
    putStr "Enter your choice: "
    hFlush stdout

    choice <- getLine
    case choice of
        "1" -> do
            putStrLn $ "Account Balance Is " ++ show (accountBalance account)
            putStrLn $ "Account interest rate is " ++ showFFloat (Just 2) (interest account) "" ++ "%"
            menu account
        "2" -> do
            putStr "Enter number of years for interest: "
            hFlush stdout
            y <- readLn
            putStrLn $ "Account interest rate is " ++ showFFloat (Just 2) (interest account) "" ++ "%"
            putStrLn $ "New Bal: " ++ showFFloat (Just 2) (calcInterest account y) ""
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
        "6" -> do
            accountSelect bank1
        "7" -> putStrLn "Goodbye!" 
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

customer1 = defaultCustomer { customerName = "Jimmy Buffet" }
    -- Create default accounts with initial logs
checking1 = defaultChecking { accountID = 001, accountCustomer = customer1, accountBalance = 1500.0 }
savings1 = defaultSavings { accountID = 002, accountCustomer = customer1, accountBalance = 2000.0, interestRate = 0.05 }        
bank1 = [checking1,savings1]

main :: IO ()
main = do

    accountSelect bank1