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

-- Our type level numerals
data Nat = Z | S Nat deriving Show
{--

Kinds (for values)
Z :: *
S :: * -> *


DataKind makes above into type constructors of following kind
Zero :: Nat
Succ :: Nat -> Nat
--}


data SNat (n :: Nat) where
  Zero :: SNat Z
  Succ :: SNat n -> SNat (S n)

instance Show (SNat n) where
   show Zero     = "Zero"
   show (Succ n) = "Succ " ++ (show n)

type family (+) (n :: Nat) (m :: Nat) :: Nat
type instance (+) Z      m = m
type instance (+) (S m)  n = S (m + n)
