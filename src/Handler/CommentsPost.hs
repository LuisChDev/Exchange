{-# LANGUAGE OverloadedStrings #-}

module Handler.CommentsPost where

import Import

getCommentsPostR :: PostId -> Handler Value
getCommentsPostR pid = do
  comments <- runDB $ selectList [CommentPostId ==. pid] []
  return $ object ["comments" .= comments]
