; ╓─────────────────────────────────────────╖
; ║ EnumToolTips Function for AutoHotkey -  ║
; ║ Example File; You can find the function ║
; ║ at the bottom of this file.             ║
; ╙─────────────────────────────────────────╜
; ╓──────────────╖
; ║ Init Example ║
; ╙──────────────╜
; ╓────────────╖
; ║ Directives ║
; ╙────────────╜
#SingleInstance,Force
SetBatchLines,-1
SetWinDelay,0
; ╓───────────────╖
; ║ Init ShowCase ║
; ╙───────────────╜
; ╓─────────────────╖
; ║ Vars - ShowCase ║
; ╙─────────────────╜
title := "EnumToolTips Function ShowCase"
extTitle :=  title " for AutoHotkey`nPress:`n<Ctrl>+<Alt>+<Shift>+s`n"
bigMessage =
(
%title% for AutoHotkey
Press:
<Ctrl>+<Alt>+<Shift>+s
to display this showcase.
)
longMessage =
(
This will only showcase a few capabilities 
that this function can provide.

After any enumeration of the tooltips object
(calling and creating the object) you can then
create new tooltips based on various info from
any previous tooltips.

This will loop through the tooltip showcase
3 times; each one exiting slower and slower.
The 3rd iteration will also have it's text
changed while it is being produced.
)
Gui,Font,s10 c0x000000 q2,Segoe UI
Gui,Add,Button,Section x6 gMyShowCase Default,&ShowCase
Gui,Add,Button,x+8 yp gReset,&Reset ToolTips
Gui,Font,s12 c0xFF0000
Gui,Add,Text, xs w400 +Center,%bigMessage%
Gui,Font,s10 c0x000000
Gui,Add,Text,w400 +Center,%longMessage%
Gui,Show,AutoSize,%title%
; return
; ╓──────────────────────────╖
; ║ Hotkeys for this example ║
; ╙──────────────────────────╜
; ╓──────────────────╖
; ║ Ctrl+Alt+Shift+s ║
; ╙──────────────────╜
^!+s::SetTimer,MyShowCase,-1
; ╓───────────────────────╖
; ║ Subs for this example ║
; ╙───────────────────────╜
Reset:
	loop % EnumToolTips().MaxIndex()
	{
		tooltip,,,,%A_Index%
	}
return
MyShowCase:
	tt := ""
	showcaseEnumToolTips() 	 ; default exit speed of * 10 per tooltips index
	showcaseEnumToolTips(20) ; slow down the exit a bit
	SetTimer,ChangeText,1    ; Change the 3rd ShowCase's text
	showcaseEnumToolTips(30) ; slow down the exit a little bit more
return
ChangeText:
; WinWait,ahk_class tooltips_class32
tt := EnumToolTips()
if (tt[tt.MaxIndex()]["text"]!="Replaced Text`n@ ToolTip #" tt.MaxIndex()) {
	tooltip	,	% "Replaced Text`n@ ToolTip #" tt.MaxIndex()
			,	% tt[tt.MaxIndex()]["x"]
			,	% tt[tt.MaxIndex()]["y"]
			,	% tt.MaxIndex() 
}
if (tt.MaxIndex()=20) {
	SetTimer,,Off
}
return
GuiClose:
GuiEscape:
	ExitApp
