module Main where

import Convert

main :: IO ()
main = do
    putStrLn "Please, enter the formula in the correct format"
    inp <- getLine
    let formula = read inp :: Expr
    let nnf = convToNNF formula
    let dnf = convToDNF formula
    let cnf = convToCNF formula
    putStrLn $ "NNF: " ++ show nnf
    putStrLn $ "DNF: " ++ show dnf
    putStrLn $ "CNF: " ++ show cnf
