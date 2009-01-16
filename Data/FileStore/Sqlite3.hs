{- |
   Module      : Data.FileStore.Sqlite3
   Copyright   : Copyright (C) 2008 John MacFarlane
   License     : BSD 3

   Maintainer  : John MacFarlane <jgm@berkeley.edu>
   Stability   : alpha
   Portability : GHC 6.10 required

   A versioned filestore implemented using sqlite3.
   Normally this module should not be imported: import
   "Data.FileStore" instead.
-}

module Data.FileStore.Sqlite3
           ( sqlite3FileStore
           )
where
import Data.FileStore.Types
import System.Exit
import System.IO.Error (isDoesNotExistError)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)
import Data.FileStore.Utils (hashsMatch, isInsideRepo, runShellCommand) 
import Data.ByteString.Lazy.UTF8 (toString)
import qualified Data.ByteString.Lazy as B
import qualified Text.ParserCombinators.Parsec as P
import Codec.Binary.UTF8.String (decodeString)
import Data.Char (chr)
import Control.Monad (liftM, when)
import System.FilePath ((</>), takeDirectory)
import System.Directory (doesDirectoryExist, createDirectoryIfMissing)
import Codec.Binary.UTF8.String (encodeString)
import Control.Exception (throwIO)
import Control.Monad (unless)
import Text.Regex.Posix ((=~))
import System.Directory (getPermissions, setPermissions, executable)
import Paths_filestore

-- | Return a filestore implemented using the sqlite3 distributed revision control system
-- (<http://sqlite3-scm.com/>).
sqlite3FileStore :: FilePath -> FileStore
sqlite3FileStore repo = FileStore {
    fsType            = "Sqlite3"
  , fsPath            = Just repo
  , initialize        = sqlite3Init repo
  , save              = sqlite3Save repo 
  , retrieve          = sqlite3Retrieve repo
  , delete            = sqlite3Delete repo
  , rename            = sqlite3Move repo
  , history           = sqlite3Log repo
  , latest            = sqlite3LatestRevId repo
  , revision          = sqlite3GetRevision repo
  , index             = sqlite3Index repo
  , search            = sqlite3Search repo 
  , idsMatch          = const hashsMatch repo
  }

-- | Initialize a repository, creating the directory if needed.
sqlite3Init :: FilePath -> IO ()
sqlite3Init repo = undefined

-- | Commit changes to a resource.  Raise 'Unchanged' exception if there were
-- no changes.
sqlite3Commit :: FilePath -> [ResourceName] -> Author -> String -> IO ()
sqlite3Commit repo names author logMsg = undefined

-- | Save changes (creating file and directory if needed), add, and commit.
sqlite3Save :: Contents a => FilePath -> ResourceName -> Author -> String -> a -> IO ()
sqlite3Save repo name author logMsg contents = undefined

-- | Retrieve contents from resource.
sqlite3Retrieve :: Contents a
            => FilePath
            -> ResourceName
            -> Maybe RevisionId    -- ^ @Just@ revision ID, or @Nothing@ for latest
            -> IO a
sqlite3Retrieve repo name Nothing = undefined
sqlite3Retrieve repo name (Just revid) = undefined

-- | Delete a resource from the repository.
sqlite3Delete :: FilePath -> ResourceName -> Author -> String -> IO ()
sqlite3Delete repo name author logMsg = undefined

-- | Change the name of a resource.
sqlite3Move :: FilePath -> ResourceName -> ResourceName -> Author -> String -> IO ()
sqlite3Move repo oldName newName author logMsg = undefined

-- | Return revision ID for latest commit for a resource.
sqlite3LatestRevId :: FilePath -> ResourceName -> IO RevisionId
sqlite3LatestRevId repo name = undefined

-- | Get revision information for a particular revision ID, or latest revision.
sqlite3GetRevision :: FilePath -> RevisionId -> IO Revision
sqlite3GetRevision repo revid = undefined

-- | Get list of files in repository.
sqlite3Index :: FilePath -> IO [ResourceName]
sqlite3Index repo = undefined

-- | Uses sqlite3-grep to search repository.
sqlite3Search :: FilePath -> SearchQuery -> IO [SearchMatch]
sqlite3Search repo query = undefined

-- | Return list of log entries for the given time frame and list of resources.
-- If list of resources is empty, log entries for all resources are returned.
sqlite3Log :: FilePath -> [ResourceName] -> TimeRange -> IO [Revision]
sqlite3Log repo names (TimeRange mbSince mbUntil) = undefined

