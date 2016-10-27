{-# LANGUAGE GADTs                #-} -- Soft dependent types
{-# LANGUAGE PolyKinds            #-} -- Allow general specification of Refl
{-# LANGUAGE RankNTypes           #-} -- The forall stuff
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}

module TypeEquality where

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