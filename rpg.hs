-- Define the possible character classes
data Hero = Knight | Wizard | Rogue

-- Define a function that behaves differently based on the type
specialAttack :: Hero -> String
specialAttack Knight = "Slash with Greatsword!"
specialAttack Wizard = "Cast Fireball!"
specialAttack Rogue  = "Backstab!"

main :: IO ()
main = do
    let myHero = Wizard
    putStrLn "Combat Action:"
    putStrLn (specialAttack myHero)