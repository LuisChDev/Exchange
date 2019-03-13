{-# LANGUAGE OverloadedStrings #-}
module Handler.Posts where

import Import
import Data.Aeson

getPostsR :: UserId -> Handler Value
getPostsR uid = do
  post <- runDB $ selectList [PostUserId ==. uid] []
  return $ object ["posts" .= post]


postPostsR :: UserId -> Handler Value
postPostsR uid = do
  post <- requireJsonBody :: Handler LessPost
  let nPost = insUsr post uid
  kpst <- runDB $ insert nPost
  sendResponseStatus status201 (object ["post key" .= kpst])

insUsr :: LessPost -> UserId -> Post
insUsr (LessPost x y) pid = Post x y pid Nothing


data LessPost = LessPost { title :: Text
                         , body :: Text
                         } deriving Show

instance FromJSON LessPost where
  parseJSON = withObject "LessPost" $ \o -> do
    title_ <- o .: "title"
    body_ <- o .: "body"
    return $ LessPost title_ body_

-- getPostTitle :: LessPost -> Bool -> Text
-- getPostTitle (LessPost x y) title_ = if title_ then x
--                                   else y
