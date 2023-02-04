module Main (main) where

import OneDCA
import CAUtil
import Control.Monad
import System.Exit

main :: IO ()
main = forever mainloop

mainloop :: IO ()
mainloop = do
	putStrLn ""
	putStrLn "What would you like to do? "
	putStrLn "1. Print one rule. "
	putStrLn "2. Print all rules up to X."
	putStrLn "3. Print a range of rules."
	putStrLn "4. Print all rules. "
	input <- read <$> getLine
	case input of
		1 -> printRule
		2 -> printNRules
		3 -> printRangeRules
		4 -> printAllRules
		_ -> exitSuccess

printRandom :: Int -> String -> IO ()
printRandom iters rule = do
	putStrLn "How long would you like the configuration?"
	len <- read <$> getLine
	config <- randomConfig len
	runAutomata iters rule config

printRule :: IO ()
printRule = do
	putStrLn ""
	putStrLn "Which rule do you want to write? (Enter a number X where 0 <= X < 255)"
	rule <- read <$> getLine
	putStrLn "For how many iterations? (Enter a postive interger)"
	iters <- read <$> getLine
	putStrLn "Please provide a starting configuration (enter line consisting of '1's and spaces, or enter 'default'/press enter, or enter 'random'): "
	config <- getLine
	case config of
		[]		  -> runAutomata iters (toRule rule) defaultConfig
		"default" -> runAutomata iters (toRule rule) defaultConfig
		"random"  -> printRandom iters (toRule rule)
		_ 		  -> runAutomata iters (toRule rule) config

printNRules :: IO ()
printNRules = do
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- read <$> getLine
	putStrLn "How many rules would you like to see? (Enter a number X where 0 <= X < 255"
	n <- read <$> getLine
	runNRules iters 0 (n - 1)

printRangeRules :: IO ()
printRangeRules = do 
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- read <$> getLine
	putStrLn "Enter start rule: "
	start <- read <$> getLine
	putStrLn "Enter end rule: "
	end <- read <$> getLine
	runNRules iters start end

printAllRules :: IO ()
printAllRules = do
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- read <$> getLine
	runAllRules iters 0