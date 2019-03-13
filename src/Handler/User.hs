{-# LANGUAGE OverloadedStrings #-}
module Handler.User where

import Import

getUserR :: UserId -> Handler Value
getUserR uid = do
  user <- runDB $ get404 uid
  return $ object ["user" .= (Entity uid user)]

putUserR :: UserId -> Handler Value
putUserR uid = do
  user <- (requireJsonBody :: Handler User)
  runDB $ replace uid user
  sendResponseStatus status200 ("Updated user successfully." :: Text)

deleteUserR :: UserId -> Handler Value
deleteUserR uid = do
  runDB $ delete uid
  sendResponseStatus status200 ("Deleted user successfully." :: Text)
