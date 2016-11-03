{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE StandaloneDeriving   #-}
-- {-# LANGUAGE NoImplicitPrelude    #-}
{-# LANGUAGE PolyKinds            #-}
{-# LANGUAGE RankNTypes           #-}
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ExplicitNamespaces   #-}

module Nat where

import TypeEquality

-- Our type level numerals
data Nat = Z | S Nat

-- Value level naturals
data SNat (n :: Nat) where
  Zero :: SNat Z
  Succ :: SNat n -> SNat (S n)

instance Show (SNat n) where
   show Zero     = "Zero"
   show (Succ n) = "Succ " ++ (show n)

type family Add (n :: Nat) (m :: Nat) :: Nat
type instance Add Z      m = m
type instance Add (S m)  n = S (Add m n)

plus_id_l :: SNat n -> Refl (Add Z n) n
plus_id_l n = Refl -- Follows directly from the specification of add

plus_id_r :: forall n. SNat n -> Refl (Add n Z)  n
plus_id_r Zero = Refl
plus_id_r (Succ x) = gcastWith (plus_id_r x) Refl -- Hey! Induction!

-- Proof - two quantifiers

plus_is_associative :: SNat a -> SNat b -> SNat c -> Refl (Add a (Add b c)) (Add (Add a b) c)
plus_is_associative Zero b c = Refl
plus_is_associative (Succ a) b c    = gcastWith (plus_is_associative a b c) Refl

plus_is_commutative :: SNat n -> SNat m -> Refl (Add m n) (Add n m)
plus_is_commutative Zero Zero  = Refl
plus_is_commutative Zero m     = plus_id_r m
plus_is_commutative (Succ n) m = error "For the reader"
