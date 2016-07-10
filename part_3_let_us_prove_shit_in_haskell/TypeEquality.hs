{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE StandaloneDeriving   #-}
--{-# LANGUAGE NoImplicitPrelude    #-} -- Derfor virker deriving show ikke
{-# LANGUAGE PolyKinds            #-}
{-# LANGUAGE RankNTypes           #-}
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ExplicitNamespaces   #-}

module TypeEquality where

data Refl a b where
  Refl :: Refl a a

instance Show (Refl a b) where
   show Refl     = "Refl"

{--
For playing pleasure
data Nat = Z | S Nat deriving Show

data SNat (n :: Nat) where
  Zero :: SNat Z
  Succ :: SNat n -> SNat (S n)

instance Show (SNat n) where
   show Zero     = "Zero"
   show (Succ n) = "Succ " ++ (show n)

test :: Refl a b -> Refl a b
test x = x
--}

{--
In short: reflexive id - maybe?

Vi giver functionen to typer der er ens, og returnere ellers den samme værdi
som kommer ind i andet argument.

En måde at trætte type ækvivalens på værdi-niveau?

--}
gcastWith :: Refl a b -> ((a ~ b) => r) -> r
gcastWith Refl x = x
