{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE StandaloneDeriving   #-}
{-# LANGUAGE NoImplicitPrelude    #-}
{-# LANGUAGE PolyKinds            #-}
{-# LANGUAGE RankNTypes           #-}
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ExplicitNamespaces   #-}

module Proof where

import TypeEquality
import Nat

--test :: Refl Integer Integer
--test = Refl

plus_id_r :: SNat n -> Refl (n + Z)  n
plus_id_r Zero = Refl       
plus_id_r (Succ x) = gcastWith (plus_id_r x) Refl 

plus_is_commutative :: SNat n -> SNat m -> Refl (SNat (m + n)) (SNat (n + m))

-- Base Case!

-- First try: We bypass the typing!

plus_is_commutative n m = (Refl :: Refl (SNat (m + n)) (SNat (n + m)))
{--
-- obviously this doesn't work

{--
Let us delve into the proof:

    0 + m = m + 0
->      

--}

{-
Let us try to look in to the basecase of the proof:

0 + m = m + 0

-}

-- Second try: Use a typesafe case!
plus_is_commutative Zero      m = gcastWith (plus_id_r m) Refl
 
 -- Induction Case!

-- Again, let's see if we can just bypass the type system
--plus_is_commutative (Succ n)  m = Refl
-- Ofcause this does not work. Refl does not satisfy its type


-- Second try: Oh! we already made it! We just call on a strictly decreasing
--plus_is_commutative (Succ n)  m = plus_is_commutative n m
-- Doesn't work. Why?

{--
Now: Let's look into the actual proof

    (S m) + n = n + (S m)
->  S (m + n) = n + (S m) -- By definition of addition
->  S (n + m) = n + (S m) -- By Induction Hypothesis
->  n + (S m) = n + (S m) -- By 
--}
--plus_is_commutative (Succ n) m = gcastwith  Refl

s1 :: SNat (S m) -> SNat n -> SNat (Succ m + n)
s1 (Succ m) Zero     = Succ m
s1 (Succ m) (Succ n) = Succ (s1 (Succ m) n)

-- Testing: This is actually not interesting...
t1 = plus_is_commutative Zero Zero             -- Compiles
t2 = plus_is_commutative Zero (Succ Zero)      -- Compiles
--}

