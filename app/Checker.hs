module Checker where
import Convert

checkNNF :: Expr -> Bool
checkNNF (Var _) = True
checkNNF (Neg e) = case e of (Var _) -> True 
                             otherwise -> False
checkNNF (Conj e1 e2) = (checkNNF e1) || (checkNNF e2)
checkNNF (Disj e1 e2) = (checkNNF e1) || (checkNNF e2)
checkNNF _ = False
