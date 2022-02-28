{-# LANGUAGE DoAndIfThenElse #-}

module Main where
import Convert
import Checker
import Test.QuickCheck
import Control.Monad
import Data.Char

import System.Exit (exitFailure)

instance Arbitrary Symb where
    arbitrary = liftM Symb . elements . map ((: []) . chr) $ [65..90] ++ [97..122]

instance Arbitrary Expr where
    arbitrary = sized arbitHelper

arbitHelper :: Int -> Gen Expr
arbitHelper n | n == 0 = randomVar
              | otherwise = oneof [randomVar, randomNeg e1, randomOther e1 e2]
    where e1 = arbitHelper (n - 2)
          e2 = arbitHelper (n - 2)

randomVar :: Gen Expr
randomVar = Var <$> arbitrary

randomNeg :: Gen Expr -> Gen Expr
randomNeg e = Neg <$> e

randomOther :: Gen Expr -> Gen Expr -> Gen Expr
randomOther e1 e2 = oneof [(insertGen e1 e2 Conj), (insertGen e1 e2 Disj), (insertGen e1 e2 Cond), (insertGen e1 e2 Bicond)]
    where insertGen e1 e2 op = liftM2 op e1 e2

main = do
    quickCheck (checkNNF . convToNNF)
    quickCheck (checkDNF . convToDNF)
    quickCheck (checkCNF . convToCNF)

    
