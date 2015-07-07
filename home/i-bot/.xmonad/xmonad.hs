import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as XS
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn

import System.IO
import qualified Data.Map.Strict as M

writeTagInfo :: Handle -> X ()
writeTagInfo handle = dynamicLogWithPP xmobarPP
    { ppOutput = hPutStrLn handle
    , ppTitle = xmobarColor "yellow" ""
    }

myModMask = mod4Mask
myTerminal = "urxvtc"

main = do
    leftXmobar <- spawnPipe "xmobar -x 0"
    rightXmobar <- spawnPipe "xmobar -x 1"
    xmonad $ defaultConfig
        { modMask = myModMask
        , terminal = myTerminal
        , normalBorderColor = "#383A3B"
        , focusedBorderColor = "#383A3B"
        , manageHook = manageSpawn <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = do
            writeTagInfo leftXmobar
            writeTagInfo rightXmobar
        } `additionalKeys`
	[ ((myModMask, xK_e), spawnHere "eclipse")
	, ((myModMask, xK_n), spawnHere "nautilus --no-desktop")
	, ((myModMask, xK_t), spawnHere myTerminal)
	, ((myModMask, xK_p), spawnHere "dmenu_run")
        , ((myModMask, xK_c), kill)
	, ((myModMask, xK_f), spawnHere "firefox")
	, ((myModMask, xK_a), spawnHere "androidstudio")
	]
