{-# LANGUAGE GADTs                #-} --  soft dependent types
{-# LANGUAGE PolyKinds            #-} -- Allow general specification of Refl
{-# LANGUAGE RankNTypes           #-} -- The forall stuff
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE TypeFamilies         #-}

module Bool where

import TypeEquality

-- Weird names for not hitting prelude names
data Boolean = Tru | Fls

data SBool (a :: Boolean) where
    STrue  :: SBool Tru
    SFalse :: SBool Fls

type family And (a :: Boolean) (b :: Boolean) :: Boolean
type instance And Tru Tru   = Tru
type instance And Fls Tru   = Fls
type instance And Tru Fls   = Fls
type instance And Fls Fls   = Fls

type family Or (a :: Boolean) (b :: Boolean) :: Boolean
type instance Or Tru Tru   = Tru
type instance Or Fls Tru   = Tru
type instance Or Tru Fls   = Tru
type instance Or Fls Fls   = Fls

type family Not (b :: Boolean) :: Boolean
type instance Not Tru   = Fls
type instance Not Fls   = Tru

-- Proof using quantifiers, but no induction

deMorgan :: SBool a -> SBool b -> Refl (Not (And a b)) (Or (Not a) (Not b))
deMorgan STrue STrue   = Refl
deMorgan STrue SFalse  = Refl
deMorgan SFalse STrue  = Refl
deMorgan SFalse SFalse = Refl