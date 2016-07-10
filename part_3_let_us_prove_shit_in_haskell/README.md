# Let's Prove Stuff in Haskell

## Description
In this presentation we will not only consider live programming, but also live
proving! We will see how it is possible to incorporate proofs for static
guarantees in real programs. We consider the techniques using the well known
property of commutativity of addition using the Peano axioms. When this is
done we will take a discussion and see how this can be implemented in real world
program side by side with usual software testing.

## Structure
A presentation on proving properties in Haskell. The core structure of the
presentation is as follows:

* Motivation / Introduction
    - Better understanding of Coq
    - Commutativity of addition:
        + A simple proof
        + Simple modeling: naturals, addition, equivalence
* Breakdown of the proof
    - Modeling natural numbers
    - Modeling addition
    - Equivalence relation
* Formalizing it as dependent types in Haskell
    - Type and value level Naturals
    - Type and value level addition
    - Type and value level equivalence relation
* Encoding the proof as a type
* Programming the proof
    - a function that satisfies the type signature

## New Terminology

* Kinds
* Dependent types
* 