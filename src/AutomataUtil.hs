module AutomataUtil ( 
    defaultConfig, runAutomata, runAllRules, runNRules, runAllRand
) where

import CellularAutomata

defaultConfig :: String 
defaultConfig = "11111111111111111111111111111111111111111111111111111111111111111111111111 11111111111111111111111111111111111111111111111111111111111111111111111111"

-- Execute automata functions
runAutomata :: Int -> String -> String -> IO ()
runAutomata steps rules startConfig 
    | steps > 0 = do putStrLn $ "Iter #" ++ (show steps) ++ " " ++ (show startConfig)
                     runAutomata (steps - 1) rules newConfig
    | otherwise = do putStrLn "END RULE"
                     putStrLn ""
    where newConfig = ' ' : (transform rules (splitIntoTriples startConfig)) ++ [' ']

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
