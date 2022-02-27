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
    let g = Disj (Conj a (Cond (Disj (Neg b) c) (Neg c))) d
    let gNNF = checkNNF $ convToNNF g
    let gDNF = checkDNF $ convToDNF g
    let gCNF = checkCNF $ convToCNF g    
    let f = Cond (Bicond a b) b
    let fNNF = checkNNF $ convToNNF f
    let fDNF = checkDNF $ convToDNF f
    let fCNF = checkCNF $ convToCNF f 
    let h = Disj (Conj (Cond a b) (Cond c d)) (Conj (Neg b) (Neg d))
    let hNNF = checkNNF $ convToNNF h
    let hDNF = checkDNF $ convToDNF h
    let hCNF = checkCNF $ convToCNF h
    if ((gNNF && fNNF && hNNF) == False) then
        do putStrLn $ "Wrong answer: NNF test case"
           exitFailure
    else if ((gDNF && fDNF && hDNF) == False) then
        do putStrLn $ "Wrong answer: DNF test case"
           exitFailure
    else if ((gCNF && fCNF && hCNF) == False) then
        do putStrLn $ "Wrong answer: CNF test case"
           exitFailure
    else return ()
