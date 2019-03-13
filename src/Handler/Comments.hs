{-# LANGUAGE OverloadedStrings #-}

import Import
import Data.Aeson

getCommentsR :: UserId -> PostId -> Handler Value
getCommentsR uid pid = do
  comments <- runDB $ selectList [CommentUserId ==. uid, CommentPostId ==. pid] [] :: Handler [Entity Comment]
  return $ object ["comments" .= comments]

-- comment comes with only text. Ids are added from the URL in the server
postCommentsR :: UserId -> PostId -> Handler ()
postCommentsR uid pid = do
  comment <- requireJsonBody :: Handler Comm
  cid <- runDB $ insert $ toComment uid pid comment
  sendResponseStatus status200 (object ["comment" .= cid]:: Value)

-- "Comment added successfully" :: Text
-- postCommentsR uid pid = do

data Comm = Comm { body :: Text } deriving Show
instance FromJSON Comm where
  parseJSON = withObject "Comm" $ \o -> do
    body_ <- o .: "body"
    return $ Comm body_

toComment :: UserId -> PostId -> Comm -> Comment
toComment uid pid (Comm body__) = Comment body__ pid uid
