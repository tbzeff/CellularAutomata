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
	input <- getLine
	case (read input) of
		1 -> printRule
		2 -> printNRules
		3 -> printRangeRules
		4 -> printAllRules
		_ -> exitSuccess

printRandom :: Int -> String -> IO ()
printRandom iters rule = do
	putStrLn "How long would you like the configuration?"
	len <- getLine
	config <- randomConfig (read len)
	runAutomata iters rule config

printRule :: IO ()
printRule = do
	putStrLn ""
	putStrLn "Which rule do you want to write? (Enter a number X where 0 <= X < 255)"
	rule <- getLine
	putStrLn "For how many iterations? (Enter a postive interger)"
	iters <- getLine
	putStrLn "Please provide a starting configuration (enter line consisting of '1's and spaces, or enter 'default'/press enter, or enter 'random'): "
	config <- getLine
	case config of
		[]		  -> runAutomata (read iters) (toRule $ read rule) defaultConfig
		"default" -> runAutomata (read iters) (toRule $ read rule) defaultConfig
		"random"  -> printRandom (read iters) (toRule $ read rule)
		_ 		  -> runAutomata (read iters) (toRule $ read rule) config

printNRules :: IO ()
printNRules = do
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- getLine
	putStrLn "How many rules would you like to see? (Enter a number X where 0 <= X < 255"
	n <- getLine
	runNRules (read iters) 0 ((read n) - 1)

printRangeRules :: IO ()
printRangeRules = do 
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- getLine
	putStrLn "Enter start rule: "
	start <- getLine
	putStrLn "Enter end rule: "
	end <- getLine
	runNRules (read iters) (read start) (read end)

printAllRules :: IO ()
printAllRules = do
	putStrLn ""
	putStrLn "How many iterations of each rule? "
	iters <- getLine
	runAllRules (read iters) 0