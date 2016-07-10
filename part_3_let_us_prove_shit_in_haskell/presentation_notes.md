---
title: Provind s**t in haskell
author: Mads Buch
---

# Commutivity of addition: Proof by hand
We use the model of natural numbers laid out by the Peano axioms. It is uniform,
simple, and a good fit for reasoning about these properties.



# Breakdown of the proof

* Modeling natural numbers
* Modeling addition of natural numbers
* Modeling equality

In the proof we use the equality sign. This is something that means another
thing in programs. Either we define a variable to a value, or we check if two
runtime values are identical. In this situation we use it in the propositional
sense. And we need it to be formalized in both the operational semantics and
denotational semantics of Haskell. 

# Haskell
In this presentation we use Haskell. This is because Haskell is a
general purpose programming language used in the industry. The
type system is strong enough to express the propositions we want to prove.

__A philosophical note:__ Are we sure that the system that verifies our proof
does it correctly? We need

# Modeling the problem in haskell 

__Natural numbers:__

        data Nat = 0 | S Nat

* Dependent natural numbers
* Equivalence relation

# Some Prereqs
This section introduces some concepts that are used for this to work.

* __Kinds__
* __Datatype promotion:__
* __Type Safe Casts:__


# Haskell Language Extensions and Symbols
Above will not compile right away. This is because we need a couple og language
extensions. We will here take a short look and talk about what the extensions
provide of functionality needed in order to make it compile.

They are ordered of decreasing importatance.

* __DataKinds:__
* __GADTs:__ Allows us to use generalized abstract datatypes
* __DeriveGeneric:__
* __TypeOperators:__ This enables us to make operators on the types. 
* __FlexibleInstances:__
* __StandaloneDeriving:__
* __NoImplicitPrelude:__
* __PolyKinds:__
* __RankNTypes:__
* __TypeFamilies:__
* __UndecidableInstances:__
* __ExplicitNamespaces:__

We furthermore use some non-standard notation, which we will also elaborate on:

* __`=>`:__ Denotes a _type context_
* __`~`:__ Denotes type equality. 

The last thing here is the compilation. We compile the software using the
Haskell interpreter `ghci Proof -Wall -Werror`. Notice the `-Wall`. It makes sure
to warn us about non-exhaustive patterns. The `-Werror` flag turns the
warning into an error. In that way we will not compile, unless the proof is
complete. To be a proof, we need the function to be complete.

# Encoding the proof as a type in haskell
In orinary math the prove would look something like

$$
  \forall a, b \in \mathbb{N}. a+b = b+a
$$

We have explicitly written the quantification of the variables. This is needed
to understand why we write our function as we do in haskell.

What we initially want is something like

        a : int -> b : int -> reflection a+b b+a

where refection is the "="-sign written as a predicate.

# Programming the Proof
From above we have the type signature. The only thing we need to do now, is to
program the proof! Easy peacy!

      plus_is_commutative :: SNat n -> SNat m -> Refl (SNat (m + n)) (SNat (n + m))


# Diskussion
That's good, but for what can it be used?

* __We can formally show properties for real programs:__ This is cool as we
  the strongest guarantee that the properties hold. It is basically only
  malfunctioning hardware or wrong formalizations of the properties that will
  brake the system (Finally we can safely blame everything on the hardware
  engineers).
* __We decide which properties to formalize:__ We can make everything completely
  dependent. This is not feasible for most applications. What we consider in a
  moment is a showcase where parts are formalized and reasoned about, namely
  the size of a matrix. We don't care about the individual elements. This is
  still sufficient to build static guarantees for something that could
  potentially break a runtime system.

## Showcase: Linear algebra with statically tracked sizes

## Showcase: Side by side with software testing

# Conclusion

[^givingHaskellAPromotion]: Giving Haskell a Promotion
[^dataKinds]: https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/promotion.html



