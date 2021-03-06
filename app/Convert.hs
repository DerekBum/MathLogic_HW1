module Convert where

newtype Symb = Symb String
    deriving (Eq, Read)

instance Show Symb where
    show (Symb s) = show s

data Expr = Var Symb
          | Neg Expr
          | Conj Expr Expr
          | Disj Expr Expr
          | Cond Expr Expr
          | Bicond Expr Expr
          deriving (Eq, Read)

instance Show Expr where
    show (Var v) = show v
    show (Neg e) = '~' : show e
    show (Conj e1 e2) = '(' : show e1 ++ " && " ++ show e2 ++ ")"
    show (Disj e1 e2) = '(' : show e1 ++ " || " ++ show e2 ++ ")"
    show (Cond e1 e2) = '(' : show e1 ++ " --> " ++ show e2 ++ ")"
    show (Bicond e1 e2) = '(' : show e1 ++ " <-> " ++ show e2 ++ ")"

convToNNF :: Expr -> Expr
convToNNF (Neg (Neg e)) = convToNNF e                                                                              --double negation
convToNNF (Neg (Conj e1 e2)) = convToNNF (Neg e1) `Disj` convToNNF (Neg e2)                                        --De Morgan 1
convToNNF (Neg (Disj e1 e2)) = convToNNF (Neg e1) `Conj`  convToNNF (Neg e2)                                       --De Morgan 2
convToNNF (Cond e1 e2) = convToNNF (Neg e1) `Disj` convToNNF e2                                                    --conditional
convToNNF (Bicond e1 e2) = Disj (convToNNF (Neg e1) `Conj` convToNNF (Neg e2)) (convToNNF e1 `Conj` convToNNF e2)  --biconditional
convToNNF e@(Var _) = e
convToNNF e@(Neg (Var _)) = e
convToNNF (Conj e1 e2) = convToNNF e1 `Conj` convToNNF e2
convToNNF (Disj e1 e2) = convToNNF e1 `Disj` convToNNF e2
convToNNF (Neg e@(Cond _ _)) = convToNNF (Neg (convToNNF e))
convToNNF (Neg e@(Bicond _ _)) = convToNNF (Neg (convToNNF e))

ruleD :: Expr -> Expr -> Expr
ruleD e1 (Disj e2 e3) = (ruleD e1 e2) `Disj` (ruleD e1 e3)
ruleD (Disj e1 e2) e3 = (ruleD e1 e3) `Disj` (ruleD e2 e3)
ruleD e1 e2 = e1 `Conj` e2

convToDNF :: Expr -> Expr
convToDNF = helperDNF . convToNNF
    where helperDNF (Conj e1 e2) = ruleD (helperDNF e1) (helperDNF e2)
          helperDNF (Disj e1 e2) = Disj (helperDNF e1) (helperDNF e2)
          helperDNF e = e

ruleC :: Expr -> Expr -> Expr
ruleC e1 (Conj e2 e3) = (ruleC e1 e2) `Conj` (ruleC e1 e3)
ruleC (Conj e1 e2) e3 = (ruleC e1 e3) `Conj` (ruleC e2 e3)
ruleC e1 e2 = e1 `Disj` e2

convToCNF :: Expr -> Expr
convToCNF = helperCNF . convToNNF
    where helperCNF (Disj e1 e2) = ruleC (helperCNF e1) (helperCNF e2)
          helperCNF (Conj e1 e2) = Conj (helperCNF e1) (helperCNF e2)
          helperCNF e = e
