# Haskell-Elementary-Automata

Written by Taylor Bleizeffer - 2019

This Haskell file contains several functions and helper functions
that model simple elementary automata visually in the console. 
The state of the automata's cells are represented by the characters
'_' and '-'. So a starting configuration of the automata may look something like:
*"---------_-----------_-----------_--------"*
During each iteration, the cell states are transformed based on the current rule, 
and each cell with either flip its state or remain unchanged depending on the state
of its neighbors, and the resulting configuration is printed beneath the previous.
Given a simple starting configuration, i.e., all cells are the same state except one
(I find the middle to produce the best results), we can start to see interesting 
behaviour. Certain rules will produce boring, but none-the-less intersting resulting
patterns. Others will produce highly ordered patterns that converge to said pattern
and remain there. Others yet appear to exhibit purely chaotic behavior, the same
kind exhibited by complex systems in nature.

To begin an elementary automata visual model you can use two functions currently:

*runAllRules steps startRule*:
This function outputs *steps* iterations of transforming a (statically programmed) input
by each rule, starting at rule *startRule*, which you will pass as an Int.
Although you will pass an into to this function, each rule takes the form of a binary string,
but a helper function, *toRule n* converts the integer *n* into a string of its 8-bit 
binary representation (*runAllRules* will not let *0 <= n <= 255* be false. *n* should
never be less than 0 or greater than 255.)

*runAutomata steps rule startConfig*:
This function will run the rule  *rule* for *steps* iterations.
The startConfig will be a string of your choosing, so 
long as it only consists of the characters '_' and '-'.
*NOTE:* here *rule* should be in binary string representation, so
it is advised to use the helper function *toRule n* as described above.