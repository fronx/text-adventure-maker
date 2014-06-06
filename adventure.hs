import Control.Monad (liftM)

data Scene = Scene String [Option]
           deriving Show

data Option = Option String SceneId (Maybe String)
            deriving Show

data SceneId = S_Start
             | S_Adventure
             deriving Show

scene :: SceneId -> Scene
scene S_Start =
  Scene "You are alone at home sitting in front of your computer. What do you do?"
        [ Option "Nothing"
                 S_Start
                 (Just "You do nothing. For a while. Nothing really changes. Hm.")
        , Option "Eat something"
                 S_Start
                 (Just "Nom nom nom. Nom. Nom nom. Nom.")
        , Option "Decide to program a text adventure!"
                 S_Adventure
                 Nothing
        ]
scene S_Adventure =
  Scene "Making text adventures is actually surprisingly easy. Sort of."
        []

printMaybe :: Maybe String -> IO ()
printMaybe (Just s) = putStrLn s
printMaybe _ = return ()

getItemByNumber :: [a] -> IO a
getItemByNumber xs = do
  n <- getUntil getNum withinBounds
  return $ xs!!(n - 1)
  where getNum = liftM read getLine
        withinBounds n = n >= 1 && n <= (length xs)

getUntil :: IO a -> (a -> Bool) -> IO a
getUntil get pred = do
  x <- get
  if pred x then return x else getUntil get pred

showOption :: (Int, Option) -> String
showOption (number, Option text _ _) = show number ++ ") " ++ text

printOptions :: [Option] -> IO ()
printOptions options = mapM_ (putStrLn . showOption)
                             (zip [1..] options)

choose :: [Option] -> IO (Maybe Scene)
choose [] = return Nothing
choose options = do
  printOptions options
  choice <- getItemByNumber options
  let (Option _ nextSceneId transition) = choice
  putStrLn ""; printMaybe transition; putStrLn ""
  return $ Just (scene nextSceneId)

play :: Scene -> IO (Maybe Scene)
play (Scene text options) = do
  putStrLn text
  maybeNextScene <- choose options
  case maybeNextScene of
    Just nextScene -> play nextScene
    _ -> return Nothing -- fin.

main :: IO ()
main = do
  play (scene S_Start)
  return ()
