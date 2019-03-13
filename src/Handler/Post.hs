{-# LANGUAGE OverloadedStrings #-}
module Handler.Post where

import Import

getPostR :: -> PostId -> Handler Post
getPostR uid pid = do
  post <- runDB $ get404 pid

-- put

-- delete
