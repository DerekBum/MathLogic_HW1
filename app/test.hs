{-# LANGUAGE DoAndIfThenElse #-}

module Main where
import Convert
import Checker

import System.Exit (exitFailure)

main = do
    let a = Var "A"
    let b = Var "B"
    let c = Var "C"
    let d = Var "D"
    let g = Disj (Conj a (Conj (Disj (Neg b) c) (Neg c))) d
    let cG = checkNNF g
    let f = Cond a b
    let fG = checkNNF f
    if (cG == False) then
        do putStrLn $ "Wrong False: 1 test case"
           exitFailure
    else if (fG == True) then
        do putStrLn $ "Wrong True: 2 test case"
           exitFailure
    else return ()
