lazy - only evaluate as much as the program as required to get the answer

built in memory management, relieves the programemer of memory management, store is allocated an initialized implicitly, and recovered automatically by garbage collector

innovative type system which supports a systemic form a oerloading and a module system

strongly typed

functional language:single expression, executed by evaluating the expression, focus on what is to be computed, not how it should be computed

(working in VS code)
for mac install "GHCup"

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

ghc --version
cabal --version
stack --version
haskell-language-server --version

--haskell hello world
main :: IO ()
main = putStrLn "Hello, world!"
--save as
hello.hs
--run it no compile
runghc hello.hs
--save as binary
ghc hello.hs
--run executable
./hello
--side note
cabal is haskell build tool, builds code, managages libraries and dependencies
stack is alternative build tool, stack is simpler and more beginner friendly, cabal is the official



--research
https://www.haskell.org/



Haskell is a purely functional programming language based on lambda calculus. No global state or mutable variables. Increment a number in tuple, need to create a new tuple with a new value. Strongly typed programming language and its declarative. Type inference is powerful enough to not need type annotations. Instead of while and for loops, we have recursion. Conditionals in the form of if, algebraic data types. Lambda calculus polymorphism. Lazy semantics, normal order, call by name. Monads....

non-strict, purely functional programming languages existed
lazy language will not evaluate 

variables

function arguments

entire function bodies

data constructors

list elements

anything that can be an expression

until it is actually needed, anything required to produce an output will be evaluated. demand-driven evaluation. thunk is reference to unevaluated expression. avoid work when needed, allow for infinite data structures

    Functional
    Statically typed
    Pure
    Lazy
    Strongly typed
    Green threads
    Native executables
    Garbage collected
    Immutability


--function takes A and returns B
-This is how Haskell handles randomness without side effects—it passes the 
-generator forward.
twoRandomInts :: StdGen -> ([Integer], StdGen)


https://www.haskell.org/


lazy strong functional,
lambda?
DFA sim?
lazy vs non strict?
The principal problem with lazy evaluation is its behavior in the presence of side effects. If an argument contains a reference to a variable that may be modified by an assignment, then the value of the argument will depend on whether it is evaluated before or after the assignment.
These problems do not arise in Miranda or Haskell because they are purely functional: there are no side effects. Scheme and OCaml leave the problem up to the programmer, but require that every use of a delay-ed expression be enclosed in force, making it relatively easy to identify the places where side effects are an issue.

monads
More recent versions of Haskell employ a more general concept known as monads. Monads are drawn from a branch of mathematics known as category theory, but one doesn't need to understand the theory to appreciate their usefulness in practice. In Haskell, monads are essentially a clever use of higher-order functions, coupled with a bit of syntactic sugar, that allow the programmer to chain together a sequence of actions (function calls) that have to happen in order. The power of the idea comes from the ability to carry a hidden, structured value of arbitrary complexity from one action to the next. In many applications of monads, this extra hidden value plays the role of mutable state: differences between the values carried to successive actions act as side effects.

Haskell is a purely functional programming language based on lambda calculus. No global state or mutable variables. Increment a number in tuple, need to create a new tuple with a new value. Strongly typed programming language and its declarative. Type inference is powerful enough to not need type annotations. Instead of while and for loops, we have recursion. Conditionals in the form of if, algebraic data types. Lambda calculus polymorphism. Lazy semantics, normal order, call by name. Monads....

Made up of a series of function definitions, all functions have a result, no void functions.  

https://web.stanford.edu/class/cs242/materials/lectures/haskell-notes.pdf

■ First-class function values and higher-order functions
In Section 3.6.2 we defined a first-class value as one that can be passed as a parameter, returned from a subroutine, or (in a language with side effects) assigned into a variable. Under a strict interpretation of the term, first-class status also requires the ability to create (compute) new values at run time. In the case of subroutines, this notion of first-class status requires nested lambda expressions that can capture values defined in surrounding scopes, giving those values unlimited extent (i.e., keeping them alive even after their scopes are no longer active). Subroutines are second-class values in most imperative languages, but first-class values (in the strict sense of the term) in all functional programming languages. A higher-order function takes a function as an argument, or returns a function as a result

■ Extensive polymorphism
Polymorphism is important in functional languages because it allows a function to be used on as general a class of arguments as possible. As we have seen in Sections 7.1 and 7.2.4, Lisp and its dialects are dynamically typed, and thus inherently polymorphic, while ML and its relatives obtain polymorphism through the mechanism of type inference. Lists are important in functional languages because they have a natural recursive definition, and are easily manipulated by operating on their first element and (recursively) the remainder of the list. Recursion is important because in the absence of side effects it provides the only means of doing anything repeatedly.

■ List types and operators

■ Structured function returns

■ Constructors (aggregates) for structured objects

■ Garbage collection


https://wiki.haskell.org/Humor
ref/documentation
https://www.referencecollection.com/references/haskell_reference.hs.html
https://dl.acm.org/doi/pdf/10.1145/1238844.1238856
graph reduction meant interpretation
algebraic data types
laziness
lambda calculus(pure? thunks?)

history:
The story of lambda calculus and laziness.
1978 Backus Naur Form and Fortran, puts functional programming on the map. 1960's Peter Landin and Christopher Strachey identified importance of lambda calculus for modelling programming languages. This laid foundation of operational semantics and denotational semantics. 1970's Scheme adheres more closely to lambda calculus by implementing lexical scoping. Laziness invented over 3 times during the 1970's and 1980's. August of 1980 first Lisp conference in StandFord, CA. Hope is a language that introduced algebraic data types. September of 1981, first conference on Functional Programming languages and computer architecture in Portsmouth, New Hampshire. September 1982, Second Lisp Conference, now referred to as Lisp and Functional Programming. The Lazy tower of Babel:Miranda,Lazy ML,Orwell,Alfl,Id,Clean,Ponder,Daisy. The problem, a majority of these languages lacked focus in areas of language-design effort, implementations, and users. Scheme and ML communities had developed their own standards. Fall of 1987 meeting at Functional Programming and Computer Architecture conference marked the beginning of the Haskell development process. They determined the best path forward was to start with a pre-existing language, of the lazy languages, Miranda was chosen. It was the most mature, pure, and well designed. David Turner the creator of Miranda, declined, he did not envision multiple dialects of Miranda in circulation. First meeting for official development on Haskell held January of 1988 at Yale. The first order of business determined the goals of this new language. It should be:
1.Suitable for teaching, research, and applications
2.Completely described via publication of a formal syntax and semantics
3.freely available
4.usable for further language research
5.based on ideas that enjoy wide consensus
6.replace unnecessary diversity in functional programming languages.

Various committees met face to face at various universities and conferences, through the late 1980's. April 1990, Haskell Version 1.0, 125 page Report published, and Haskell mailing list established. 1994 Haskell gains internet presence via Haskell.org, server maintained at Yale.


Made up of a series of function definitions, all functions have a result, no void functions.  

https://web.stanford.edu/class/cs242/materials/lectures/haskell-notes.pdf

