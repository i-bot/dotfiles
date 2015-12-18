import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as XS
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn

import System.IO
import qualified Data.Map.Strict as M

customPP handle = xmobarPP
    { ppOutput = hPutStrLn handle
    , ppTitle = xmobarColor "#fe5000" ""
    }

myModMask = mod4Mask
myTerminal = "urxvtc"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = myModMask
        , terminal = myTerminal
        , normalBorderColor = "#282828"
        , focusedBorderColor = "#387BAB"
        , manageHook = manageSpawn <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP . customPP $ xmproc
        , workspaces = ["1:emacs", "2:web", "3:communication", "4", "5", "6", "7", "8", "9"]
        } `additionalKeys`
        [ ((myModMask, xK_t), spawn myTerminal)
        , ((myModMask, xK_d), spawn "dmenu_run")
        , ((myModMask, xK_c), kill)
        , ((myModMask, xK_f), spawn "firefox")
        , ((myModMask, xK_e), spawn "urxvtc -e emacsclient -t")
        , ((myModMask, xK_p), spawn "~/.bin/touchpad-control toggle")
        , ((myModMask, xK_m), spawn "urxvtc -e emacsclient -t")
        , ((myModMask, xK_o), spawn "client")
        ]
