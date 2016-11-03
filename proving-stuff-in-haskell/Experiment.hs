{-# LANGUAGE GADTs                #-} -- Soft dependent types
{-# LANGUAGE PolyKinds            #-} -- Allow general specification of Refl
{-# LANGUAGE RankNTypes           #-} -- The forall stuff
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}

-- A stand alone file that includes everything for a couple of proofs
module Experiment where

-- Our type level numerals
data Nat = S Nat

-- Value level naturals
data SNat (n :: Nat) where
--  Zero :: SNat Z
  Succ :: SNat n -> SNat (S n)

instance Show (SNat n) where
--   show Zero     = "Zero"
   show (Succ n) = "Succ " ++ (show n)

type family Add (n :: Nat) (m :: Nat) :: Nat
--type instance Add Z      m = m
type instance Add (S m)  n = S (Add m n)

-- Type Equality

-- Import from Data.Type.Equality. Only explicit for educational purposes.

data Refl a b where
  Refl :: Refl a a

instance Show (Refl a b) where
   show Refl     = "Refl"

-- Basic properties
reflexive :: Refl a a
reflexive = Refl

symmetry :: Refl a b -> Refl b a
symmetry Refl = Refl

transitive :: Refl a b -> Refl b c -> Refl a c
transitive Refl Refl = Refl

-- helpers
castWith :: Refl a b -> a -> b
castWith Refl x = x

gcastWith :: Refl a b -> ((a ~ b) => r) -> r
gcastWith Refl x = x


-- Proof - two quantifiers

plus_is_associative :: SNat a -> SNat b -> SNat c -> Refl (Add a (Add b c)) (Add (Add a b) c)
--plus_is_associative Zero b c = Refl
plus_is_associative (Succ a) b c    = gcastWith (plus_is_associative a b c) Refl

