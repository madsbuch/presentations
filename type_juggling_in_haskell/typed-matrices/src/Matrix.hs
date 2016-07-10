{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}

module Matrix where

{- First we build the data type for promotion -}

data Nat = O | S Nat

{- For the sake of understanding we make an example of dependent naturals -}

data SNat (l :: Nat) where
    Zero :: SNat O
    Succ :: SNat l -> SNat (S l)

{- We can now make our length indexed vectors -}

data Vector a (l :: Nat) where
    VNill :: Vector a O
    VCons :: a -> Vector a l -> Vector a (S l)

-- Play with above!

{- We do the same, just with some syntactic sugar -}
infixr 4 :::
data Vec a (l :: Nat) where
    Nill  :: Vec a O
    (:::) :: a -> Vec a l -> Vec a (S l)

-- Play with above! see what happens when you change associativity. Why?

{- A function that only works on list with 5 elements -}

headFive :: Vec a (S (S (S (S (S O))))) -> a
headFive (x ::: _) = x

-- Play with it! why don't we need a the case `headFile Nill`

{- It  should be evident, that it is easy to remove the type information -}
listify :: Vec a n -> [a]
listify Nill        = []
listify (x ::: xs)  = x : (listify xs)

{- We want to be able to see what's in the list -}
instance Show a => Show (Vec a l) where
    show v = show $ listify v 

{- We will soon enough figure out that we are going to use a set of standard
   functions that we are used to from normal lists. Let's implement! -}

vFoldl :: (a -> b -> a) -> a -> Vec b n -> a
vFoldl _ z Nill         = z
vFoldl f z (x ::: xs)   = vFoldl f (f z x) xs

vMap :: (a -> b) -> Vec a n -> Vec b n
vMap f Nill         = Nill
vMap f (x ::: xs)   = (f x) ::: (vMap f xs)

vZipWith :: (a -> b -> c) -> Vec a n -> Vec b n -> Vec c n
vZipWith _ Nill _ = Nill -- Why do we only need to test one?
vZipWith f (x ::: xs) (y ::: ys) = (f x y) ::: (vZipWith f xs ys)

--vFilter :: (a -> Bool) -> Vec a n -> Vec a `Woops, what to do?`
--vFilter _ []        = []
--vFilter f (x : xs) 
--                | f x       = x :::: (vFilter f xs)
--                | otherwise = vFilter f xs

{- OK! now we have the length indexed lists. We want to build matrices -}

data Matrix a (m :: Nat) (n :: Nat) where
    Matrix :: Vec (Vec a m) n -> Matrix a m n

{- Why a boxed datatype? and not like type Matrix a m n = Vec (Vec a m) n ? -}

-- Create a Matrix instance: Matrix $ (1 ::: 2 ::: 3 ::: Nill) ::: (1 ::: 2 ::: 3 ::: Nill) ::: Nill
-- What happens if you try to make an Matrix with non-fitting dimensions?

{- We now have the datatype and can start implementing normal Matrix functionality -}

scale :: Num a => Matrix a m n -> a -> Matrix a m n
scale (Matrix m) v  = Matrix $ vMap (\x -> (vMap (\y -> y*v) x)) m

{- Hmm, we really want to be able to read out information to test above -}

instance Show a => Show (Matrix a m n) where
    show (Matrix m) = vFoldl (\x -> \y -> (show (listify y) ++ "\n" ++ x)) "" m

{- Cool beans! Now we can also debug our operations. Let's implement one of the more
  important operations: The matrix product! -}

transpose :: Matrix a m n -> Matrix a n m
transpose (Matrix v) = error "Implement!"

doTranspose :: Vec (Vec a m) n -> Vec (Vec a n) m
doTranspose (v ::: Nill)        = (doTransposeOne (v ::: Null)) ::: Nill
doTranspose (v ::: vs)          = error "implement"

doTransposeOne :: Vec (Vec a m) n -> Vec a n
doTransposeOne Nill                     = Nill
doTransposeOne ((x ::: _) ::: rest)     = x ::: (doTransposeOne rest)

matrixProduct :: Num a => Matrix a m k -> Matrix a k n -> Matrix a m n 
-- Cool, the dimensions are preserved! the new matrix created afterwards is
-- still safe. But how to implement... The insight is that it is easier to
-- zipWith (*) and then fold with (+)
-- matrixProduct = error "Implement!"

matrixProduct x@(Matrix vx) my = let 
                                    y@(Matrix vy) = transpose my
                                  in
                                    error "implement"