return
; ╓────────────────────────────╖
; ║ Functions for this example ║
; ╙────────────────────────────╜
; ╓─────────────────────────────────────────╖
; ║ ShowCase Function:                      ║
; ║ While Loop:                             ║
; ║ While the current max index of tooltips ║
; ║ plus 4 more is less than or equal to    ║
; ║ the max allowance of 20 then create     ║
; ║ more tooltips. Iterates a tooltip for   ║
; ║ echo For Loop                           ║
; ║ Inner For Loop:                         ║
; ║ Loop through an associative array of    ║
; ║ Latin to Greek letters and produce a    ║
; ║ tooltip with the cooridnates based on   ║
; ║ the coodinates of previous tooltips     ║
; ╙─────────────────────────────────────────╜
showcaseEnumToolTips(exitSpeed := 10) {
	MouseGetPos,mx,my ; Get current mouse position
	while ((tt.MaxIndex()+4)<=20) {
		tt := EnumToolTips()
		firstX := firstY := true
		for latin, greek in	{	"A":"Alpha","B":"Beta"
							,	"C":"Kappa","D":"Delta"} {
			tt := EnumToolTips()
			if (firstX!="") {
				nextX := tt[tt.MaxIndex()-3]["x"]
				firstX := ""
			} else {
				nextX := (tt.MaxIndex()?nextX():mx)
			}
			if (firstY!="") {
				nextY := tt[tt.MaxIndex()-3]["y"] + tt[tt.MaxIndex()-3]["h"]
				firstY := ""
			} else {
				nextY := (tt.MaxIndex()?nextY():my)
			}
			tt := EnumToolTips()
			tooltip	,	Latin %latin%`nis`nGreek %greek%
					,	% nextX,% nextY,% nextNum()
		}
		tt := EnumToolTips()
	}
	tt := EnumToolTips()
	sleep,3000 ; amount of time before exiting script.
	loop,% tt.MaxIndex()
	{ ; Clean up tooltips. Not necessary, looks nicer ☺
		sleep,% ((tt.MaxIndex()-A_Index) * exitSpeed)
		tooltip,,,,%A_Index%
	}
}
nextNum(){ ; enumerate next tooltip number
	tt := EnumToolTips()
	mi := tt.MaxIndex()
	return (mi?mi + 1:1)
	
}
nextX(){ ; enumerate next tooltip x coordinate
	tt := EnumToolTips()
	return	%	tt.MaxIndex()
			?	(	tt[tt.MaxIndex()].x
				+	tt[tt.MaxIndex()].w)
			:	1
}
nextY(){ ; enumerate next tooltip y coordinate
	tt := EnumToolTips()
	return	%	tt.MaxIndex()
			?	(	tt[tt.MaxIndex()].y
				+	tt[tt.MaxIndex()].h)
			:	1
}
;      ╓──────────────────────────────────────────╖
; <[[[[║ <STRIP TO HERE TO DELETE THIS EXAMPLE>   ║]]]]>
;      ╙──────────────────────────────────────────╜
; ╓─────────────────────────╖
; ║ EnumToolTips() Function ║
; ╙─────────────────────────╜
; ╓────────────────╥───────────────────────────╥────────────╖
; ║ EnumToolTips() ║						   ║ AutoHotkey ║ 
; ╠════════════════╩═══════════════════════════╩════════════╣
; ║ 						@params                         ║
; ╟───────────╥──────────────────────────────────╥──────────╢
; ║   @name   ║    @description/@options         ║ @default ║
; ╟───────────╫──────────────────────────────────╫──────────╢
; ║ coordMode ║ Set CoordMode for tooltips       ║ Screen   ║
; ║           ║ Screen, Relative, Window ,Client ║          ║
; ╠═══════════╩══════════════════════════════════╩══════════╣
; ║     © 2019 Ian Pride - New Pride Software/Services      ║
; ╠═════════════════════════════════════════════════════════╣
; ║ Enumerate information about all current AutoHotkey      ║
; ║ tooltips. The function returns an enumerated index of   ║
; ║ objects with each tips window hwnd (id),string of text  ║
; ║ (text), x & y coordinates (x,y), and the width & height ║
; ║ (w,h).                                                  ║
; ║ ─────────────────────────────────────────────────────── ║                                                        ║
; ║ With each enumeration you can then set the coordinates  ║
; ║ and/or text of any new tooltips based on information    ║
; ║ from any existing tooltips.                             ║
; ╠════════╦════════════════════════════════════════════════╣
; ║ E.g. : ║ For tooltip #1                                 ║
; ╟────────╨────────────────────────────────────────────────╢
; ║ tt := EnumToolTips() =                                  ║
; ║ tooltips Hwnd/Id:                                       ║
; ║ tt.1.id or tt[1].id or tt[1]["id"] or tt.1["id"]        ║
; ║ tooltips text:                                          ║
; ║ tt.1.text or tt[1].text or tt[1]["text"] or tt.1["text"]║
; ║ tooltips x position:                                    ║
; ║ tt.1.x or tt[1].x or tt[1]["x"] or tt.1["x"]            ║
; ║ tooltips y position:                                    ║
; ║ tt.1.y or tt[1].y or tt[1]["y"] or tt.1["y"]            ║
; ║ tooltips width:                                         ║
; ║ tt.1.w or tt[1].w or tt[1]["w"] or tt.1["w"]            ║
; ║ tooltips height:                                        ║
; ║ tt.1.h or tt[1].h or tt[1]["h"] or tt.1["h"]            ║
; ╙─────────────────────────────────────────────────────────╜
EnumToolTips(coordMode := "Screen"){
	tt := "ahk_class tooltips_class32"
	if (WinExist(tt)) {
		CoordMode,ToolTip,%coordMode%
		list := {}
		WinGet,ttList,List,%tt%
		loop,%ttList%
		{
			thisIdx := ((ttList-A_Index)+1)
			list[A_Index] := {}
			list[A_Index].id := ttList%thisIdx%
			workingID := "ahk_id " list[A_Index].id
			ControlGetText,thisText,,%workingID%
			WinGetPos,ttx,tty,ttw,tth,%workingID%
			list[A_Index].x := ttx
			list[A_Index].y := tty
			list[A_Index].w := ttw
			list[A_Index].h := tth 
			list[A_Index].text := thisText
		}
		CoordMode,ToolTip
		return list
	}
}