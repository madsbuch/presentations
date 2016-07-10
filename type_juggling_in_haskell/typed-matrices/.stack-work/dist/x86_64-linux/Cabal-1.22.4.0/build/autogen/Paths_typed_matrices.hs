module Paths_typed_matrices (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/mads/Dropbox/studie/presentations/part_2_type_juggling_in_haskell/typed-matrices/.stack-work/install/x86_64-linux/lts-3.20/7.10.2/bin"
libdir     = "/home/mads/Dropbox/studie/presentations/part_2_type_juggling_in_haskell/typed-matrices/.stack-work/install/x86_64-linux/lts-3.20/7.10.2/lib/x86_64-linux-ghc-7.10.2/typed-matrices-0.1.0.0-8AQsMMN4s8U39ddKQphr96"
datadir    = "/home/mads/Dropbox/studie/presentations/part_2_type_juggling_in_haskell/typed-matrices/.stack-work/install/x86_64-linux/lts-3.20/7.10.2/share/x86_64-linux-ghc-7.10.2/typed-matrices-0.1.0.0"
libexecdir = "/home/mads/Dropbox/studie/presentations/part_2_type_juggling_in_haskell/typed-matrices/.stack-work/install/x86_64-linux/lts-3.20/7.10.2/libexec"
sysconfdir = "/home/mads/Dropbox/studie/presentations/part_2_type_juggling_in_haskell/typed-matrices/.stack-work/install/x86_64-linux/lts-3.20/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "typed_matrices_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "typed_matrices_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "typed_matrices_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "typed_matrices_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "typed_matrices_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
