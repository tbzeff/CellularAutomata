module CAUtil ( 
    defaultConfig, randomConfig, runAutomata, runAllRules, runNRules
) where

import OneDCA
import System.Random
import Data.Time.Clock

defaultConfig :: String 
defaultConfig = "11111111111111111111111111111111111111111111111111111111111111111111111111 11111111111111111111111111111111111111111111111111111111111111111111111111"

-- https://stackoverflow.com/questions/37497135/haskell-random-numbers
sample :: Int -> StdGen -> ([Int],StdGen)
sample m g1 = case m of
  0 -> ([],g1)
  k -> let (rs,g2) = sample (k-1) g1
           (r, g3) = randomR (0,1) g2
        in ((r:rs),g3)

randomConfig :: Int -> IO [Char]
randomConfig len | len <= 0  = return []
                 | otherwise = do 
    currentTime <- getCurrentTime
    let seed = fromIntegral $ diffTimeToPicoseconds $ utctDayTime currentTime 
    let g = mkStdGen seed
    let coinFlips = fst $ sample len g
    let convert x = if x == 0 
                    then ' '
                    else '1' 
    return $ map convert coinFlips
        
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
