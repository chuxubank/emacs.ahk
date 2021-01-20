;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2 ; A window's title can contain WinTitle anywhere inside it to be a match. 
#UseHook On ; Make it a bit slow, but can avoid infinitude loop. Same as "$" for each hotkey
#InstallKeybdHook ; For checking key history. Use ~500kB memory?
#HotkeyInterval 2000 ; Hotkey interval (default 2000 milliseconds).
#MaxHotkeysPerInterval 70 ; Max hotkeys per interval (default 50).

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0
; turns to be 1 when ctrl-s is pressed
is_pre_search = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class Emacs ; Emacs
    Return 1
  IfWinActive,ahk_exe scrcpy.exe
    Return 1
  IfWinActive,ahk_class SunAwtFrame ; IDEA
    Return 1
  IfWinActive,ahk_class vcxsrv/x X rl ; Emacs
  Return 1
  IfWinActive Fluent Terminal
    Return 1
  IfWinActive,ahk_exe WindowsTerminal.exe
    Return 1
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1 
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1 
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
  Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
  ; IfWinActive,ahk_class SWT_Window0 ; Eclipse
  ;   Return 1
  ; IfWinActive,ahk_class Xming X
  ;   Return 1
  ; IfWinActive,ahk_class Emacs ; NTEmacs
  ;   Return 1  
  ; IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
  ;   Return 1
  Return 0
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}
kill_word()
{
  Send +^{Right}
  kill_region()
  Return
}
backward_kill_word()
{
  Send +^{Left}
  kill_region()
  Return
}
kill_line()
{
  Send {Shift down}{End}{Shift up}
  Sleep 50 ;[ms] this value depends on your environment
  kill_region()
  Return
}
open_line()
{
  Send {End}{Enter}{Up}
  global is_pre_spc = 0
  Return
}
quit()
{
  global 
  is_pre_spc = 0
  is_pre_x = 0
  is_pre_search = 0
  Send {ESC}
  Return
}
newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}
indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}
newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}
isearch_forward()
{
  global
  If is_pre_search
    Send {Enter}
  Else
    Send ^f
  is_pre_spc = 0
  is_pre_search = 1
  Return
}
isearch_backward()
{
  global
  If is_pre_search
    Send +{Enter}
  Else
    Send ^f
  is_pre_spc = 0
  is_pre_search = 1
  Return
}
kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}
comment_dwim()
{
  Send ^/
  global is_pre_spc = 0
  Return
}
kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}
yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}
undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}
redo()
{
  Send +^z
  global is_pre_spc = 0
  Return
}
find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}
save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}
kill_buffer()
{
  Send ^w
  global is_pre_x = 0
  Return
}
kill_emacs()
{
  Send !{F4}
  global is_pre_x = 0
  Return
}

select_all()
{
  Send ^a
  global is_pre_x = 0
  Return
}

move_beginning_of_line()
{
  global
  If is_pre_spc
    Send +{Home}
  Else
    Send {Home}
  Return
}
move_end_of_line()
{
  global
  If is_pre_spc
    Send +{End}
  Else
    Send {End}
  Return
}

move_to_beginning()
{
  global
  If is_pre_spc
    Send +^{Home}
  Else
    Send ^{Home}
  Return
}
move_to_end()
{
  global
  If is_pre_spc
    Send +^{End}
  Else
    Send ^{End}
  Return
}

previous_line()
{
  global
  If is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}
next_line()
{
  global
  If is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  If is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  If is_pre_spc
    Send +{Left} 
  Else
    Send {Left}
  Return
}

forward_word()
{
  global
  If is_pre_spc
    Send +^{Right}
  Else
    Send ^{Right}
  Return
}
backward_word()
{
  global
  If is_pre_spc
    Send +^{Left}
  Else
    Send ^{Left}
  Return
}

scroll_up()
{
  global
  If is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  If is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}

^x::
  If is_target()
    Send %A_ThisHotkey%
  Else
    is_pre_x = 1
Return 
^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      find_file()
    Else
      forward_char()
  }
Return 
^c::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_emacs()
  }
Return 
^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_char()
Return
!d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_word()
Return
!BS::
  If is_target()
    Send !{BS}
  Else
    backward_kill_word()
Return
k::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_buffer()
    Else
      Send %A_ThisHotkey%
  }
Return
^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_buffer()
    Else
      kill_line()
  }
Return
;; ^o::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     open_line()
;;   Return
^g::
  If is_target()
    Send %A_ThisHotkey%
  Else
    quit()
Return
;; ^j::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     newline_and_indent()
;;   Return
^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
Return
^i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
Return
^s::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      save_buffer()
    Else
      isearch_forward()
  }
Return
^r::
  If is_target()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
Return
^w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_region()
Return
!w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_ring_save()
Return
^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
Return
^/::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
Return
+!_::
  If is_target()
    Send %A_ThisHotkey%
  Else
    redo()
Return

;$^{Space}::
;^vk20sc039::
^vk20::
  If is_target()
    Send {CtrlDown}{Space}{CtrlUp}
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
Return
^@::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
Return
^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
Return
^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
Return
^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
Return
^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
Return
^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
Return
^v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_down()
Return
!v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_up()
Return

!f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    forward_word()
Return
!b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_word()
Return
!<::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_to_beginning()
Return
!>::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_to_end()
Return
h::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      select_all()
    Else
      Send %A_ThisHotkey%
  }
Return
!;::
If is_target()
  Send %A_ThisHotkey%
Else
  comment_dwim()
Return