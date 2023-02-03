module CellularAutomata (
    defaultConfig, runAutomata, runAllRules, runNRules, runAllRand, toRule
) where

defaultConfig :: String 
defaultConfig = "11111111111111111111111111111111111111111111111111111111111111111111111111 11111111111111111111111111111111111111111111111111111111111111111111111111"

-- Execute automata functions
runAutomata :: Int -> String -> String -> IO ()
runAutomata steps rules startConfig 
    | steps > 0 = do putStrLn $ "Iter #" ++ (show steps) ++ " " ++ (show startConfig)
                     runAutomata (steps - 1) rules newConfig
    | otherwise = do putStrLn "END RULE"
                     putStrLn ""
    where newConfig = ' ' : (transformCells rules (splitIntoTriples startConfig)) ++ [' ']

runAllRules :: Int -> Int -> IO ()
runAllRules steps startRule
    | startRule <= 255 = do putStrLn $ "RULE " ++ (show startRule)
                            runAutomata steps (toRule startRule) defaultConfig
                            runAllRules steps (startRule + 1)
    | otherwise        = putStrLn ""

runNRules :: Int -> Int -> Int -> IO ()
runNRules steps startRule endRule
    | startRule <= endRule = do putStrLn $ "RULE " ++ (show startRule)
                                runAutomata steps (toRule startRule) defaultConfig
                                runNRules steps (startRule + 1) endRule
    | otherwise            = putStrLn ""

runAllRand :: Int -> Int -> String -> IO ()
runAllRand steps startRule startConfig
    | startRule < 255 = do putStrLn $ "RULE " ++ (show startRule)
                           runAutomata steps (toRule startRule) startConfig
                           runAllRand steps (startRule + 1) startConfig
    | otherwise = (runAutomata steps (toRule 255) startConfig)

splitIntoTriples :: String -> [String]
splitIntoTriples cells
    | snd split == [] = cells : []
    | otherwise = (fst split) : (splitIntoTriples (tail cells))
    where split = splitAt 3 cells
    
transformCells :: String -> [String] -> String
transformCells "" [] = []
transformCells "" _  = []
transformCells _ [] = []    
transformCells rules (x:xs) | x == "   " = (rule 0) : transformCells rules xs
                            | x == "  1" = (rule 1) : transformCells rules xs
                            | x == " 1 " = (rule 2) : transformCells rules xs
                            | x == " 11" = (rule 3) : transformCells rules xs
                            | x == "1  " = (rule 4) : transformCells rules xs
                            | x == "1 1" = (rule 5) : transformCells rules xs
                            | x == "11 " = (rule 6) : transformCells rules xs
                            | x == "111" = (rule 7) : transformCells rules xs
    where rule r = rules !! r
    
toRule :: Int -> String
toRule 0 = "        "
toRule n = reverse $ fillOut 8 $ reverse $ encode n

encode :: Int -> String
encode n | n <= 0          = []
         | n `mod` 2 == 1 = '1' : encode (n `div` 2)
         | n `mod` 2 == 0 = ' ' : encode (n `div` 2)

fillOut :: Int -> String -> String
fillOut n string
    | length string < n = fillOut n (' ' : string)
    | otherwise = string
