module OneDCA (
    splitIntoTriples, transform, toRule
) where

splitIntoTriples :: String -> [String]
splitIntoTriples cells
    | snd split == [] = cells : []
    | otherwise = (fst split) : (splitIntoTriples (tail cells))
    where split = splitAt 3 cells
    
transform :: String -> [String] -> String
transform "" [] = []
transform "" _  = []
transform _ [] = []    
transform rules (x:xs) | x == "   " = (rule 0) : transform rules xs
                            | x == "  1" = (rule 1) : transform rules xs
                            | x == " 1 " = (rule 2) : transform rules xs
                            | x == " 11" = (rule 3) : transform rules xs
                            | x == "1  " = (rule 4) : transform rules xs
                            | x == "1 1" = (rule 5) : transform rules xs
                            | x == "11 " = (rule 6) : transform rules xs
                            | x == "111" = (rule 7) : transform rules xs
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
