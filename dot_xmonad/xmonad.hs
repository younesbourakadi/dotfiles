-- Imports.
import XMonad
import XMonad.Hooks.DynamicLog
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog 
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Layout.Tabbed
import XMonad.Layout.BinarySpacePartition
import XMonad.Actions.Warp
-- The main function
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Terminal
myTerminal = "urxvt"


myLayout = Full ||| emptyBSP ||| tabbed shrinkText tabConfig
      where

        tabConfig = defaultTheme {
          activeBorderColor = "#7C7C7C",
          activeTextColor = "#CEFFAC",
          activeColor = "#000000",
          inactiveBorderColor = "#7C7C7C",
          inactiveTextColor = "#EEEEEE",
          inactiveColor = "#000000",
          fontName = "xft:monospace:size=9"
        }



-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = def { modMask = mod4Mask
                , terminal = myTerminal
                , borderWidth = 0
                , layoutHook = myLayout
                } `additionalKeys`
                [ 
                ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
                , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -1.5%")
                , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +1.5%")
                , ((mod4Mask .|. mod1Mask,                   xK_l     ), sendMessage $ ExpandTowards R)
                , ((mod4Mask .|. mod1Mask,                   xK_h     ), sendMessage $ ExpandTowards L)
                , ((mod4Mask .|. mod1Mask,                   xK_j     ), sendMessage $ ExpandTowards D)
                , ((mod4Mask .|. mod1Mask,                   xK_k     ), sendMessage $ ExpandTowards U)
                , ((mod4Mask .|. mod1Mask .|. controlMask,   xK_l     ), sendMessage $ ShrinkFrom R)
                , ((mod4Mask .|. mod1Mask .|. controlMask,   xK_h     ), sendMessage $ ShrinkFrom L)
                , ((mod4Mask .|. mod1Mask .|. controlMask,   xK_j     ), sendMessage $ ShrinkFrom D)
                , ((mod4Mask .|. mod1Mask .|. controlMask,   xK_k     ), sendMessage $ ShrinkFrom U)
                , ((mod4Mask,                                xK_r      ), sendMessage Rotate)
                , ((mod4Mask,                                xK_s      ), sendMessage Swap)
                , ((mod4Mask,                                xK_n      ), sendMessage FocusParent)
                , ((mod4Mask .|. controlMask,                xK_n      ), sendMessage SelectNode)
                , ((mod4Mask .|. shiftMask,                  xK_n      ), sendMessage MoveNode)
                , ((mod4Mask .|. shiftMask .|. controlMask,  xK_j      ), sendMessage $ SplitShift Prev)
                , ((mod4Mask .|. shiftMask .|. controlMask,  xK_k      ), sendMessage $ SplitShift Next)
                , ((mod4Mask .|. shiftMask,                  xK_z      ), spawn "xscreensaver-command -lock; xset dpms force off")
                ]
