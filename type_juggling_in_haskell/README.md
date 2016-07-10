# Practical Applications of Haskell Type Juggling
This talk goes through the practical aspects  of advanced typing concepts
in Haskell.

To play along it is recommended to have a working installation of
[Haskell Stack](http://haskellstack.org/).

## Description
The talk is taking offset in a matrix library. These are usually implemented
in a non-type safe manner. We make it type safe by creating a statically typed
vector.

In the talk we elaborate on intermediate typing concepts which requires
languages extensions. We take a look at parametric polymorphism, GADTs,
datatype promotion.

The elaboration on why this works is saved to a later talk, hence we
omit to talk about kinds, dependent types, etc.

## Resources

* http://www.haskellforall.com/2012/09/the-functor-design-pattern.html