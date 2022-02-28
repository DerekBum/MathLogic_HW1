# NNF, DNF, CNF Converter

[![Build Status](https://app.travis-ci.com/DerekBum/MathLogic_HW1.svg?branch=main)](https://app.travis-ci.com/DerekBum/MathLogic_HW1)

Преобразователь пропозициональных формул в [отрицательную нормальную форму](https://en.wikipedia.org/wiki/Negation_normal_form), [дизъюнктивную нормальную форму](https://en.wikipedia.org/wiki/Disjunctive_normal_form), [конъюктивную нормальную форму](https://en.wikipedia.org/wiki/Conjunctive_normal_form).  

## Небольшие соглашения

Будем рассматривать формулы только над следующим базисом:  
| operation | output |
|---|---|
| not | ~ |
| and | && |
| or | \|\| |
| imply | --> |
| equiv | <=> |

В таблице приведен еще и формат вывода для формул.

## Структура работы

Вся работа написана на **Haskell**. Файл [Convert.hs](https://github.com/DerekBum/MathLogic_HW1/blob/main/app/Convert.hs) содержит описание структуры данных, в которой мы храним всю формулу, а также содержит функции перевода формулы к данным нормальным формам.  
Файл [Checker.hs](https://github.com/DerekBum/MathLogic_HW1/blob/main/app/Checker.hs) содержит функции для проверки, находится ли формула в нормальной форме или нет. Для каждой нормальной формы реализована своя функция.  
Файл [test.hs](https://github.com/DerekBum/MathLogic_HW1/blob/main/app/test.hs) содержит юнит тесты.  
Файл [randomTest.hs](https://github.com/DerekBum/MathLogic_HW1/blob/main/app/randomTest.hs) содержит реализацию рандомизированных тестов.

## Инструкция по запуску 

Для запуска проекта достаточно ввести в консоли команду  
```cabal run Converter```  
После выполнения этой команды нужно ввести формулу в корректном виде. Подробнее о том, как должна выглядеть формула можно посмотреть в файле [Convert.hs](https://github.com/DerekBum/MathLogic_HW1/blob/main/app/Convert.hs).  
Например, формула ```Conj (Cond (Neg (Var (Symb "a"))) (Var (Symb "b"))) (Var (Symb "c"))``` записана корректно.  

Для запуска тестов достаточно ввести команду  
```cabal new-test```

## Дополнительные сведения

Для репозитория настроен [travis-ci](https://travis-ci.org/) для автоматического запуска тестов.
