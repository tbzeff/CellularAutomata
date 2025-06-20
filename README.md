# Haskell Elementary Cellular Automata

![elementary-automata-preview](https://github.com/T-Factorial/Haskell-Elementary-Automata/blob/master/proj_preview3.JPG)

A command-line tool for simulating one-dimensional elementary cellular automata in Haskell.

This project visualizes the evolution of cellular automata rules (from Rule 0 to Rule 254) using various user-specified configurations. You can generate a single rule, a custom range of rules, or print all rules using a default or random starting configuration.

## 🛠 Requirements

- [Haskell Stack](https://docs.haskellstack.org/en/stable/)

## 🚀 Getting Started

Clone this repository and run the following commands:

```bash
stack build
stack run CellularAutomata
```

Then, choose an option from the menu:
```
1. Print one rule
2. Print all rules up to X
3. Print a range of rules
4. Print all rules
```

### Print One Rule
Enter:
- Rule number (0–254)
- Number of iterations
- Starting configuration:
  - A string of `'1'`s and spaces
  - `default` (symmetrical pattern)
  - `random` (auto-generated binary string)

### Example
```
Which rule do you want to write? (Enter a number X where 0 <= X < 255)
30
For how many iterations? 
20
Please provide a starting configuration:
random
```

## 📂 Project Structure

- `Main.hs`: Handles user interaction and menu loop
- `CAUtil.hs`: Manages configuration generation and rule execution logic
- `OneDCA.hs`: Core cellular automata logic, including transformation and binary rule decoding

## 👤 Author

Taylor Bleizeffer  
- **https://www.taylorbleizeffer.com**  
- **https://github.com/tbzeff**
