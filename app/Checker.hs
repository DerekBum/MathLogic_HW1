module Checker where
import Convert

checkNNF :: Expr -> Bool
checkNNF (Var _) = True
checkNNF (Neg e) = case e of (Var _) -> True 
                             otherwise -> False
checkNNF (Conj e1 e2) = (checkNNF e1) || (checkNNF e2)
checkNNF (Disj e1 e2) = (checkNNF e1) || (checkNNF e2)
checkNNF _ = False



checkDNF :: Expr -> Bool
checkDNF (Var _) = True
checkDNF (Neg e) = case e of (Var _) -> True 
                             otherwise -> False
checkDNF (Disj e1 e2) = (checkDNF e1) || (checkDNF e2)
checkDNF (Conj e1 e2) = case e1 of (Var _) -> checkDNF e2
                                   (Conj _ _) -> (checkDNF e1) || (checkDNF e2)
                                   otherwise -> case e1 of (Var _) -> checkDNF e1
                                                           (Conj _ _) -> (checkDNF e1) || (checkDNF e2)
                                                           otherwise -> False
checkDNF _ = False




checkCNF :: Expr -> Bool
checkCNF (Var _) = True
checkCNF (Neg e) = case e of (Var _) -> True 
                             otherwise -> False
checkCNF (Conj e1 e2) = (checkCNF e1) || (checkCNF e2)
checkCNF (Disj e1 e2) = case e1 of (Var _) -> checkCNF e2
                                   (Disj _ _) -> (checkCNF e1) || (checkCNF e2)
                                   otherwise -> case e1 of (Var _) -> checkCNF e1
                                                           (Disj _ _) -> (checkCNF e1) || (checkCNF e2)
                                                           otherwise -> False
checkCNF _ = False
