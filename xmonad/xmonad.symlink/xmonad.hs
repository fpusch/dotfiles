-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (sinkAll, killAll)

-- Data
import Data.Monoid
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName

-- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange)
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

myFont :: String
myFont = "xft:mononoki-Regular Nerd Font Complete Mono:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myEditor :: String
myEditor = myTerminal ++ " - e nvim " -- Set neovim as editor

myBorderWidth :: Dimension
myBorderWidth = 1           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#282c34"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#46d9ff"   -- Border color of focused windows

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom &"
    -- spawnOnce "nm-applet &"
    spawnOnce "xscreensaver --no-splash &"
    --  spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --tint 0x282c34 --transparent true --alpha 0 --height 15 &"
    spawnOnce "feh --randomize --bg-fill ~/wallpapers/*"  -- feh set random wallpaper
    setWMName "LG3D"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

-- Spacing
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts
tall     = renamed [Replace "tall"]
           $ smartBorders
           -- $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 4
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           -- $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           -- $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ mySpacing 4
           $ magnifiercz' 1.3
           $ ThreeCol 1 (3/100) (1/2)

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:mononoki Bold Nerd Font:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| noBorders monocle
                                 ||| threeCol

myWorkspaces = ["www", "music", "dev", "game", "5", "6", "7", "8", "mail"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
        [ ("M-S-q", io exitSuccess)                     -- Quits xmonad

    -- Run prompt
        , ("M-p", spawn "dmenu_run -i -p \"Run: \"")    -- Dmenu
        , ("M-S-p", spawn "/home/fpusch/bin/dm-logout")

    -- Run application
        , ("M-<Return>", spawn (myTerminal))

    -- Lock Screen
        , ("M-S-z", spawn "slock") -- Lock screen with slock

    -- Screenshot
        , ("M-S-f", unGrab *> spawn "scrot -s")

    -- Kill windows
        , ("M-S-c", kill1)                              -- Kill the currently focused client
        , ("M-S-a", killAll)                            -- Kill all windows on current workspace

    -- Workspaces
        , ("M-.", nextScreen)                           -- Switch focus to next monitor
        , ("M-,", prevScreen)                           -- Switch focus to prev monitor

    -- Floating windows
        , ("M-f", sendMessage (T.Toggle "floats"))      -- toggles "floats" layout on / off
        , ("M-t", withFocused $ windows . W.sink)       -- sink current focussed window to tile
        , ("M-S-t", sinkAll)                            -- sink all windows to tile

    -- Windows navigation
        , ("M-m", windows W.focusMaster)                -- Move focus to the master window
        , ("M-j", windows W.focusDown)                  -- Move focus to the next window
        , ("M-k", windows W.focusUp)                    -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster)               -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)                 -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)                   -- Swap focused window with prev window

    -- Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- toggle fullscreen on / off

    -- Scratchpad
        , ("M-s t", namedScratchpadAction myScratchPads "terminal")

    -- Window resizing
        , ("M-h", sendMessage Shrink)                   -- shrink focussed window leftwards
        , ("M-l", sendMessage Expand)                   -- expand focussed window rightwards

    -- Multimedia Keys
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<XF86MonBrightnessUp>", spawn "light -A 5")
        , ("<XF86MonBrightnessDown>", spawn "light -U 5")
        ]

main :: IO ()
main = do
    -- launch xmobar only on one screen
    xmproc1 <- spawnPipe "xmobar -x 0"
    -- launch xmonad
    xmonad $ ewmh $ def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ xmobarPP
            -- settings for xmonad
              { ppOutput = \x -> hPutStrLn xmproc1 x                    -- xmobar on monitor 1
              , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]"     -- Current workspace
              , ppVisible = xmobarColor "#98be65" ""                    -- Visible but not current workspace
              , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""       -- Hidden workspaces
              , ppTitle = xmobarColor "#ffffff" "" . shorten 60         -- Title of active window
              , ppSep =  "<fc=#666666> | </fc>"                         -- Separator character
              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"      -- Urgent workspace
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]              -- order of things in xmobar
              }
        } `additionalKeysP` myKeys
