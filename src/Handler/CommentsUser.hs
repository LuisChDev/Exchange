{-# LANGUAGE OverloadedStrings #-}

module Handler.CommentsUser where

import Import

getCommentsUserR :: UserId -> Handler Value
getCommentsUserR uid = do
  comments <- runDB $ selectList [CommentUserId ==. uid] []
  return $ object ["comments" .= comments]
